(provide 'setup-text)


;; org-mode
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-cb" 'org-iswitchb)

(setq org-directory "~/work/notes/")

;; setup babel languages
(org-babel-do-load-languages
 'org-babel-load-languages
 '((lisp . t) (perl . t)))

;; do not prompt before evaluate code blocks
(setq org-confirm-babel-evaluate nil)

;; set a default target file for capture
(setq org-default-notes-file (concat org-directory "captures.org"))

(setq org-agenda-files (list "~/work/projects.org" org-default-notes-file))

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
