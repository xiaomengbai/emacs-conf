(provide 'setup-help)

;;
;; GROUP: Help -> Info+
;;
(require 'info+)


;; A quick major mode help with discover-my-major
(global-unset-key (kbd "C-h h"))        ;; original "C-h h" displays "hello world" in different languages
(define-key 'help-command (kbd "h m") 'discover-my-major)

;;
;; PACKAGE: rainbow-mode
;;
;; GROUP: Help -> Rainbow
;;
(add-hook 'html-mode-hook 'rainbow-mode)
(add-hook 'css-mode-hook 'rainbow-mode)


;;
;; Package: help+
;;
;; GROUP: Help
;;
;; "C-h u" `manual-entry' 
;; `C-h C-a' `apropos'
;; `C-h C-l' `locate-library'
;; `C-h RET' `help-on-click/key'
;; `C-h M-a' `apropos-documentation'
;; `C-h M-o' `pop-to-help-toggle'
;; `C-h C-M-a' `tags-apropos'
;; [mouse-1] `mouse-help-on-click'
;; (non-mode-line) [mouse-1] `mouse-help-on-mode-line-click' (mode-line)
(require 'help+)


;;
;; Package: help-fns+
;;
;; GROUP: Help
;;
;; C-h B	describe-buffer
;; C-h c	describe-command (replaces describe-key-briefly)
;; C-h o	describe-option
;; C-h C-c	describe-key-briefly (replaces C-h c)
;; C-h C-o	describe-option-of-type
;; C-h M-c	describe-copying (replaces C-h C-c)
;; C-h M-f	describe-file
;; C-h M-k	describe-keymap
;; C-h M-l	find-function-on-key
(require 'help-fns+)


;;
;; Package: help-mode+ 
;;
;; GROUP: Help
;;
(require 'help-mode+)
