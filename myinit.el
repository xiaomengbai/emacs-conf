(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-cb" 'org-switchb)
(global-set-key "\C-c(" 'org-time-stamp-inactive)
(defun efs/org-mode-setup ()
  (org-indent-mode)
  (visual-line-mode 1))

(use-package org
  :pin gnu
  :hook (org-mode . efs/org-mode-setup)
  :config
  (setq org-file-apps '(("\\.docx?\\'" . "wslview %s")
                        ("\\.pptx?\\'" . "wslview %s")
                        ("\\.xlsx?\\'" . "wslview %s")
                        ("\\.pdf\\'" . "wslview %s")
                        (auto-mode . emacs)
                        (directory . emacs)
                        ("\\.mm\\'" . default)
                        ("\\.x?html?\\'" . default)
                        ))
  ;; 'browse-url-default-browser
  (setq browse-url-browser-function 'browse-url-generic
    browse-url-generic-program "wslview")

  (setq org-hide-emphasis-markers t)

  ;; The following configuration is horrible
  ;; (let* ((variable-tuple
  ;;     (cond ((x-list-fonts "ETBembo")         '(:font "ETBembo"))
  ;;           ((x-list-fonts "Source Sans Pro") '(:font "Source Sans Pro"))
  ;;           ((x-list-fonts "Lucida Grande")   '(:font "Lucida Grande"))
  ;;           ((x-list-fonts "Verdana")         '(:font "Verdana"))
  ;;           ((x-family-fonts "Sans Serif")    '(:family "Sans Serif"))
  ;;           (nil (warn "Cannot find a Sans Serif Font.  Install Source Sans Pro."))))
  ;;    (base-font-color     (face-foreground 'default nil 'default))
  ;;    (headline           `(:inherit default :weight bold :foreground ,base-font-color)))

  ;;   (custom-theme-set-faces
  ;;    'user
  ;;    `(org-level-8 ((t (,@headline ,@variable-tuple))))
  ;;    `(org-level-7 ((t (,@headline ,@variable-tuple))))
  ;;    `(org-level-6 ((t (,@headline ,@variable-tuple))))
  ;;    `(org-level-5 ((t (,@headline ,@variable-tuple))))
  ;;    `(org-level-4 ((t (,@headline ,@variable-tuple :height 1.1))))
  ;;    `(org-level-3 ((t (,@headline ,@variable-tuple :height 1.2))))
  ;;    `(org-level-2 ((t (,@headline ,@variable-tuple :height 1.3))))
  ;;    `(org-level-1 ((t (,@headline ,@variable-tuple :height 1.5))))
  ;;    `(org-document-title ((t (,@headline ,@variable-tuple :height 1.6 :underline nil))))))

  ;;(add-to-list 'org-file-apps '(directory . emacs))
  ;;(add-to-list 'org-file-apps '("\\.pdf\\'" . "xdg-open %s")) ;; use evince to open the pdf file
  (add-to-list 'org-link-frame-setup '(file . find-file))
  (setq org-archive-location "trash.org::")
  ;; enable shortcuts when the point at the heading
  (setq org-use-speed-commands t)
  (setq org-speed-commands-user '(("w" . widen)
                                  ("z" . org-refile)))
  (setq xmb-org-journal-file "~/work/repo/krepo/journals.org")
  (setq org-use-property-inheritance '("DIR"))
  (setq org-refile-targets '((nil :maxlevel . 2)
                             (xmb-org-journal-file :maxlevel . 1)
                             (org-agenda-files :maxlevel . 2))
        org-refile-use-outline-path 'file
        org-outline-path-complete-in-steps nil)
  (setq org-clock-idle-time 5)
  :bind (("ESC *" . (lambda () (interactive) (org-back-to-heading)))
         )
  ;;  :bind (("M-." . org-open-at-point)
  ;;         ("\C-c," . org-mark-ring-goto))

  )
;; krepo/
;;  |- .inbox         ;; org-capture
;;  |- trash.org      ;; org-archive
;;  |- knowledge/     ;; org-roam
;;  |- org-ref/       ;; bibtex & papers
;;      |- refs.bib   ;; references
;;      |- pdfs/      ;; papers
;;      |- notes/     ;; notes

(setq org-directory "~/work/repo/krepo/")
;; org-default-notes-file used for capture
;; (setq org-default-notes-file (concat org-directory "projects.org"))
(setq org-default-notes-file (concat org-directory ".inbox"))
(setq org-agenda-files (list org-default-notes-file))
(setq org-capture-templates
    '(("t" "Todo" entry (file+headline org-default-notes-file "Tasks")
       "* TODO %?\n%i\n%l")
      ("n" "Next" entry (file+headline org-default-notes-file "Tasks")
       "* NEXT %?\n%i\n%l")
      ("N" "Next with copied content" entry (file+headline org-default-notes-file "Tasks")
       "* NEXT %?\n%i%c\n%l")
      ("e" "Normal entry" entry (file+headline org-default-notes-file "Tasks")
       "* %?\n%i\n%l")
      ("j" "Journal" entry (file+olp+datetree org-default-notes-file)
       "* %?\nEntered on %U\n  %i\n  %a")))

;; setup babel languages
(org-babel-do-load-languages
 'org-babel-load-languages
 '((lisp . t) (perl . t) (C . t) (python . t) (gnuplot . t) (shell . t)))

(setq org-babel-python-command "python3")
(setq org-confirm-babel-evaluate nil)

(add-hook 'org-mode-hook
          (lambda () (local-set-key (kbd "M-,") #'org-mark-ring-goto)))

(add-hook 'org-mode-hook
          (lambda () (local-set-key (kbd "M-.") #'org-open-at-point)))

(use-package org-download
  :after org
  :bind
  (:map org-mode-map
        (("s-Y" . org-download-screenshot)
         ("s-y" . org-download-yank)))
  :custom
  (org-download-screenshot-method "powershell.exe -Command \"(Get-Clipboard -Format image).Save('$(wslpath -w %s)')\"")
)
;;(setq mathpix-screenshot-method "powershell.exe -Command \"(Get-Clipboard -Format image).Save('$(wslpath -w %s)')\"")

(setq inhibit-startup-message t) ;; hide the startup buffer
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

;; in these modes, no longer show the line numbers
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
  ;;(load-theme 'doom-solarized-dark t)
  (load-theme 'doom-peacock t)
  (doom-themes-org-config) ;; unknown options
  )

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(global-set-key (kbd "<f5>") 'revert-buffer)
(global-set-key (kbd "M-n") 'highlight-symbol-next)
(global-set-key (kbd "M-p") 'highlight-symbol-prev)
(global-set-key (kbd "C-j") 'goto-line)

(setq global-mark-ring-max 5000
      mark-ring-max 5000
      tab-width 4)

(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-language-environment "UTF-8")
(prefer-coding-system 'utf-8)

(setq-default indent-tabs-mode nil)  ;; never insert tab
(delete-selection-mode) ;; delete the region marked if typing any character
(global-set-key (kbd "RET") 'newline-and-indent) ;; return and tab!

;; GROUP: Editing -> Killing
(setq
 kill-ring-max 5000
 kill-whole-line t ;; kill the line and move to next!
 )


;; show important whitespace in diff-mode
(add-hook 'diff-mode-hook (lambda ()
                            (setq-local whitespace-style
                                        '(face
                                          tabs
                                          tab-mark
                                          spaces
                                          space-mark
                                          trailing
                                          indentation::space
                                          indentation::tab
                                          newline
                                          newline-mark))
                            (whitespace-mode 1)))

(recentf-mode 1)
(savehist-mode 1)
(save-place-mode 1)
(setq use-dialog-box nil)
(global-auto-revert-mode 1)

;; set column fill width
;; (set-fill-column 120)
(defun my-set-fill-column-120 ()
  "set text filled approximately at column 120."
  (interactive)
  (set-fill-column 120))
(add-hook 'org-mode-hook 'my-set-fill-column-120)
(add-hook 'text-mode 'my-set-fill-column-120)
(add-hook 'tex-mode 'my-set-fill-column-120)

;; winner-mode for jump backward and forward windows
(winner-mode +1)
(define-key winner-mode-map (kbd "<M-left>") #'winner-undo)
(define-key winner-mode-map (kbd "<M-right>") #'winner-redo)

;; customize C-a
(defun prelude-move-beginning-of-line (arg)
  "move point back to indentation of beginning of line

move point to the first non-whitespace character on this line.
if point is already there, move to the beginning of the line.
effectively toggle between the first non-whitespace character and
the beginning of the line.

If ARG is not nil or 1, move forward ARG - 1 lines first. If
point reaches the beginning or end of the buffer, stop there."
  (interactive "^p") ;; what's this mean?
  (setq arg (or arg 1))

  ;; Move lines first
  (when (/= arg 1)
    (let ((line-move-visual nil))
      (forward-line (1- arg))))

  (let ((orig-point (point)))
    (back-to-indentation)
    (when (= orig-point (point))
      (move-beginning-of-line 1))))

(global-set-key (kbd "C-a") 'prelude-move-beginning-of-line)

;; the "M-w"
(defadvice kill-ring-save (before slick-copy activate compile)
  "When called interactively with no active region, copy a single
line instead."
  (interactive
   (if mark-active (list (region-beginning) (region-end))
     (message "Copied line")
     (list (line-beginning-position)
           (line-beginning-position 2)))))

;; the "C-w"
(defadvice kill-region (before slick-cut activate compile)
  "When called interactively with no active region, kill a single
  line instead."
  (interactive
   (if mark-active (list (region-beginning) (region-end))
     (list (line-beginning-position)
           (line-beginning-position 2)))))


;; "C-k"
(defadvice kill-line (before check-position activate)
  "kill a line, including whitespace characters until next non-whiepsace character
of next line"
  (if (member major-mode
              '(emacs-lisp-mode scheme-mode lisp-mode
                                c-mode c++-mode objc-mode
                                latex-mode plain-tex-mode))
      (if (and (eolp) (not (bolp)))
          (progn (forward-char 1)
                 (just-one-space 0)
                 (backward-char 1)))))

;; can check these functions later
;; taken from prelude-editor.el
;; automatically indenting yanked text if in programming-modes
(defvar yank-indent-modes
  '(LaTeX-mode TeX-mode)
  "Modes in which to indent regions that are yanked (or yank-popped).
Only modes that don't derive from `prog-mode' should be listed here.")

(defvar yank-indent-blacklisted-modes
  '(python-mode slim-mode haml-mode)
  "Modes for which auto-indenting is suppressed.")

(defvar yank-advised-indent-threshold 1000
  "Threshold (# chars) over which indentation does not automatically occur.")

(defun yank-advised-indent-function (beg end)
  "Do indentation, as long as the region isn't too large."
  (if (<= (- end beg) yank-advised-indent-threshold)
      (indent-region beg end nil)))

(defadvice yank (after yank-indent activate)
  "If current mode is one of 'yank-indent-modes,
indent yanked text (with prefix arg don't indent)."
  (if (and (not (ad-get-arg 0))
           (not (member major-mode yank-indent-blacklisted-modes))
           (or (derived-mode-p 'prog-mode)
               (member major-mode yank-indent-modes)))
      (let ((transient-mark-mode nil))
        (yank-advised-indent-function (region-beginning) (region-end)))))

(defadvice yank-pop (after yank-pop-indent activate)
  "If current mode is one of `yank-indent-modes',
indent yanked text (with prefix arg don't indent)."
  (when (and (not (ad-get-arg 0))
             (not (member major-mode yank-indent-blacklisted-modes))
             (or (derived-mode-p 'prog-mode)
                 (member major-mode yank-indent-modes)))
    (let ((transient-mark-mode nil))
      (yank-advised-indent-function (region-beginning) (region-end)))))


;; prelude-core.el
(defun prelude-duplicate-current-line-or-region (arg)
  "Duplicates the current line or region ARG times.
If there's no region, the current line will be duplicated. However, if
there's a region, all lines that region covers will be duplicated."
  (interactive "p")
  (pcase-let* ((origin (point))
               (`(,beg . ,end) (prelude-get-positions-of-line-or-region))
               (region (buffer-substring-no-properties beg end)))
    (-dotimes arg
      (lambda (n)
        (goto-char end)
        (newline)
        (insert region)
        (setq end (point))))
    (goto-char (+ origin (* (length region) arg) arg))))

;; prelude-core.el
(defun indent-buffer ()
  "Indent the currently visited buffer."
  (interactive)
  (indent-region (point-min) (point-max)))

;; prelude-editing.el
(defcustom prelude-indent-sensitive-modes
  '(coffee-mode python-mode slim-mode haml-mode yaml-mode)
  "Modes for which auto-indenting is suppressed."
  :type 'list)

(defun indent-region-or-buffer ()
  "Indent a region if selected, otherwise the whole buffer."
  (interactive)
  (unless (member major-mode prelude-indent-sensitive-modes)
    (save-excursion
      (if (region-active-p)
          (progn
            (indent-region (region-beginning) (region-end))
            (message "Indented selected region."))
        (progn
          (indent-buffer)
          (message "Indented buffer.")))
      (whitespace-cleanup))))

(global-set-key (kbd "C-c i") 'indent-region-or-buffer)


;; add duplicate line function from Prelude
;; taken from prelude-core.el
(defun prelude-get-positions-of-line-or-region ()
  "Return positions (beg . end) of the current line
or region."
  (let (beg end)
    (if (and mark-active (> (point) (mark)))
        (exchange-point-and-mark))
    (setq beg (line-beginning-position))
    (if mark-active
        (exchange-point-and-mark))
    (setq end (line-end-position))
    (cons beg end)))


(defun kill-default-buffer ()
  "Kill the currently active buffer -- set to C-x k so that users are not asked which buffer they want to kill."
  (interactive)
  (let (kill-buffer-query-functions) (kill-buffer)))

(global-set-key (kbd "C-x k") 'kill-default-buffer)


;; smart openline
(defun prelude-smart-open-line (arg)
  "Insert an empty line after the current line.
Position the cursor at its beginning, according to the current mode.
With a prefix ARG open line above the current line."
  (interactive "P")
  (if arg
      (prelude-smart-open-line-above)
    (progn
      (move-end-of-line nil)
      (newline-and-indent))))

(defun prelude-smart-open-line-above ()
  "Insert an empty line above the current line.
Position the cursor at it's beginning, according to the current mode."
  (interactive)
  (move-beginning-of-line nil)
  (newline-and-indent)
  (forward-line -1)
  (indent-according-to-mode))

(global-set-key (kbd "C-o") 'prelude-smart-open-line)
(global-set-key (kbd "M-o") 'open-line)

(windmove-default-keybindings)

(use-package avy
  :bind ("M-g l" . avy-goto-char))

(use-package ace-window
  :init
  (progn
    (global-set-key [remap other-window] 'ace-window)
    (custom-set-faces
     '(aw-leading-char-face
       ((t (:inherit ace-jump-face-foreground :height 3.0)))))
    ))

(use-package vertico
  :init
  (vertico-mode)
  :config
  (setq vertico-scroll-margin 0)
  (setq vertico-count 20)
  (setq vertico-resize 'grow-only)
  (setq vertico-cycle t)
  )

(use-package savehist
  :init
  (savehist-mode))

(use-package emacs
  :init
  ;; Add prompt indicator to `completing-read-multiple'.
  ;; We display [CRM<separator>], e.g., [CRM,] if the separator is a comma.
  (defun crm-indicator (args)
    (cons (format "[CRM%s] %s"
                  (replace-regexp-in-string
                   "\\`\\[.*?]\\*\\|\\[.*?]\\*\\'" ""
                   crm-separator)
                  (car args))
          (cdr args)))
  (advice-add #'completing-read-multiple :filter-args #'crm-indicator)

  ;; Do not allow the cursor in the minibuffer prompt
  (setq minibuffer-prompt-properties
        '(read-only t cursor-intangible t face minibuffer-prompt))
  (add-hook 'minibuffer-setup-hook #'cursor-intangible-mode)

  ;; Emacs 28: Hide commands in M-x which do not work in the current mode.
  ;; Vertico commands are hidden in normal buffers.
  ;; (setq read-extended-command-predicate
  ;;       #'command-completion-default-include-p)

  ;; Enable recursive minibuffers
  (setq enable-recursive-minibuffers t))

;; Optionally use the `orderless' completion style.
(use-package orderless
  :init
  ;; Configure a custom style dispatcher (see the Consult wiki)
  ;; (setq orderless-style-dispatchers '(+orderless-consult-dispatch orderless-affix-dispatch)
  ;;       orderless-component-separator #'orderless-escapable-split-on-space)
  (setq completion-styles '(orderless basic)
        completion-category-defaults nil
        completion-category-overrides '((file (styles partial-completion)))))

;; Enable rich annotations using the Marginalia package
(use-package marginalia
  ;; Either bind `marginalia-cycle' globally or only in the minibuffer
  :bind (("M-A" . marginalia-cycle)
         :map minibuffer-local-map
         ("M-A" . marginalia-cycle))

  ;; The :init configuration is always executed (Not lazy!)
  :init

  ;; Must be in the :init section of use-package such that the mode gets
  ;; enabled right away. Note that this forces loading the package.
  (marginalia-mode))


;; Example configuration for Consult
(use-package consult
  ;; Replace bindings. Lazily loaded due by `use-package'.
  :bind (;; C-c bindings (mode-specific-map)
         ("C-c M-x" . consult-mode-command)
         ("C-c h" . consult-history)
         ("C-c k" . consult-kmacro)
         ("C-c m" . consult-man)
         ("C-c i" . consult-info)
         ([remap Info-search] . consult-info)
         ;; C-x bindings (ctl-x-map)
         ("C-x M-:" . consult-complex-command)     ;; orig. repeat-complex-command
         ("C-x b" . consult-buffer)                ;; orig. switch-to-buffer
         ("C-x 4 b" . consult-buffer-other-window) ;; orig. switch-to-buffer-other-window
         ("C-x 5 b" . consult-buffer-other-frame)  ;; orig. switch-to-buffer-other-frame
         ("C-x r b" . consult-bookmark)            ;; orig. bookmark-jump
         ("C-x p b" . consult-project-buffer)      ;; orig. project-switch-to-buffer
         ;; Custom M-# bindings for fast register access
         ("M-#" . consult-register-load)
         ("M-'" . consult-register-store)          ;; orig. abbrev-prefix-mark (unrelated)
         ("C-M-#" . consult-register)
         ;; Other custom bindings
         ("M-y" . consult-yank-pop)                ;; orig. yank-pop
         ;; M-g bindings (goto-map)
         ("M-g e" . consult-compile-error)
         ("M-g f" . consult-flymake)               ;; Alternative: consult-flycheck
         ("M-g g" . consult-goto-line)             ;; orig. goto-line
         ("M-g M-g" . consult-goto-line)           ;; orig. goto-line
         ("M-g o" . consult-outline)               ;; Alternative: consult-org-heading
         ("M-g m" . consult-mark)
         ("M-g k" . consult-global-mark)
         ("M-g i" . consult-imenu)
         ("M-g I" . consult-imenu-multi)
         ;; M-s bindings (search-map)
         ("M-s d" . consult-find)
         ("M-s D" . consult-locate)
         ("M-s g" . consult-grep)
         ("M-s G" . consult-git-grep)
         ("M-s r" . consult-ripgrep)
         ("M-s l" . consult-line)
         ("M-s L" . consult-line-multi)
         ("M-s k" . consult-keep-lines)
         ("M-s u" . consult-focus-lines)
         ;; Isearch integration
         ("M-s e" . consult-isearch-history)
         :map isearch-mode-map
         ("M-e" . consult-isearch-history)         ;; orig. isearch-edit-string
         ("M-s e" . consult-isearch-history)       ;; orig. isearch-edit-string
         ("M-s l" . consult-line)                  ;; needed by consult-line to detect isearch
         ("M-s L" . consult-line-multi)            ;; needed by consult-line to detect isearch
         ;; Minibuffer history
         :map minibuffer-local-map
         ("M-s" . consult-history)                 ;; orig. next-matching-history-element
         ("M-r" . consult-history))                ;; orig. previous-matching-history-element

  ;; Enable automatic preview at point in the *Completions* buffer. This is
  ;; relevant when you use the default completion UI.
  :hook (completion-list-mode . consult-preview-at-point-mode)

  ;; The :init configuration is always executed (Not lazy)
  :init

  ;; Optionally configure the register formatting. This improves the register
  ;; preview for `consult-register', `consult-register-load',
  ;; `consult-register-store' and the Emacs built-ins.
  (setq register-preview-delay 0.5
        register-preview-function #'consult-register-format)

  ;; Optionally tweak the register preview window.
  ;; This adds thin lines, sorting and hides the mode line of the window.
  (advice-add #'register-preview :override #'consult-register-window)

  ;; Use Consult to select xref locations with preview
  (setq xref-show-xrefs-function #'consult-xref
        xref-show-definitions-function #'consult-xref)

  ;; Configure other variables and modes in the :config section,
  ;; after lazily loading the package.
  :config

  ;; Optionally configure preview. The default value
  ;; is 'any, such that any key triggers the preview.
  ;; (setq consult-preview-key 'any)
  ;; (setq consult-preview-key "M-.")
  ;; (setq consult-preview-key '("S-<down>" "S-<up>"))
  ;; For some commands and buffer sources it is useful to configure the
  ;; :preview-key on a per-command basis using the `consult-customize' macro.
  (consult-customize
   consult-theme :preview-key '(:debounce 0.05 any)
   consult-ripgrep consult-git-grep consult-grep
   consult-bookmark consult-recent-file consult-xref
   consult--source-bookmark consult--source-file-register
   consult--source-recent-file consult--source-project-recent-file
   ;; :preview-key "M-."
   :preview-key '(:debounce 0.4 any))

  ;; Optionally configure the narrowing key.
  ;; Both < and C-+ work reasonably well.
  (setq consult-narrow-key "<") ;; "C-+"

  ;; Optionally make narrowing help available in the minibuffer.
  ;; You may want to use `embark-prefix-help-command' or which-key instead.
  ;; (define-key consult-narrow-map (vconcat consult-narrow-key "?") #'consult-narrow-help)

  ;; By default `consult-project-function' uses `project-root' from project.el.
  ;; Optionally configure a different project root function.
  ;;;; 1. project.el (the default)
  ;; (setq consult-project-function #'consult--default-project--function)
  ;;;; 2. vc.el (vc-root-dir)
  ;; (setq consult-project-function (lambda (_) (vc-root-dir)))
  ;;;; 3. locate-dominating-file
  ;; (setq consult-project-function (lambda (_) (locate-dominating-file "." ".git")))
  ;;;; 4. projectile.el (projectile-project-root)
  ;; (autoload 'projectile-project-root "projectile")
  ;; (setq consult-project-function (lambda (_) (projectile-project-root)))
  ;;;; 5. No project support
  ;; (setq consult-project-function nil)
  )


(use-package embark
  :ensure t

  :bind
  (("C-." . embark-act)         ;; pick some comfortable binding
   ("C-;" . embark-dwim)        ;; good alternative: M-.
   ("C-h B" . embark-bindings)) ;; alternative for `describe-bindings'

  :init

  ;; Optionally replace the key help with a completing-read interface
  (setq prefix-help-command #'embark-prefix-help-command)

  ;; Show the Embark target at point via Eldoc.  You may adjust the Eldoc
  ;; strategy, if you want to see the documentation from multiple providers.
  (add-hook 'eldoc-documentation-functions #'embark-eldoc-first-target)
  ;; (setq eldoc-documentation-strategy #'eldoc-documentation-compose-eagerly)

  :config

  ;; Hide the mode line of the Embark live/completions buffers
  (add-to-list 'display-buffer-alist
               '("\\`\\*Embark Collect \\(Live\\|Completions\\)\\*"
                 nil
                 (window-parameters (mode-line-format . none)))))

;; Consult users will also want the embark-consult package.
(use-package embark-consult
  :ensure t ; only need to install it, embark loads it after consult if found
  :hook
  (embark-collect-mode . consult-preview-at-point-mode))

(use-package which-key
  :diminish which-key-mode
  :config
  (which-key-mode t)
  (setq which-key-idle-delay 0.3))

(use-package helpful
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-command] . helpful-command)
  ([remap describe-key] . helpful-key))

(add-hook 'prog-hook (lambda () (interactive) (setq show-trailing-whitespace 1)))

(setq c-default-style "k&r") ; set style to "linux"
;; (setq c-basic-offset 4)
(setq-default c-basic-offset 4)

(use-package highlight-symbol
  :diminish highlight-symbol-nav-mode highlight-symbol-mode
  :config
  (highlight-symbol-nav-mode t)
  (highlight-symbol-mode t)
  (setq highlight-symbol-idle-delay 0.5))

(use-package magit)

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
              ;; ("<tab>" . #'company-complete-common-or-cycle) ;; not intuitive
              ("<tab>" . #'company-complete-selection)
              ;;("<tab>" . (lambda () (interactive) (progn (company-complete-selection) (insert " "))))
              ;; ("<tab>" . (lambda () (interactive)
              ;;              (when (company-manual-begin)
              ;;                (if (eq last-command 'company-common)
              ;;                    (let ((company-selection-wrap-around t))
              ;;                      (call-interactively 'company-complete-selection))
              ;;                  (call-interactively 'company-common)))))
              ("<return>" . #'company-abort)
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
        company-dabbrev-ignore-case         'keep-prefix    ;; ignore the case when collecting the completion, and a non 'keep-prefix' value will change the character accordingly
        ;; set company-dabbrev-ignore-case to t will always return the capitalized candidate
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
  (setq company-transformers '(delete-consecutive-dups
                               company-sort-by-occurrence
                               company-sort-prefer-same-case-prefix))

  ;; customize the company backends for different major modes
  (add-hook 'org-mode-hook (lambda() (add-to-list (make-local-variable 'company-backends)
                                                  '(company-dabbrev company-abbrev company-ispell))))
  (add-hook 'tex-mode-hook (lambda() (add-to-list (make-local-variable 'company-backends)
                                                  '(company-dabbrev company-abbrev company-ispell))))
  (add-hook 'LaTeX-mode-hook (lambda() (add-to-list (make-local-variable 'company-backends)
                                                  '(company-dabbrev company-abbrev company-ispell))))
  (add-hook 'emacs-lisp-mode-hook (lambda() (add-to-list (make-local-variable 'company-backends)
                                                         'company-elisp)))
  (add-hook 'c++-mode-hook (lambda() (add-to-list (make-local-variable 'company-backends)
                                                  'company-clang)))
  (add-hook 'c-mode-hook (lambda() (add-to-list (make-local-variable 'company-backends)
                                                'company-clang)))
  )

(setq-default abbrev-mode t)

(defadvice expand-abbrev (after my-expand-abbrev activate)
  ;; if there was an expansion
  (if ad-return-value
      ;; start idle timer to ensure insertion of abbrev activator
      ;; character (e.g., space) is finished
      (run-with-idle-timer 0 nil
                           (lambda ()
                             ;; if there is the string "@@" in the
                             ;; expansion then move cursor there and
                             ;; delete the string
                             (let ((cursor "@@"))
                               (if (search-backward cursor last-abbrev-location t)
                               (delete-char (length cursor))))))))

(use-package flycheck
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

;; from enberg on #emacs
;; kill the compile window is no compilation error
(add-hook 'compilation-finish-functions
          (lambda (buf str)
            (if (null (string-match ".*exited abnormally.*" str))
                ;;no errors, make the compilation window go away in a few seconds
                (progn
                  (run-at-time
                   "2 sec" nil 'delete-windows-on
                   (get-buffer-create "*compilation*"))
                  (message "No Compilation Errors!")))))

(setq dired-guess-shell-alist-user '(("\\.docx?\\'" "wslview")
                                     ("\\.xlsx?\\'" "wslview")
                                     ("\\.pptx?\\'" "wslview")
                                     ("\\.pdf\\'" "wslview")
                                     ))

(require 'tramp)
(setq password-cache-expiry nil)

(use-package try)

(use-package pdf-tools
  :config
  (pdf-tools-install))

(use-package org-pdftools
  :hook (org-mode . org-pdftools-setup-link))

(use-package latex
  :ensure auctex)
(setq Tex-view-program-selection '((output-pdf "PDF Tools"))
      Tex-source-correlate-start-server t)
(add-hook 'TeX-after-compilation-finished-functions #'TeX-revert-document-buffer)

(defun efs/org-mode-visual-fill ()
  (setq visual-fill-column-width 100 ;; 120 leads to bias visual effects
        visual-fill-column-center-text t)
  (visual-fill-column-mode 1))
(use-package visual-fill-column
  :hook ((org-mode latex-mode plain-TeX-mode LaTeX-mode ams-TeX-mode ConTeXt-mode docTex-mode) . efs/org-mode-visual-fill))

(use-package yasnippet
  :config
  (yas-global-mode 1)
  ;; :bind (:map yas-minor-mode-map
  ;;             ("SPC" . 'yas-maybe-expand))
  )

(defun xmb/yas-org-bp ()
  (interactive)
  (unless (or (string-match "^CAPTURE-" (buffer-name)) (and buffer-file-name (or (string-match "knowledge/" buffer-file-name) (string-match "org-ref/notes/" buffer-file-name))))
    (yas-expand-snippet (yas-lookup-snippet "org_file_init" 'org-mode)))
  )

(use-package autoinsert
  :config
  (setq auto-insert-query nil) ;; no asking before auto-insert
  (auto-insert-mode 1)
  (add-hook 'find-file-hook 'auto-insert)
  ;; (setq auto-insert-alist nil) ;; cleanup the auto-insert template list
  (add-to-list 'auto-insert-alist '("\\.org" . [xmb/yas-org-bp])))

(use-package org-roam
  :ensure t
  :custom
  (org-roam-directory (concat org-directory "knowledge"))
  (org-roam-completion-everywhere t)
  (org-roam-capture-templates
   '(("d" "default" plain
      "%?"
      :if-new (file+head "${slug}.org" "#+title: ${title}\n#+filetags:\n")
      :unnarrowed t :empty-lines-before 2)
     ("c" "conference paper" plain
      (file "~/work/repo/notes/org-roam/templates/conference-paper.org")
      :if-new (file+head "${slug}.org" "#+title: ${title}\n")
      :unnarrowed t)
     )) ;; ??
  :bind (("C-c n l" . org-roam-buffer-toggle)
         ("C-c n f" . org-roam-node-find)
         ("C-c n g" . org-roam-graph)
         ("C-c n i" . org-roam-node-insert)
         ("C-c n c" . org-roam-capture)
         ("C-c n t" . org-roam-dailies-goto-today)
         ;;         :map org-roam-dailies-map
         ;;         ("Y" . org-roam-dailies-capture-yesterday)
         ;;         ("T" . org-roam-dailies-capture-tomorrow)
         )
  ;;  :bind-keymap
  ;;  ("C-c n d" . org-roam-dailies-map)
  :config
  ;; (require 'org-roam-dailies)
  ;; (require 'org-roam-node)
  ;; (org-roam-setup)
  (setq org-roam-node-display-template (concat "${title:*} " (propertize "${tags:50}" 'face 'org-tag)))
  (org-roam-db-autosync-mode)
  (setq org-roam-dailies-directory "daily/")
  (setq org-roam-dailies-capture-templates
        '(("d" "default" entry
           "* %?"
           :target (file+head "%<%Y-%m-%d>.org"
                              "#+title: %<%Y-%m-%d>\n#+filetags: :dailies:not-reviewed:\n"
                              ))))
  ;; (require 'org-roam-protocol)
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; latex export
;; (setq ieeetran-class
;;       '("IEEEtran" "\\documentclass[11pt]{IEEEtran}"
;;         ("\\section{%s}" . "\\section*{%s}")
;;         ("\\subsection{%s}" . "\\subsection*{%s}")
;;         ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
;;         ("\\paragraph{%s}" . "\\paragraph*{%s}")
;;         ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

;; (add-to-list 'org-latex-classes ieeetran-class t)

(require 'ox-latex)
(with-eval-after-load 'ox-latex
  (add-to-list 'org-latex-classes
               '("org-plain-latex"
                 "\\documentclass{article}
[NO-DEFAULT-PACKAGES]
[PACKAGES]
[EXTRA]"
                 ("\\section{%s}" . "\\section*{%s}")
                 ("\\subsection{%s}" . "\\subsection*{%s}")
                 ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                 ("\\paragraph{%s}" . "\\paragraph*{%s}")
                 ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))))

(with-eval-after-load 'ox-latex
  (add-to-list 'org-latex-classes
               '("acm"
                 "\\documentclass{acmart}
\\usepackage{graphicx}
[NO-DEFAULT-PACKAGES]
[PACKAGES]
[EXTRA]"
                 ("\\section{%s}" . "\\section*{%s}")
                 ("\\subsection{%s}" . "\\subsection*{%s}")
                 ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                 ("\\paragraph{%s}" . "\\paragraph*{%s}")
                 ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))))

(with-eval-after-load 'ox-latex
  (add-to-list 'org-latex-classes
               '("ieee"
                 "\\documentclass{IEEEtran}
\\usepackage{graphicx}
[NO-DEFAULT-PACKAGES]
[NO-PACKAGES]"
                 ("\\section{%s}" . "\\section*{%s}")
                 ("\\subsection{%s}" . "\\subsection*{%s}")
                 ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                 ("\\paragraph{%s}" . "\\paragraph*{%s}")
                 ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))))

(setq org-latex-pdf-process (list "latexmk -bibtex -pdf -f %f"))

;; (defun org-export-latex-no-toc (depth)
;;   (when depth
;;     (format "%% Org-mode is exporting headings to %s levels.\n"
;;             depth)))
;; (setq org-export-latex-format-toc-function 'org-export-latex-no-toc)

(use-package citar
    :custom
    ;; (citar-bibliography '("~/work/repo/krepo/org-ref/refs.bib"))
    (citar-bibliography '("~/work/repo/biblibrary/graph_engines.bib"))
    :hook
    (LaTeX-mode . citar-capf-setup)
    (org-mode . citar-capf-setup))

(use-package citar-embark
  :after citar embark
  :no-require
  :config (citar-embark-mode))
(setq citar-at-point-function 'embark-act)
(use-package citar-org-roam
:after (citar org-roam)
:config (citar-org-roam-mode))

(use-package org-noter
  :config
  (add-to-list 'org-noter-notes-search-path "~/work/repo/krepo/org-ref/notes"))

(use-package org-noter-pdftools
  :after org-noter
  :config
  ;; Add a function to ensure precise note is inserted
  (defun org-noter-pdftools-insert-precise-note (&optional toggle-no-questions)
    (interactive "P")
    (org-noter--with-valid-session
     (let ((org-noter-insert-note-no-questions (if toggle-no-questions
                                                   (not org-noter-insert-note-no-questions)
                                                 org-noter-insert-note-no-questions))
           (org-pdftools-use-isearch-link t)
           (org-pdftools-use-freepointer-annot t))
       (org-noter-insert-note (org-noter--get-precise-info)))))

  ;; fix https://github.com/weirdNox/org-noter/pull/93/commits/f8349ae7575e599f375de1be6be2d0d5de4e6cbf
  (defun org-noter-set-start-location (&optional arg)
    "When opening a session with this document, go to the current location.
With a prefix ARG, remove start location."
    (interactive "P")
    (org-noter--with-valid-session
     (let ((inhibit-read-only t)
           (ast (org-noter--parse-root))
           (location (org-noter--doc-approx-location (when (called-interactively-p 'any) 'interactive))))
       (with-current-buffer (org-noter--session-notes-buffer session)
         (org-with-wide-buffer
          (goto-char (org-element-property :begin ast))
          (if arg
              (org-entry-delete nil org-noter-property-note-location)
            (org-entry-put nil org-noter-property-note-location
                           (org-noter--pretty-print-location location))))))))
  (with-eval-after-load 'pdf-annot
    (add-hook 'pdf-annot-activate-handler-functions #'org-noter-pdftools-jump-to-note)))

(use-package org-bullets
  :config
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

;; Add mu4e to the load-path:
(add-to-list 'load-path "/usr/local/share/emacs/site-lisp/mu4e")
(require 'mu4e)

;; Mail folders
(setq
 mu4e-sent-folder   "/Sent Items"
 mu4e-drafts-folder "/Drafts"
 mu4e-trash-folder  "/Trash")

;; The command used to get your emails
(setq mu4e-get-mail-command "mbsync --config ~/.mbsyncrc sdu")
(setq mu4e-update-interval 300) ;; 5 minites
;; SMTP settings:
(setq send-mail-function 'smtpmail-send-it)    ; should not be modified
(setq smtpmail-smtp-server "smtp.sdu.edu.cn")  ; host running SMTP server
(setq smtpmail-smtp-user "xiaomb@sdu.edu.cn")
(setq smtpmail-smtp-service 25)                ; SMTP service port number
(setq smtpmail-servers-requiring-authorization ".*")
(setq smtpmail-stream-type nil)
(setq user-mail-address "xiaomb@sdu.edu.cn")
(setq user-full-name "Mengbai Xiao")
;;(setq smtpmail-stream-type 'starttls)          ; type of SMTP connections to use

(setq mu4e-maildir-shortcuts
      '(("/Inbox" . ?i)
        ("/Sent Items" . ?s)
        ("/Trash" . ?t)
        ("/Junk E-mail" . ?j)
        ("/Drafts" . ?d)
        ("/Virus Items" . ?v)
        ))


(setq mu4e-compose-signature-auto-include nil)
(setq mu4e-view-show-images t)
(setq mu4e-view-show-addresses t)
(setq mu4e-attachement-dir "~/Downloads")
(setq mu4e-use-fancy-chars t)
(setq mu4e-headers-auto-update t)
(setq mu4e-compose-reply-ignore-address '("no-?reply"
                                          "xiaomb@sdu.edu.cn"
                                          "xiaomengbai@gmail.com"))

(setq mail-user-agent 'mu4e-user-agent)
(use-package org-msg
  :config
  (setq org-msg-options "html-postamble:nil H:5 num:nil ^:{} toc:nil")
  (setq org-msg-startup "hidestars indent inlineimages")
  (setq org-msg-greeting-fmt "%s,\n\n")
  (setq org-msg-greeting-fmt-mailto t)
  (setq org-msg-signature "
Best regards,

#+begin_signature
-- *Mengbai Xiao* \\\\
#+end_signature")
  (setq org-msg-convert-citation t)
  (org-msg-mode)
  )
(add-to-list 'mu4e-compose-mode-hook (lambda () (auto-fill-mode 0)))
;; org-msg-post-setup
(setq message-citation-line-function 'message-insert-formatted-citation-line)

;(set-face-attribute 'org-table nil :inherit '(shadow fixed-pitch))

;; Configure desktop notifs for incoming emails:
(use-package mu4e-alert
  :ensure t
  :init
  (defun perso--mu4e-notif ()
    "Display both mode line and desktop alerts for incoming new emails."
    (interactive)
    (mu4e-update-mail-and-index 1)        ; getting new emails is ran in the background
    (mu4e-alert-enable-mode-line-display) ; display new emails in mode-line
    (mu4e-alert-enable-notifications))    ; enable desktop notifications for new emails
  (defun perso--mu4e-refresh ()
    "Refresh emails every 300 seconds and display desktop alerts."
    (interactive)
    (mu4e t)                            ; start silently mu4e (mandatory for mu>=1.3.8)
    (run-with-timer 0 300 'perso--mu4e-notif))
  :after mu4e
  :bind ("<f2>" . perso--mu4e-refresh)  ; F2 turns Emacs into a mail client
  :config
  ;; Mode line alerts:
  (add-hook 'after-init-hook #'mu4e-alert-enable-mode-line-display)
  ;; Desktop alerts:
  (mu4e-alert-set-default-style 'libnotify)
  (add-hook 'after-init-hook #'mu4e-alert-enable-notifications)
  ;; Only notify for "interesting" (non-trashed) new emails:
  (setq mu4e-alert-interesting-mail-query
        (concat
         "flag:unread maildir:/INBOX"
         " AND NOT flag:trashed")))

(use-package pyim
  :demand t
  :config
  (use-package pyim-basedict
    :ensure t
    :config (pyim-basedict-enable))

  (setq default-input-method "pyim")
  (setq-default pyim-english-input-switch-functions
                '(;pyim-probe-dynamic-english
                  ;pyim-probe-auto-english
                  pyim-probe-isearch-mode
                  pyim-probe-program-mode
                  ;pyim-probe-org-latex-mode
                  pyim-probe-org-speed-commands
                  pyim-probe-org-structure-template))
  (setq-default pyim-punctuation-half-width-functions
                '(pyim-probe-punctuation-line-beginning
                  pyim-probe-punctuation-after-punctuation))

  (setq pyim-page-length 9)
  :bind
  (("M-\\" . pyim-convert-string-at-point)))

(use-package expand-region
  :bind ("C-=" . er/expand-region))

(require 'cnfonts)
(cnfonts-mode 1)

(require 'eglot)
(add-to-list 'eglot-server-programs '((c++-mode c-mode cuda-mode) "clangd"))
(add-hook 'c-mode-hook 'eglot-ensure)
(add-hook 'c++-mode-hook 'eglot-ensure)
(add-hook 'cuda-mode-hook 'eglot-ensure)

;; customize the variables in another file
(setq custom-file (locate-user-emacs-file "custom-vars.el"))
(load custom-file 'noerror 'nomessage)
