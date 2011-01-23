(require 'python)
(require 'auto-complete)
;;(add-to-list 'load-path "~/.emacs.d/site-lisp/yasnippet-0.5.9/")
;;(require 'yasnippet)

(autoload 'python-mode "python-mode" "Python Mode." t)
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
(add-to-list 'interpreter-mode-alist '("python" . python-mode))

;; Initialize Pymacs                                                         
(add-to-list 'load-path "~/.emacs.d/site-lisp/Pymacs-0.24-beta1/")
(autoload 'pymacs-apply "pymacs")
(autoload 'pymacs-call "pymacs")
(autoload 'pymacs-eval "pymacs" nil t)
(autoload 'pymacs-exec "pymacs" nil t)
(autoload 'pymacs-load "pymacs" nil t)
;; Initialize Rope                                              
;;(add-to-list 'load-path "~/.emacs.d/site-lisp/yasnippet-0.5.9/")
(pymacs-load "ropemacs" "rope-")
(define-key ropemacs-local-keymap (kbd "M-/") 'dabbrev-expand)
;;(define-key ropemacs-local-keymap (kbd "C-/") 'hippie-expand)
(define-key ropemacs-local-keymap (kbd "C-c C-/") 'rope-code-assist)

(setq ropemacs-enable-autoimport t)

;; Initialize auto-complete
(setq ac-candidate-menu-height 25)
(setq ac-candidate-max 25)
(define-key ac-complete-mode-map "\C-n" 'ac-next)
(define-key ac-complete-mode-map "\C-p" 'ac-previous)

(defun flymake-create-temp-in-system-tempdir (filename prefix)
  (make-temp-file (or prefix "flymake")))

;; Python or python mode?
(eval-after-load 'python
  '(progn
     (when (load "flymake" t)
       (defun flymake-pylint-init (&optional trigger-type)
	 (let* ((temp-file (flymake-init-create-temp-buffer-copy
			    'flymake-create-temp-in-system-tempdir))
		(local-file (file-relative-name
			     temp-file
			     (file-name-directory buffer-file-name)))
		(options (when trigger-type (list "--trigger-type" trigger-type))))
	   (list "~/.emacs.d/flymake/pyflymake.py" (append options (list local-file)))))

       (add-to-list 'flymake-allowed-file-name-masks
		    '("\\.py\\'" flymake-pylint-init)))


     ;; (when (load "flymake" t) 
     ;;   (defun flymake-pyflakes-init () 
     ;; 	 (let* ((temp-file (flymake-init-create-temp-buffer-copy 
     ;; 			    ;;'flymake-create-temp-inplace
     ;; 			    'flymake-create-temp-in-system-tempdir
     ;; 			    )) 
     ;; 		(local-file (file-relative-name 
     ;; 			     temp-file 
     ;; 			     (file-name-directory buffer-file-name)))) 
     ;; 	   ;;(list "pyflakes" (list local-file))
     ;; 	   (list "~/.emacs.d/script/pyflymake.py" (list local-file))
     ;; 	   )) 

     ;;   (add-to-list 'flymake-allowed-file-name-masks 
     ;; 		    '("\\.py\\'" flymake-pyflakes-init)))
     
     ;;(add-hook 'find-file-hook 'flymake-find-file-hook)
     (add-hook 'python-mode-hook 'flymake-mode)
     ))



;; Initialize Yasnippet                                                                                        
;Don't map TAB to yasnippet                                                                                    
;In fact, set it to something we'll never use because                                                          
;we'll only ever trigger it indirectly.                                                                        
;;;;;(setq yas/trigger-key (kbd "C-c <kp-multiply>"))
;;(yas/initialize)
;;(yas/load-directory "~/.emacs.d/plugins/yasnippet-0.6.1c/snippets")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Auto-completion
;;; Integrates:
;;; 1) Rope
;;; 2) Yasnippet
;;; all with AutoComplete.el
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun prefix-list-elements (list prefix)
  (let (value)
    (nreverse
     (dolist (element list value)
       (setq value (cons (format "%s%s" prefix element) value))))))
(defvar ac-source-rope
  '((candidates
     . (lambda ()
         (prefix-list-elements (rope-completions) ac-target))))
  "Source for Rope")
(defun ac-python-find ()
  "Python `ac-find-function'."
  (require 'thingatpt)
  (let ((symbol (car-safe (bounds-of-thing-at-point 'symbol))))
    (if (null symbol)
        (if (string= "." (buffer-substring (- (point) 1) (point)))
            (point)
          nil)
      symbol)))
(defun ac-python-candidate ()
  "Python `ac-candidates-function'"
  (let (candidates)
    (dolist (source ac-sources)
      (if (symbolp source)
          (setq source (symbol-value source)))
      (let* ((ac-limit (or (cdr-safe (assq 'limit source)) ac-limit))
             (requires (cdr-safe (assq 'requires source)))
             cand)
        (if (or (null requires)
                (>= (length ac-target) requires))
            (setq cand
                  (delq nil
                        (mapcar (lambda (candidate)
                                  (propertize candidate 'source source))
                                (funcall (cdr (assq 'candidates source)))))))
        (if (and (> ac-limit 1)
                 (> (length cand) ac-limit))
            (setcdr (nthcdr (1- ac-limit) cand) nil))
        (setq candidates (append candidates cand))))
    (delete-dups candidates)))
(add-hook 'python-mode-hook
          (lambda ()
	    (auto-complete-mode 1)
	    (set (make-local-variable 'ac-sources)
		 (append ac-sources '(ac-source-rope)))
	    (set (make-local-variable 'ac-find-function) 'ac-python-find)
	    (set (make-local-variable 'ac-candidate-function) 'ac-python-candidate)
	    (set (make-local-variable 'ac-auto-start) nil)))

;;Ryan's python specific tab completion
					; Try the following in order:
					; 1) Try a yasnippet expansion without autocomplete
					; 2) If at the beginning of the line, indent
					; 3) If at the end of the line, try to autocomplete
					; 4) If the char after point is not alpha-numerical, try autocomplete
					; 5) Try to do a regular python indent.
					; 6) If at the end of a word, try autocomplete.
;;(define-key python-mode-map "\t" 'yas/expand)
;; (add-hook 'org-mode-hook
;;           (let ((original-command (lookup-key org-mode-map [tab])))
;;             `(lambda ()
;;                (setq yas/fallback-behavior
;;                      '(apply ,original-command))
;;                (local-set-key [tab] 'yas/expand))))

(add-hook 'python-mode-hook
           (lambda ()
 	    (setq yas/fallback-behavior  '(apply ryan-python-expand-after-yasnippet))
	;'ryan-python-expand-after-yasnippet)	    
 	    ;(local-set-key [tab] 'yas/expand)
 	    ))

	    ;(set (make-local-variable 'yas/fallback-behavior) 'ryan-python-expand-after-yasnippet)
            ;(set (make-local-variable 'yas/trigger-fallback) 'ryan-python-expand-after-yasnippet)
	    
;;	    ))
(defun ryan-indent ()
  "Runs indent-for-tab-command but returns t if it actually did an indent; nil otherwise"
  (let ((prev-point (point)))
    (indent-for-tab-command)
    (if (eql (point) prev-point)
        nil
      t)))
(defun ryan-python-expand-after-yasnippet ()
  (interactive)
  ;;2) Try indent at beginning of the line
  (let ((prev-point (point))
        (beginning-of-line nil))
    (save-excursion
      (move-beginning-of-line nil)
      (if (eql 0 (string-match "\\W*$" (buffer-substring (point) prev-point)))
          (setq beginning-of-line t)))
    (if beginning-of-line
        (ryan-indent)))
  ;;3) Try autocomplete if at the end of a line, or
  ;;4) Try autocomplete if the next char is not alpha-numerical
  (if (or (string-match "\n" (buffer-substring (point) (+ (point) 1)))
          (not (string-match "[a-zA-Z0-9]" (buffer-substring (point) (+ (point) 1)))))
      (ac-start)
    ;;5) Try a regular indent
    (if (not (ryan-indent))
        ;;6) Try autocomplete at the end of a word
        (if (string-match "\\W" (buffer-substring (point) (+ (point) 1)))
            (ac-start)))))

;; End Tab completion


;;Workaround so that Autocomplete is by default is only invoked explicitly,
;;but still automatically updates as you type while attempting to complete.
(defadvice ac-start (before advice-turn-on-auto-start activate)
  (set (make-local-variable 'ac-auto-start) t))
(defadvice ac-cleanup (after advice-turn-off-auto-start activate)
  (set (make-local-variable 'ac-auto-start) nil))

;;Ryan's python specific tab completion                                                                        
(defun ryan-python-tab ()
					; Try the following:                                                                                         
					; 1) Do a yasnippet expansion                                                                                
					; 2) Do a Rope code completion                                                                               
					; 3) Do an indent                                                                                            
  (interactive)
  (if (eql (ac-start) 0)
      (indent-for-tab-command)))

(define-key python-mode-map "\t" 'ryan-python-tab)
;;; End the Auto Complete

;; Auto Syntax Error Hightlight
;; (when (load "flymake" t)
;;   (defun flymake-pyflakes-init ()
;;     (let* ((temp-file (flymake-init-create-temp-buffer-copy
;; 		       'flymake-create-temp-inplace))
;; 	   (local-file (file-relative-name
;; 			temp-file
;; 			(file-name-directory buffer-file-name))))
;;       (list "pyflakes" (list local-file))))
;;   (add-to-list 'flymake-allowed-file-name-masks
;; 	       '("\\.py\\'" flymake-pyflakes-init)))
;; (add-hook 'find-file-hook 'flymake-find-file-hook)

