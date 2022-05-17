;; This module is for UI configuration


(setq inhibit-startup-message t) ;; inhibit the startup screen
(setq visible-bell t)            ;; set up the visible bell


(scroll-bar-mode -1)    ;; remove the scroll bar
(tool-bar-mode -1)      ;; remove the tool bar
(tooltip-mode -1)       ;; diable the tool tips
(menu-bar-mode -1)      ;; remove the menu bar
(global-hl-line-mode t) ;; always highlight the current line
(blink-cursor-mode -1)  ;; cursor not blink

(set-fringe-mode 20)   ;; room at left/right sides

(column-number-mode 1)
(global-linum-mode 1)
(dolist (mode '(org-mode-hook
		term-mode-hook
		shell-mode-hook
		eshell-mode-hook
		pdf-view-mode-hook
                LaTeX-mode-hook
                vterm-mode-hook
                ))
   (add-hook mode (lambda () (linum-mode 0))))



(set-face-attribute 'default nil :height 125) ;; setup the font size

(use-package doom-themes
  :config
  ;;(load-theme 'doom-oceanic-next t)
  (load-theme 'doom-solarized-dark t)
  (doom-themes-org-config) ;; unknown options
  )

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(provide 'setup-ui)
