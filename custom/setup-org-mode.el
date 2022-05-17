;; This module setups org-mode

(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-cb" 'org-switchb)
(global-set-key "\C-c(" 'org-time-stamp-inactive)


(defun efs/org-mode-setup ()
  (org-indent-mode)
  (visual-line-mode 1))

(use-package org
  :hook (org-mode . efs/org-mode-setup)
  :config
  (add-to-list 'org-file-apps '(directory . emacs))
  (add-to-list 'org-link-frame-setup '(file . find-file))
  (setq org-archive-location "archives.org::")
  :bind (("M-." . org-open-at-point)
         ("M-," . org-mark-ring-goto))
  )

;;
(setq org-directory "~/work/krepo/")
;; org-default-notes-file used for capture
;; (setq org-default-notes-file (concat org-directory "projects.org"))
(setq org-default-notes-file (concat org-directory ".notes"))
(setq org-agenda-files (list org-default-notes-file))

;; setup babel languages
(org-babel-do-load-languages
 'org-babel-load-languages
 '((lisp . t) (perl . t)))

(use-package vterm
  :config
  (setq vterm-timer-delay 0.01)
  )

;; do not prompt before evaluate code blocks
(setq org-confirm-babel-evaluate nil)

;; set column fill width
;; (set-fill-column 120)
(defun my-set-fill-column-120 ()
    "set text filled approximately at column 120."
  (interactive)
  (set-fill-column 120))
(add-hook 'org-mode-hook 'my-set-fill-column-120)
(add-hook 'text-mode 'my-set-fill-column-120)
(add-hook 'tex-mode 'my-set-fill-column-120)

(use-package pdf-tools
  :config
  (pdf-tools-install)
  )

(use-package org-pdftools
  )

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

;;(use-package ebib)

;;(add-to-list 'org-structure-template-alist '("el" "#+BEGIN_SRC emacs-lisp\n?\n#+END_SRC"))
;;(add-to-list 'org-structure-template-alist '("cpp" "#+BEGIN_SRC C++\n?\n#+END_SRC"))

(use-package yasnippet
  :config
  (yas-global-mode 1)
  ;; :bind (:map yas-minor-mode-map
  ;;             ("SPC" . 'yas-maybe-expand))
  )


(use-package org-roam
  :ensure t
  :custom
  (org-roam-directory "~/work/krepo/knowledge")
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
  (setq org-roam-node-display-template (concat "${title:*} " (propertize "${tags:10}" 'face 'org-tag)))
  (org-roam-db-autosync-mode)
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

;; (defun org-export-latex-no-toc (depth)
;;   (when depth
;;     (format "%% Org-mode is exporting headings to %s levels.\n"
;;             depth)))
;; (setq org-export-latex-format-toc-function 'org-export-latex-no-toc)

(provide 'setup-org-mode)