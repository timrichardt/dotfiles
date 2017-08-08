(provide 'secretary)
(require 'util)
(require 'cal-iso)
(require 'org)
(require 'org-habit)
(require 'solar)
(require 'weather-metno)

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
      solar-n-hemi-seasons             '("Frühlingsanfang" "Sommeranfang"
					 "Herbstanfang" "Winteranfang")
      org-directory                    "~/org/"
      org-default-notes-file           (concat org-directory "notes.org")
      org-agenda-files                 `(,org-default-notes-file
					 ,(concat org-directory "geburtstage.org"))
      org-agenda-format-date           'format-date-german
      org-agenda-restore-windows-after-quit t
      org-agenda-window-setup          'reorganize-frame

      org-agenda-auto-exclude-function nil
      org-use-tag-inheritance           nil
      org-agenda-time-grid             '((daily today require-timed remove-match)
					 #("----------------" 0 16
					   (org-heading t))
					 (800 1000 1200 1400 1600 1800 2000))
      org-agenda-deadline-leaders      '("Deadline:  "
					 "+%d Tage:   "
					 "Überfällig:")
      org-agenda-scheduled-leaders     '("Geplant:   "
					 "Überfällig:")
      org-agenda-todo-ignore-deadlines t
      org-agenda-todo-ignore-scheduled t
      
      org-habit-graph-column           32
      org-habit-preceding-days         42
      org-habit-following-days         5
      org-habit-show-habits-only-for-today t
      org-habit-show-all-today         t
      org-habit-completed-glyph        ?+
      org-habit-today-glyph            ?!)


(add-to-list 'org-modules 'org-habits)

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
