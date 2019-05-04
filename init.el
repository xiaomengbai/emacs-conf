;; Let's begin !
;; only the init.el and custom/ are useful

;; First we want to add the package manage
(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.milkbox.net/packages/") t)

;; add all packages required here
(setq package-list '(undo-tree yasnippet rebox2 yasnippet-snippets helm
		     volatile-highlights workgroups2 duplicate-thing
                     smartparens clean-aindent-mode company
                     expand-region ibuffer-vc projectile
                     recentf-ext ztree
                     vlf saveplace shell-pop
                     diff-hl magit flycheck
                     flycheck-tip nyan-mode golden-ratio
                     highlight-numbers highlight-symbol color-theme-solarized
                     discover-my-major rainbow-mode
                     sr-speedbar function-args company-c-headers
                     dtrt-indent ws-butler smex
                     flx-ido ido
                     monokai-theme zenburn-theme color-theme-sanityinc-tomorrow
                     js2-mode ac-js2 ggtags
		     ))

(package-initialize)

;; refresh the package list, I am not sure
;; if it works. The next function seems not
;; check the version staff
(unless package-archive-contents
  (package-refresh-contents))

;; Install all packages not installed
(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))

;; OK, we manage our *.el files as package(use require) not the
;; source file (use load)
;;
;; (mapc 'load (directory-files "~/.emacs.d/custom" t ".*\.el"))

;; add the path
(add-to-list 'load-path "~/.emacs.d/custom/")

;; load modules
;; (require 'setup-helm)
;; (require 'setup-helm-gtags)
;; (require 'ggtags)

(require 'setup-applications)
(require 'setup-communication)
(require 'setup-convenience)
(require 'setup-data)
(require 'setup-development)
(require 'setup-editing)
(require 'setup-environment)
(require 'setup-external)
(require 'setup-files)
(require 'setup-help)
(require 'setup-programming)
(require 'setup-text) ;; nothing
;; (require 'setup-local)
;; (require 'setup-multimedia)

(if (eq system-type 'windows-nt)
    (setq tramp-default-method "plinkx"))

(require 'tramp)
(setq explicit-shell-file-name "/bin/bash")

(add-to-list 'tramp-remote-path "/home/xiao.735/externs/bin")
(add-to-list 'tramp-remote-path 'tramp-own-remote-path)
;; (add-to-list 'tramp-remote-process-environment "SHELL=/bin/bash")
;; (add-to-list 'tramp-remote-process-environment "PATH=/home/xiao.735/externs/bin:$PATH")
;; (setq ispell-program-name "aspell")

;;,----------------------------------------------------------
;;| manage the comment Mark the comment region and then "M-Q"
;;`----------------------------------------------------------
(require 'rebox2)
(rebox-mode t)


;;
;; package: workgroups2
;; convenience -> workgroups
;;
;; restore the session
(require 'workgroups2)
(workgroups-mode 1)

;; (server-start)

(provide 'init)

(global-set-key "\C-c \C-c" 'compile)

;;; init.el ends here
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (sanityinc-tomorrow-night)))
 '(custom-safe-themes
   (quote
    ("06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" default)))
 '(helm-mode t)
 '(org-agenda-files (quote ("~/projects/note/todo.org")) t)
 '(package-selected-packages
   (quote
    (helm yasnippet yasnippet-snippets yasnippet-classic-snippets cuda-mode gnuplot-mode cmake-mode ztree zenburn-theme ws-butler workgroups2 volatile-highlights vlf undo-tree sr-speedbar smex smartparens shell-pop recentf-ext rebox2 rainbow-mode projectile nyan-mode monokai-theme magit ibuffer-vc highlight-symbol highlight-numbers golden-ratio ggtags function-args flycheck-tip flx-ido expand-region duplicate-thing dtrt-indent discover-my-major diff-hl company-c-headers color-theme-solarized color-theme-sanityinc-tomorrow clean-aindent-mode ac-js2)))
 '(tex-dvi-view-command
   (quote
    (cond
     ((eq window-system
          (quote x))
      "emacsclient -e '(progn (find-file-other-window \"*\"))'")
     ((eq window-system
          (quote w32))
      "yap")
     (t "dvi2tty * | cat -s")))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


(require 'setup-faces-and-ui)
(setq org-agenda-files (list "~/work/note.org"))
