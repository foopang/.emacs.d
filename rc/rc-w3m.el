(add-to-list 'load-path "~/.emacs.d/site-lisp/w3m")
;;(if window-system
;;    (require 'w3m-load))
(require 'w3m-load)
(setq browse-url-browser-function 'w3m-browse-url)
;;(autoload 'w3m-browse-url "w3m" "Ask a WWW browser to show a URL." t)
;; optional keyboard short-cut
;;(global-set-key "\C-xm" 'browse-url-at-point)

;;(setq w3m-use-cookies t)
