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
  :bind (:map company-active-map
              ("C-/" . #'company-other-backend)
              ("<tab>" . #'company-complete-common-or-cycle)
              ("M-." . #'company-show-location)
              )
  :config
  (setq company-global-modes '(not message-mode eshell-mode)) ;; turn off company mode for specific major modes
  (global-company-mode t)
  (setq company-idle-delay                  0    ;; reaction time to immediately
        company-minimum-prefix-length       3    ;; start completion after typing 3 characters
        company-require-match               nil  ;; don't have to type following the candidate
        company-tooltip-align-annotations   t    ;; annotation aligned to the right
        company-dabbrev-downcase            nil  ;; will not change the capitalization of the words, like 'Pre' -> 'pre' after compeletion
        company-dabbrev-ignore-case         t    ;; ignore the case when collecting the completion, and a non 'keep-prefix' value will change the character accordingly
        company-selection-wrap-around       t    ;; C-n/C-p will wrap around when touching the bottom/top
        ;; company-dabbrev-other-buffers    all  ;; could be t nil all
        )
  (setq company-files-exclusions completion-ignored-extensions)
  ;; setup the common backends
  (setq company-backends
	'((company-files
	   company-yasnippet
	   company-keywords
	   company-capf
	   )))
  ;; customize the company backends for different major modes
  (add-hook 'org-mode-hook (lambda() (add-to-list (make-local-variable 'company-backends)
                                                  '(company-dabbrev company-abbrev company-ispell))))
  (add-hook 'emacs-lisp-mode-hook (lambda() (add-to-list (make-local-variable 'company-backends)
					         'company-elisp)))
  (add-hook 'c++-mode-hook (lambda() (add-to-list (make-local-variable 'company-backends)
					  'company-clang)))
  (add-hook 'c-mode-hook (lambda() (add-to-list (make-local-variable 'company-backends)
					'company-clang)))
  )


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


; from enberg on #emacs
; kill the compile window is no compilation error
(add-hook 'compilation-finish-functions
          (lambda (buf str)
            (if (null (string-match ".*exited abnormally.*" str))
                ;;no errors, make the compilation window go away in a few seconds
                (progn
                  (run-at-time
                   "2 sec" nil 'delete-windows-on
                   (get-buffer-create "*compilation*"))
                  (message "No Compilation Errors!")))))

(provide 'setup-programming)
