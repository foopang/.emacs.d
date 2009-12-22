(eval-when-compile
  (require 'color-theme))

; Code start.
(defun color-theme-jeff ()
  (interactive)
  (color-theme-install
   '(color-theme-jeff
     ((background-color . "#F8F8F8")
      (foreground-color . "#000000")
      (cursor-color . "#000000"))
     (default ((t (nil))))
     (modeline ((t (:background "FFFFFF" :foreground "000000" :box (:line-width 1 :style released-button)))))
     (font-lock-builtin-face ((t (:foreground "#000080"))))
     (font-lock-comment-face ((t (:italic t :foreground "#808080"))))
     (font-lock-constant-face ((t (:foreground "#008000"))))
     (font-lock-doc-string-face ((t (:foreground "#65B042"))))
     (font-lock-string-face ((t (:background "#E6FFFF" :foreground "#000000"))))
     (font-lock-function-name-face ((t (:foreground "#960000" :italic t))))
     (font-lock-keyword-face ((t (:foreground "#000080"))))
     (font-lock-type-face ((t (:underline nil :foreground "#C25338"))))
     (font-lock-variable-name-face ((t (:foreground "#960000"))))
     (font-lock-warning-face ((t (:bold t :foreground "#FD5FF1"))))
     (highlight-80+ ((t (:background "#CEFF84"))))
     (hl-line ((t (:background "#CEFF84"))))
     (region ((t (:background "#CEFF84"))))
     (semantic-decoration-on-unparsed-includes ((t (:background "#CEFF84"))))
     (ido-subdir ((t (:foreground "#F1266F"))))
    )
  )
)
(provide 'color-theme-jeff)
;---------------
; Code end.