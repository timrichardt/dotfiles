(provide 'haskell)
(require 'util)

(extend-mode-map haskell-mode-map
  "C-c C-c" 'haskell-compile)

(extend-mode-map haskell-cabal-mode-map
  "C-c C-c" 'haskell-compile)
