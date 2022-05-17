
(use-package helm
  :diminish helm-mode
  :config
  (helm-mode 1)
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
  (setq helm-split-window-inside-p           t ; open helm buffer inside current window, not occupy whole other window
	helm-move-to-line-cycle-in-source     t ; move to end or beginning of source when reaching top or bottom of source.
	helm-ff-search-library-in-sexp        t ; search for library in `require' and `declare-function' sexp.
	helm-scroll-amount                    8 ; scroll 8 lines other window using M-<next>/M-<prior>
	helm-echo-input-in-header-line        t
	helm-ff-file-name-history-use-recentf t
	)
  (setq helm-autoresize-max-height 40)
  (setq helm-autoresize-min-height 20)
  (helm-autoresize-mode 1)
  :bind (("M-x" . #'helm-M-x)
	 ("C-x r b" . #'helm-filtered-bookmarks)
	 ("C-x C-f" . #'helm-find-files)
	 ("C-z" . 'helm-select-action)
	 ("C-x b" . #'helm-mini)
	 :map helm-map
	 ("<tab>" . 'helm-execute-persistent-action)
	 :map helm-find-files-map
	 ("<tab>" . 'helm-ff-RET)
	 )
  )
  
;;(require 'helm-config)

;; (define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB work in terminal
;; (define-key helm-map (kbd "C-z")  'helm-select-action) ; list actions using C-z

;; enable fuzzy match


;; (defun helm-my-buffers ()
;;   (interactive)
;;   (helm-other-buffer '(;helm-source-buffers-list
;;                        ;helm-source-bookmark-files&dirs
;;                        helm-source--ff-file-name-history)
;;                        ;helm-source-file-name-history
;;                        ;helm-source-buffer-not-found)
;;                      "*helm-my-buffers*"))
;; (global-set-key (kbd "C-x C-f") #'helm-my-buffers)


;;(define-key helm-find-files-map (kbd "<tab>") 'helm-ff-RET)



(provide 'setup-helm)
