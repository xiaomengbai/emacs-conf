(provide 'setup-convenience)

;; update any change made on file to the current buffer
(global-auto-revert-mode)


;; GROUP: Convenience -> Hippe Expand
;; hippie-expand is a better version of dabbrev-expand.
;; While dabbrev-expand searches for words you already types, in current
;; buffers and other buffers, hippie-expand includes more sources,
;; such as filenames, klll ring...
;;
;; Try to find completion from recent typed, etc... 
(global-set-key (kbd "M-/") 'hippie-expand) ;; replace dabbrev-expand
(setq
 hippie-expand-try-functions-list
 '(try-expand-dabbrev ;; Try to expand word "dynamically", searching the current buffer.
   try-expand-dabbrev-all-buffers ;; Try to expand word "dynamically", searching all other buffers.
   try-expand-dabbrev-from-kill ;; Try to expand word "dynamically", searching the kill ring.
   try-complete-file-name-partially ;; Try to complete text as a file name, as many characters as unique.
   try-complete-file-name ;; Try to complete text as a file name.
   try-expand-all-abbrevs ;; Try to expand word before point according to all abbrev tables.
   try-expand-list ;; Try to complete the current line to an entire line in the buffer.
   try-expand-line ;; Try to complete the current line to an entire line in the buffer.
   try-complete-lisp-symbol-partially ;; Try to complete as an Emacs Lisp symbol, as many characters as unique.
   try-complete-lisp-symbol) ;; Try to complete word as an Emacs Lisp symbol.
 )

;; highlight current line
(global-hl-line-mode)

;; GROUP: Convenience -> Ibuffer
(setq ibuffer-use-other-window t) ;; always display ibuffer in another window

;; GROUP: Convenience -> Linum
(add-hook 'prog-mode-hook 'linum-mode) ;; enable linum only in programming modes

;; GROUP: Convenience -> Whitespace

;; whenever you create useless whitespace, the whitespace is highlighted
(add-hook 'prog-mode-hook (lambda () (interactive) (setq show-trailing-whitespace 1)))

;; activate whitespace-mode to view all whitespace characters
(global-set-key (kbd "C-c w") 'whitespace-mode)

;; GROUP: Convenience -> Windmove
;;
;; easier window navigation
;; use shift+up/down/left/right around window
(windmove-default-keybindings)


;;
;; PACKAGE: company
;;
;; GROUP: Convenience -> Company
;;
;; auto-completion
;;
;; M-n/M-p: move up and down
;; RET: complete
;; TAB: complete the common
;; M-{0,9}: locate the first ten guys
(require 'company)
(require 'cc-mode)
(add-hook 'after-init-hook 'global-company-mode)

;; check this, I plan to use the semantic back-end
;;
;; (setq company-backends (delete 'company-semantic company-backends))
(define-key c-mode-map  [(tab)] 'company-complete)
(define-key c++-mode-map  [(tab)] 'company-complete)

;;
;; Package: company-c-headers
;;
(require 'company-c-headers)
(add-to-list 'company-backends 'company-c-headers)
;; c++ headers
;; for my mac
(if (eq system-type 'darwin)
    (add-to-list
     'company-c-headers-path-system
     "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.10.sdk/usr/include/c++/4.2.1/")
  (add-to-list
   'company-c-headers-path-system
   "/usr/include/c++/4.8.2/"))

;; may try auto-complete
;; (require 'auto-complete)
;; (require 'auto-complete-config)
;; (ac-config-default)
;; (defun my:ac-c-header-init ()
;;   (require 'auto-complete-c-headers)
;;   )
;; (add-hook 'c-mode-common-hook )


;;
;; Package: expand-region
;;
;; GROUP: Convenience -> Abbreviation -> Expand
;;
(require 'expand-region)
(global-set-key (kbd "M-m") 'er/expand-region)


;; enable ibuffer
(require 'ibuffer)
(global-set-key (kbd "C-x C-b") 'ibuffer)

;;
;; set iBuffer as VC mode
;;
(add-hook 'ibuffer-hook
          (lambda ()
            (ibuffer-vc-set-filter-groups-by-vc-root)
            (unless (eq ibuffer-sorting-mode 'alphabetic)
              (ibuffer-do-sort-by-alphabetic))))

(setq ibuffer-formats
      '((mark modified read-only vc-status-mini " "
              (name 18 18 :left :elide)
              " "
              (size 9 -1 :right)
              " "
              (mode 16 16 :left :elide)
              " "
              (vc-status 16 16 :left)
              " "
              filename-and-process)))


;;
;; PACKAGES: projectile
;;
;; GROUP: Convenience -> Projectile
;;
;; like ido + smex + ido-ubiquitous + flx-ido  ;; seems no!
;;
;;
;; C-c p f: Jump to any file in the project
;; C-c p d: Jump to any directory in the project
;; C-c p b: List buffers local to current project
;; C-c p e: Jump to recently visited files in project
;; C-c p g s: Grep in project
;; C-c p o: Multi-occur in project buffers
;; C-c p r: Simple refactoring with text replace in current project
;; C-c p p: Switch visited projects (visited once an Projectile remembers)

(projectile-global-mode)


;;
;; GROUP: Development -> Extensions -> Ido
;;
;; (require 'ido)

;; (setq ido-enable-prefix nil
;;       ido-enable-flex-matching t
;;       ido-create-new-buffer 'always
;;       ido-use-filename-at-point 'guess
;;       ido-max-prospects 10
;;       ido-default-file-method 'selected-window
;;       ido-auto-merge-work-directories-length -1)

;; (ido-mode +1)


;;
;; PACKAGE: ido-ubiquitous
;;
;; GROUP: Development -> Extensions -> Ido -> Ido Ubiquitous
;;
;;(ido-ubiquitous-mode +1)


;;
;; PACKAGE: flx-ido
;;
;; GROUP: Development -> Extensions -> Ido
;;
;;; smarter fuzzy matching for ido
;; (flx-ido-mode +1)
;; disable ido faces to see flx highlights
;; (setq ido-use-faces nil)


;;
;; PACKAGE: smex
;;
;; GROUP: Convenience -> Extensions -> Smex
;;
;; (require 'smex)
;; (smex-initialize)
;; (global-set-key (kbd "M-x") 'smex)
;; (global-set-key (kbd "M-X") 'smex-major-mode-commands)


;; helm
;; Try helm and disabling ido and smex
(require 'helm)
(require 'helm-config)

(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebind tab to run persistent action

;; (define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB work in terminal
;; (define-key helm-map (kbd "C-z")  'helm-select-action) ; list actions using C-z

;; enable fuzzy match
(setq helm-mode-fuzzy-match                 t
      helm-completion-in-region-fuzzy-match t
      )
(setq helm-recentf-fuzzy-match              t
      helm-buffers-fuzzy-matching           t
      helm-locate-fuzzy-match               t
      helm-M-x-fuzzy-match                  t
      helm-semantic-fuzzy-match             t
      helm-imenu-fuzzy-match                t
      helm-apropos-fuzzy-match              t
      helm-lisp-fuzzy-completion            t
      helm-session-fuzzy-match              t
      helm-etags-fuzzy-match                t
      )


(setq helm-split-window-in-side-p           t ; open helm buffer inside current window, not occupy whole other window
      helm-move-to-line-cycle-in-source     t ; move to end or beginning of source when reaching top or bottom of source.
      helm-ff-search-library-in-sexp        t ; search for library in `require' and `declare-function' sexp.
      helm-scroll-amount                    8 ; scroll 8 lines other window using M-<next>/M-<prior>
      helm-ff-file-name-history-use-recentf t
      helm-echo-input-in-header-line t
      )

(global-set-key (kbd "M-x") #'helm-M-x)
(global-set-key (kbd "C-x r b") #'helm-filtered-bookmarks)
(global-set-key (kbd "C-x C-f") #'helm-find-files)

(helm-mode 1)

(define-key helm-find-files-map (kbd "<tab>") 'helm-ff-RET)

;;
;; jump to line
;;
(global-set-key (kbd "C-j") 'goto-line)
