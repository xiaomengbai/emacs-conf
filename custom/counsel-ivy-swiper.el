;; This module is for counsel, ivy, and swiper


(use-package counsel
  :diminish ivy-mode
  :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t)
  (setq ivy-count-format "(%d/%d)")
  (setq ivy-initial-inputs-alist nil)
  :bind (("C-s" . swiper)
	 ("C-c C-r" . ivy-resume)
	 ("M-x" . counsel-M-x)
	 ("C-h f" . counsel-describe-function)
	 ("C-h v" . counsel-describe-variable)
	 )
  )

;; in :bind
;; 	 ("C-x C-f" . counsel-find-file)
;;	 :map minibuffer-local-map
;;	 ("C-r" . 'counsel-minibuffer-history)


;; add extra message to ivy
(use-package ivy-rich
  :diminish ivy-rich-mode
  :config
  (ivy-rich-mode t)
  )

(use-package ivy-bibtex
  )


;; (use-package counsel
;;   :bind (("C-s" . swiper)
;; 	 ("M-x" . counsel-M-x)
;; 	 :map ivy-minibuffer-map
;; 	 ("TAB" . ivy-alt-done)
;; 	 ("C-l" . ivy-alt-done)
;; 	 ("C-j" . ivy-next-line)
;; 	 ("C-k" . ivy-previous-line)
;; 	 :map ivy-switch-buffer-map
;; 	 ("C-k" . ivy-previous-line)
;; 	 ("C-l" . ivy-done)
;; 	 ("C-d" . ivy-switch-buff-kill)
;; 	 :map ivy-reverse-i-search-map
;; 	 ("C-k" . ivy-previous-line)
;; 	 ("C-d" . ivy-reverse-i-search-kill))
;;   :config
;;   (ivy-mode 1)
;;   (setq ivy-use-virtual-buffers t)
;;   (setq ivy-count-format "(%d/%d)")
;;   )
;; ;;(load-theme 'tango-dark)
;; (setq ivy-format-function 'ivy-format-function-line)



(provide 'counsel-ivy-swiper)
