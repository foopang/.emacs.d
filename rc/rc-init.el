;; use Ctrl-x Ctrl-m replace M-x
(global-set-key "\C-x\C-m" 'execute-extended-command)
(global-set-key "\C-c\C-m" 'execute-extended-command)

;; set kill word to C-x C-k; set C-w to kill backward-word
(global-set-key "\C-w" 'backward-kill-word)
(global-set-key "\C-x\C-k" 'kill-region)
(global-set-key "\C-c\C-k" 'kill-region)

;; turn off backup with ~ in the amending file's directory
(setq backup-by-copying nil)
(setq backup-directory-alist '(("" . "~/.emacs.d/backup")))


(fset 'yes-or-no-p 'y-or-n-p) ;; instead asking yes or no
(setq inhibit-splash-screen t) ;;hides welcome screen

(show-paren-mode 1) ;; highlight paren-mode
(tool-bar-mode -1) ;;toolbar
(scroll-bar-mode -1) ;;scrollbar
(menu-bar-mode 1) ;; menu bar

(if (eq system-type 'gnu/linux)
    (set-default-font "DejaVu Sans Mono-14")
  )

(if (eq system-type 'windows-nt)
    (set-default-font "Consolas-10")
  )

;; move between windows
;;(windmove-default-keybindings 'meta)
(if window-system
(windmove-default-keybindings 'meta)
(progn
(global-set-key [(alt left)] 'windmove-left)
(global-set-key [(alt up)] 'windmove-up)
(global-set-key [(alt right)] 'windmove-right)
(global-set-key [(alt down)] 'windmove-down)))

;; tabbar
(require 'tabbar)
(tabbar-mode t)

;; ediff
(setq ediff-window-setup-function 'ediff-setup-windows-plain)
(setq ediff-diff-options "-w")

;; copy-line
(defun copy-line (&optional arg)
  "Do a kill-line but copy rather than kill.  This function directly calls
kill-line, so see documentation of kill-line for how to use it including prefix
argument and relevant variables.  This function works by temporarily making the
buffer read-only, so I suggest setting kill-read-only-ok to t."
  (interactive "P")
  (toggle-read-only 1)
  (kill-line arg)
  (toggle-read-only 0))

(setq-default kill-read-only-ok t)
(global-set-key "\C-c\C-k" 'copy-line)


;; open new line

;; Behave like vi's o command
(defun open-next-line (arg)
  "Move to the next line and then opens a line.
    See also `newline-and-indent'."
  (interactive "p")
  (end-of-line)
  (open-line arg)
  (next-line 1)
  (when newline-and-indent
    (indent-according-to-mode)))

(global-set-key (kbd "C-o") 'open-next-line)

;; Behave like vi's O command
(defun open-previous-line (arg)
  "Open a new line before the current one. 
     See also `newline-and-indent'."
  (interactive "p")
  (beginning-of-line)
  (open-line arg)
  (when newline-and-indent
    (indent-according-to-mode)))

(global-set-key (kbd "M-o") 'open-previous-line)

;; Autoindent open-*-lines
(defvar newline-and-indent t
  "Modify the behavior of the open-*-line functions to cause them to autoindent.")

(global-set-key [S-return]   'open-next-line)
(global-set-key [C-S-return] 'open-previous-line)


;; textmate
;;(dolist (command '(yank yank-pop))
;;  (eval `(defadvice ,command (after indent-region activate)
;;	   (and (not current-prefix-arg)
;;		(member major-mode '(emacs-lisp-mode lisp-mode       nxhtml-mode
;;						     clojure-mode    scheme-mode
;;						     haskell-mode    ruby-mode
;;						     rspec-mode      python-mode
;;						     c-mode          c++-mode
;;						     objc-mode       latex-mode
;;						     plain-tex-mode))
;;		(let ((mark-even-if-inactive transient-mark-mode))
;;		  (indent-region (region-beginning) (region-end) nil))))))

(defun yank-and-indent ()
  "Yank and then indent the newly formed region according to mode."
  (interactive)
  (yank)
  (call-interactively 'indent-region))
(global-set-key "\C-y" 'yank-and-indent)

(defun kill-and-join-forward (&optional arg)
  (interactive "P")
  (if (and (eolp) (not (bolp)))
      (progn (forward-char 1)
	     (just-one-space 0)
	     (backward-char 1)
	     (kill-line arg))
    (kill-line arg)))
(global-set-key "\C-k" 'kill-and-join-forward)

;; copy-line
(defun copy-line (&optional arg)
  "Do a kill-line but copy rather than kill.  This function directly calls
kill-line, so see documentation of kill-line for how to use it including prefix
argument and relevant variables.  This function works by temporarily making the
buffer read-only, so I suggest setting kill-read-only-ok to t."
  (interactive "P")
  (toggle-read-only 1)
  (kill-line arg)
  (toggle-read-only 0))

(setq-default kill-read-only-ok t)
(global-set-key "\C-c\C-k" 'copy-line)


;; open new line

;; Behave like vi's o command
(defun open-next-line (arg)
  "Move to the next line and then opens a line.
    See also `newline-and-indent'."
  (interactive "p")
  (end-of-line)
  (open-line arg)
  (next-line 1)
  (when newline-and-indent
    (indent-according-to-mode)))

(global-set-key (kbd "C-o") 'open-next-line)

;; Behave like vi's O command
(defun open-previous-line (arg)
  "Open a new line before the current one. 
     See also `newline-and-indent'."
  (interactive "p")
  (beginning-of-line)
  (open-line arg)
  (when newline-and-indent
    (indent-according-to-mode)))

(global-set-key (kbd "M-o") 'open-previous-line)

;; Autoindent open-*-lines
(defvar newline-and-indent t
  "Modify the behavior of the open-*-line functions to cause them to autoindent.")

(global-set-key [S-return]   'open-next-line)
(global-set-key [C-S-return] 'open-previous-line)


;; textmate
(dolist (command '(yank yank-pop))
  (eval `(defadvice ,command (after indent-region activate)
	   (and (not current-prefix-arg)
		(member major-mode '(emacs-lisp-mode lisp-mode
						     clojure-mode    scheme-mode
						     haskell-mode    ruby-mode
						     rspec-mode      python-mode
						     c-mode          c++-mode
						     objc-mode       latex-mode
						     plain-tex-mode))
		(let ((mark-even-if-inactive transient-mark-mode))
		  (indent-region (region-beginning) (region-end) nil))))))

;; anything
;;(require 'anything-etags)
;;(setq anything-sources
;;      '(
;;	anything-c-source-buffers
;;	anything-c-source-etags-select
;;        ))

;;(require 'anything-config)
;;(require 'anything-etags)
;;(setq anything-sources
;;      '(anything-c-source-buffers
;;        anything-c-source-buffer-not-found
;;        anything-c-source-file-name-history
;;        anything-c-source-info-pages
;;        anything-c-source-info-elisp
;;        anything-c-source-man-pages
;;        anything-c-source-locate
;;        anything-c-source-emacs-commands
;;        ))

;; (setq anything-sources
;;       '(anything-etags-c-source-etags-select
;;        ))


;;(setq anything-sources
;;      '(anything-etags-c-source-etags-select
;;       ))


;; anything
;;(require 'anything-etags)
;;(setq anything-sources
;;      '(
;;	anything-c-source-buffers
;;	anything-c-source-etags-select
;;        ))

;;(require 'anything-config)
;;(require 'anything-etags)
;;(setq anything-sources
;;      '(anything-c-source-buffers
;;        anything-c-source-buffer-not-found
;;        anything-c-source-file-name-history
;;        anything-c-source-info-pages
;;        anything-c-source-info-elisp
;;        anything-c-source-man-pages
;;        anything-c-source-locate
;;        anything-c-source-emacs-commands
;;        ))

;; (setq anything-sources
;;       '(anything-etags-c-source-etags-select
;;        ))


;;(setq anything-sources
;;      '(anything-etags-c-source-etags-select
;;       ))
