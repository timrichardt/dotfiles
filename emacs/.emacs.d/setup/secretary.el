(provide 'secretary)
(require 'util)
(require 'cal-iso)
(require 'org)
(require 'org-habit)
(require 'org-caldav)
(require 'solar)
(require 'weather-metno)
(require 'org-weather-metno)
(require 'org-journal)
(require 'org-bullets)


(extend-mode-map global-map
  "C-c c" 'org-capture
  "C-c a" 'org-agenda
  "C-c b" 'org-iswitchb)


;; --------------------
;; Calendar

(setq calendar-latitude                52.5166667
      calendar-longitude               13.4
      calendar-location-name           "Berlin"
      calendar-time-zone               +60
      calendar-standard-time-zone-name "CET"
      calendar-daylight-time-zone-name "CEST"
      display-time-24hr-format         1
      calendar-week-start-day          1
      calendar-day-name-array          ["Sonntag" "Montag" "Dienstag" "Mittwoch"
					"Donnerstag" "Freitag" "Sonnabend"]
      calendar-month-name-array        ["Januar" "Februar" "März" "April" "Mai"
					"Juni" "Juli" "August" "September"
					"Oktober" "November" "Dezember"]
      calendar-day-abbrev-array        ["Son" "Mon" "Die" "Mit" "Don" "Fre" "Sbd"]
      calendar-date-display-form       '(dayname ", der " day ". " monthname " " year)
      solar-n-hemi-seasons             '("Frühlingsanfang" "Sommeranfang"
					 "Herbstanfang" "Winteranfang")
      org-directory                    "~/org/"
      org-default-notes-file           (concat org-directory "notes.org")
      org-agenda-files                 `(,org-default-notes-file
					 ,(concat org-directory "geburtstage.org")
					 ,(concat org-directory "caldav.org")
					 ,(concat org-directory "habits.org")
					 ,(concat org-directory "34c3.org")
					 "/home/tim/science/sbarith/article.org")
      org-agenda-format-date           'format-date-german
      org-agenda-restore-windows-after-quit t
      org-agenda-window-setup          'reorganize-frame
      org-agenda-custom-commands       '(("c" "Agenda"
					  ((agenda "")
					   (alltodo))))
      org-agenda-start-day             "-1d"
      org-agenda-span                  4
      org-agenda-start-on-weekday      nil
      org-agenda-auto-exclude-function nil
      org-use-tag-inheritance          nil
      org-agenda-time-grid             '((daily today require-timed remove-match)
      					 (600 800 1000 1200 1400 1600 1800 2000 2200)
      					 "     "
      					 "----------------")
      org-agenda-deadline-leaders      '("Deadline:  "
					 "+%d Tage:   "
					 "Überfällig:")
      org-agenda-scheduled-leaders     '("Geplant:   "
					 "Überfällig:")
      org-agenda-todo-ignore-deadlines t
      org-agenda-todo-ignore-scheduled t

      org-caldav-url                   "https://caldav.plskthx.org/caldav.php/tim"
      org-caldav-calendar-id           "calendar" 
      org-caldav-inbox                 "~/org/caldav.org"
      org-caldav-files                 '("~/org/caldav.org")
      
      org-habit-graph-column           32
      org-habit-preceding-days         42
      org-habit-following-days         5
      org-habit-show-habits-only-for-today t
      org-habit-show-all-today         t
      org-habit-completed-glyph        ?+
      org-habit-today-glyph            ?!

      org-journal-dir                  "~/org/journal"
      org-journal-date-format          (lambda (time)
					 
					 (concat
					  org-journal-date-prefix
					  (calendar-date-string (calendar-current-date)
								nil))))



(add-to-list 'org-modules 'org-habits)

(add-hook 'org-mode-hook (lambda ()
			   (org-bullets-mode 1)))

(defun org-caldav-url-dav-get-properties (url property)
  "Retrieve PROPERTY from URL.
Output is the same as `url-dav-get-properties'.  This switches to
OAuth2 if necessary."
  (let ((request-data (concat "<?xml version=\"1.0\" encoding=\"utf-8\" ?>\n"
			      "<DAV:propfind xmlns:DAV='DAV:'>\n<DAV:prop>"
			      "<DAV:" property "/></DAV:prop></DAV:propfind>\n"))
	(extra '(("Depth" . "1") ("Content-type" . "text/xml"))))
    (let ((resultbuf (org-caldav-url-retrieve-synchronously
		      url "PROPFIND" request-data extra)))
      (org-caldav-namespace-bug-workaround resultbuf)
      ;; HACK: remove DAV:responses with empty properties
      (with-current-buffer resultbuf
        (save-excursion
          (while (re-search-forward "<DAV:response>" nil t)
            (let ((begin (point))
                  (end (progn (re-search-forward "</DAV:response>" nil t) (+ (point) 15))))
              (when (and begin end)
                (goto-char begin)
                (if (and (re-search-forward "<DAV:prop/>" nil t) (< (point) end))
                    (progn
                      (goto-char end)
                      (delete-region begin end))
                  (goto-char end)))))))
      (url-dav-process-response resultbuf url))))

(defun format-date-german (date)
  "German date formatting for the agenda	.	For example
    
    Montag, der 27. Februar 2017 (09. Kalenderwoche)"
  (let* ((dayname     (calendar-day-name date))
         (day         (cadr date))
         (day-of-week (calendar-day-of-week date))
         (month       (car date))
         (monthname   (calendar-month-name month))
         (year        (nth 2 date))
         (iso-week    (org-days-to-iso-week
		       (calendar-absolute-from-gregorian date)))
         (weekyear    (cond ((and (= month 1) (>= iso-week 52))
			     (1- year))
			    ((and (= month 12) (<= iso-week 1))
			     (1+ year))
			    (t year)))
         (weekstring  (if (= day-of-week 1)
			  (format " (%d. Kalenderwoche)" iso-week)
			"")))
    (format "%s, der %d. %s %d%s"
            dayname day monthname year weekstring)))


;; --------------------
;; Weather Metno

(setq weather-metno-location-name      "Berlin"
      weather-metno-location-latitude  calendar-latitude
      weather-metno-location-longitude calendar-longitude
      weather-metno-get-image-props    '(:width 16 :height 16 :ascent center)
      org-weather-metno-format         "{symbol|:symbol} {temperature-min}°C bis {temperature-max}°C und {precipitation-max}mm Niederschlag"
      org-weather-metno-query          (quote (list :get temperature
						    :name temperature-max
						    :select value
						    :each string-to-number
						    :max :get temperature
						    :name temperature-min
						    :select value
						    :each string-to-number
						    :min
						    :get temperature
						    :name temperature-avg
						    :select value
						    :each string-to-number
						    :reduce org-weather-metno~q-avg
						    :get precipitation
						    :name precipitation-max
						    :select value
						    :each string-to-number
						    :max :get symbol
						    :select number
						    :each string-to-number
						    :max)))


(defun org-weather-metno ()
  "A replacement for `org-weather-metno`. Displays the weather
data at the time of sunrise."
  (unless weather-metno--data
    (weather-metno-update))

  (let ((l (solar-sunrise-sunset date))
	(entry "")
	(query-data (eval `(weather-metno-query
			    (weather-metno--data nil date)
			    ,@org-weather-metno-query))))
    (concat
     (if query-data
	 (weather-metno-query-format
	  org-weather-metno-format
	  query-data
	  nil "org-weather-metno--f-" "?")
       "Keine Wettervorhesage")
     " "
     (when (car l)
       (solar-time-string (caar l) nil)))))


(defun diary-sunset ()
  "Local time of sunset as a diary entry.
The diary entry can contain `%s' which will be replaced with
`calendar-location-name'."
  (let ((l (solar-sunrise-sunset date)))
    (when (cadr l)
      (concat
       (if (string= entry "")
           "Sonnenuntergang in Berlin"
         (format entry (eval calendar-location-name))) " "
         (solar-time-string (caadr l) nil)))))
