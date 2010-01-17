;;(add-hook 'find-file-hooks 'auto-insert)
(auto-insert-mode)  ;;; Adds hook to find-files-hook
(setq auto-insert-query nil) ;;; If you don't want to be prompted before insertion
(setq auto-insert-directory "~/.emacs.d/auto-insert/")

(define-auto-insert "\.php" "my-php-template.php")
