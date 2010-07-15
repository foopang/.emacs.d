(load "~/.emacs.d/site-lisp/nxhtml/autostart.el")

(add-to-list 'load-path "~/.emacs.d/site-lisp/zencoding/")
(require 'zencoding-mode)
;;(add-hook 'sgml-mode-hook 'zencoding-mode)
(add-hook 'nxhtml-mode-hook 'zencoding-mode)


;;(setq yas/trigger-key (kbd "C-c <kp-multiply>"))

;;(define-key python-mode-map "\t" 'ryan-python-tab)

;;(define-key zencoding-mode-keymap (kbd "\t") 'zencoding-expand-line)

;;(setq yas/trigger-key (kbd "C-c <kp-multiply>"))
;;(define-key sgml-mode-map "\t" 'yas/expand)
;;(define-key zencoding-mode-keymap (kbd "\t") 'yas/expand)
;;(define-key nxhtml-mode-map "\t" 'zencoding-expand-line)
(define-key nxhtml-mode-map (kbd "C-z") 'zencoding-expand-line)
;;(define-key zencoding-mode-keymap (kbd "\t") 'zencoding-expand-yas)
;;(add-hook 'nxhtml-mode-hook
;;          (lambda ()
;;            (set (make-local-variable 'yas/fallback-behavior) 'zencoding-expand-yas)))


;;(setq-default yas/fallback-behavior '(apply my-anything-c-yas-complete))

;;(setq-default yas/fallback-behavior '(apply zencoding-expand-line))


;;(eval-after-load 'js2-mode
;;  '(progn
;;     (define-key js2-mode-map (kbd "TAB") (lambda()
;;                                            (interactive)
;;                                            (let ((yas/fallback-behavior 'return-nil))
;;                                              (unless (yas/expand)
;;                                                (indent-for-tab-command)
;;                                                (if (looking-back "^\s*")
;;                                                    (back-to-indentation))))))))

