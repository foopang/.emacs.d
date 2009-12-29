
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

;;font
;;(set-default-font "-monotype-andale mono-medium-r-normal--0-0-0-0-c-0-adobe-standard")
;;(set-default-font "-freetype-coding font tobi-medium-r-normal--16-120-96-96-p-48-iso10646-1")
;;(set-default-font "-windows-proggyclean-medium-r-normal--13-80-96-96-c-70-iso8859-1")
(set-default-font "Inconsolata-14")
(set-default-font "DejaVu Sans Mono-14")

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
;;(require 'tabbar)
;;(tabbar-mode)

;; ediff
(setq ediff-window-setup-function 'ediff-setup-windows-plain)
(setq ediff-diff-options "-w")