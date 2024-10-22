;; use only one desktop
(setq desktop-path '("~/.emacs.d/"))
(setq desktop-dirname "~/.emacs.d/")
(setq desktop-base-file-name "emacs-desktop")

;; remove desktop after it's been read
;; (add-hook 'desktop-after-read-hook
;;    	  '(lambda ()
;;    	     ;; desktop-remove clears desktop-dirname
;;    	     (setq desktop-dirname-tmp desktop-dirname)
;;    	     (desktop-remove)
;;    	     (setq desktop-dirname desktop-dirname-tmp)))

(defun saved-session ()
  (file-exists-p (concat desktop-dirname "/" desktop-base-file-name)))

;; use session-restore to restore the desktop manually
(defun session-restore ()
  "Restore a saved emacs session."
  (interactive)
  (if (saved-session)
      (desktop-read)
    (message "No desktop found.")))

;; use session-save to save the desktop manually
(defun session-save ()
  "Save an emacs session."
  (interactive)
  (if (saved-session)
      (if (y-or-n-p "Overwrite existing desktop? ")
	  (desktop-save-in-desktop-dir)
	(message "Session not saved."))
  (desktop-save-in-desktop-dir)))

;; (add-hook 'emacs-startup-hook
;;           (lambda () (when (cl-notany 'buffer-file-name (buffer-list))
;;            (set-q open-with-file t))))

;; ask user whether to restore desktop at start-up
(add-hook 'after-init-hook
	  '(lambda ()
	     (if (and (saved-session) window-system)
		 (if (y-or-n-p "Restore desktop? ")
		     (session-restore)))))

;; ask use whether to save session when kill
(add-hook 'kill-emacs-hook
          '(lambda ()
             (if (and (saved-session) window-system)
              (if (y-or-n-p "Save current session? ")
                 (desktop-save-in-desktop-dir)
               (message "Session not saved.")))))

(provide 'custom-desktop-save-mode)
