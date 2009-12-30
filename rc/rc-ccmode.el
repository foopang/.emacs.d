(require 'cc-mode)
 
;; customisation of cc-mode
(defun alexott/c-mode-common-hook ()
  ;; style customization
  ;(c-set-offset 'member-init-intro '++)
  (setq tab-width 4)
  (setq indent-tabs-mode nil)
  ;(c-set-offset 'substatement-open 0)
  ;(c-set-style "bsd")
  (setq c-basic-offset 4)
  ;(c-toggle-auto-hungry-state 0)
  ;; minor modes
  ;(auto-fill-mode 1)
  ;(turn-on-eldoc-mode)
  ;(gtags-mode 1)
  ;(hs-minor-mode 1)
  ;; local keys
  ;(local-set-key [return] 'newline-and-indent)
  ;; (local-set-key [delete] 'delete-char)
  )

(add-hook 'c-mode-common-hook 'alexott/c-mode-common-hook)
;;(add-hook 'c-mode-common-hook 'alexott/common-hook)
;;(add-hook 'c-mode-common-hook 'alexott/show-prog-keywords)