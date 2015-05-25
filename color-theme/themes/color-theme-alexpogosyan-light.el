(require 'color-theme)

(defun color-theme-alexpogosyan-light ()
  (interactive)
  (color-theme-install
   '(color-theme-alexpogosyan-light
     ((background-color . "#f0f0f0")
      (background-mode . light)
      (border-color . "#969696")
      (cursor-color . "#000000")
      (foreground-color . "#000000")
      (mouse-color . "black"))
     (fringe ((t (:background "#969696"))))
     (mode-line ((t (:foreground "#ffffff" :background "#595959"))))
     (region ((t (:background "#666666"))))
     (font-lock-builtin-face ((t (:foreground "#f820b4"))))
     (font-lock-comment-face ((t (:foreground "#7d827d"))))
     (font-lock-function-name-face ((t (:foreground "#102cc1"))))
     (font-lock-keyword-face ((t (:foreground "#7299ff"))))
     (font-lock-string-face ((t (:foreground "#c77429"))))
     (font-lock-type-face ((t (:foreground"#199915"))))
     (font-lock-variable-name-face ((t (:foreground "#e6a00f"))))
     (minibuffer-prompt ((t (:foreground "#7299ff" :bold t))))
     (font-lock-warning-face ((t (:foreground "Red" :bold t))))
     )))
(provide 'color-theme-alexpogosyan-light)