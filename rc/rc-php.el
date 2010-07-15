(require 'php-mode)
;;(require 'php-electric)
(setq auto-mode-alist
      (cons '("\\.\\(php\\)\\'" . php-mode)
	    auto-mode-alist))
(defun pear-php-mode-hook ()
  (setq c-basic-offset 4)) ;for the funmobile's rule
(add-hook 'php-mode-hook 'pear-php-mode-hook)


(setq phpcmp-persistent-document-buffer "*phpcmp persistent doc*")

(defun phpcmp-popup-document-persistent-action (candidate)
  (interactive)
  (let ((docstring (phpcmp-get-document-string candidate))
	(b (get-buffer-create phpcmp-persistent-document-buffer)))
    (with-current-buffer b
      (erase-buffer)
      (insert docstring)
      (goto-char (point-min)))
    (pop-to-buffer b)))

(defun my-phpcmp-make-completion-sources ()
  (labels ((make-source (&key name candidates)
			`((name . ,name)
			  (init . (lambda ()
				    (with-current-buffer (anything-candidate-buffer 'global)
				      (insert (mapconcat 'identity
							 (if (functionp ',candidates)
							     (funcall ',candidates)
							   ',candidates)
							 "\n")))))
			  (candidates-in-buffer)
			  (action . (("Insert" . (lambda (candidate)
						   (delete-backward-char (length phpcmp-initial-input))
						   (insert candidate)))
				     ("Search". (lambda (candidate)
						  (phpcmp-search-manual candidate)))))
			  (persistent-action . phpcmp-popup-document-persistent-action))))
    (loop for (name candidates) in (phpcmp-completions-table)
          collect (make-source
                   :name name
                   :candidates candidates))))

(defun my-phpcmp-complete ()
  (interactive)
  (anything (my-phpcmp-make-completion-sources)
            (phpcmp-get-initial-input)))

;; add hook
(add-hook 'php-mode-hook
          (lambda ()
            (require 'php-completion)
            (php-completion-mode t)
            (define-key php-mode-map (kbd "C-o") 'phpcmp-complete)))
	    ;;(define-key php-mode-map (kbd "C-o") 'my-phpcmp-complete)))

;; for xdebug
(add-to-list 'load-path "~/.emacs.d/site-lisp/geben-0.25")
(autoload 'geben "geben" "PHP Debugger on Emacs" t)