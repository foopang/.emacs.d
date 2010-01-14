(setq gdb-many-windows t)
(setq gdb-show-main t)
(setq gud-chdir-before-run nil)
(setq gud-tooltip-mode t)

;;cppiii
(add-hook 'gdb-mode-hook
	  (lambda ()
	    (tool-bar-mode t)
	    )
	  )
(remove-hook 'gdb-mode-hook
	  (lambda ()
	    (tool-bar-mode nil)
	    )
	  )