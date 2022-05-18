;; This module is for programming enhancement

(add-hook 'prog-hook (lambda () (interactive) (setq show-trailing-whitespace 1)))

(setq c-default-style "k&r") ; set style to "linux"
;; (setq c-basic-offset 4)
(setq-default c-basic-offset 4)

(use-package highlight-symbol
  :diminish highlight-symbol-nav-mode highlight-symbol-mode
  :config
  (highlight-symbol-nav-mode t)
  (highlight-symbol-mode t)
  (setq highlight-symbol-idle-delay 0.5)
  )
  
(use-package magit
  )

(use-package projectile
  :diminish projectile-mode
  :config
  (projectile-mode)
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :init
  ;; (when (file-directory-p "~/work/repo/projects/")
  ;;   (setq projectile-project-search-path '("~/work/repo/projects/" "~/work/repo/")))
  (setq projectile-switch-project-action #'projectile-dired)
  ;;(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
  )


(use-package company
  :ensure t
  :config
  (global-company-mode t)
  (setq company-idle-delay 0)
  (setq company-minimum-prefix-length 3)
  (setq company-backends
	'((company-files
	   company-yasnippet
	   company-keywords
	   company-capf
	   )
	  (company-abbrev company-dabbrev)))
  (add-hook 'shell-mode-hook (lambda () (company-mode -1)) 'append)
  (add-hook 'eshell-mode-hook (lambda () (company-mode -1)) 'append)
  )

(add-hook 'emacs-lisp-mode-hook (lambda()
				  (add-to-list (make-local-variable 'company-backends)
					       'company-elisp)))
(add-hook 'c++-mode-hook (lambda()
			   (add-to-list (make-local-variable 'company-backends)
					'company-clang)))
(add-hook 'c-mode-hook (lambda()
			   (add-to-list (make-local-variable 'company-backends)
					'company-clang)))

(use-package flycheck
  :ensure t
  :init
  (global-flycheck-mode t))

(flycheck-define-checker proselint
  "A linter for prose."
  :command ("proselint" source-inplace)
  :error-patterns
  ((warning line-start (file-name) ":" line ":" column ": "
        (id (one-or-more (not (any " "))))
        (message) line-end))
  :modes (text-mode markdown-mode gfm-mode org-mode tex-mode))

(provide 'setup-programming)
