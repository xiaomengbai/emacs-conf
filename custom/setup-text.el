(provide 'setup-text)


;; org-mode
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-cb" 'org-iswitchb)


;; set column fill width
;; (set-fill-column 120)
(defun my-set-fill-column-120 ()
    "set text filled approximately at column 120."
  (interactive)
  (set-fill-column 120))
;; May change this to use map
(add-hook 'org-mode-hook 'my-set-fill-column-120)
(add-hook 'text-mode 'my-set-fill-column-120)
(add-hook 'tex-mode 'my-set-fill-column-120)

(define-key text-mode-map (kbd "C-j") 'eval-print-last-sexp)
;;(define-key org-mode-map (kbd "C-j") 'eval-print-last-sexp)
