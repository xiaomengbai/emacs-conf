;; Let's begin !
;; only the init.el and custom/ are useful

;; First we want to add the package manage
(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.milkbox.net/packages/") t)

(add-to-list 'package-archives
            '("org" . "http://orgmode.org/elpa/") t)

;; add all packages required here
(setq package-list '(undo-tree yasnippet rebox2
		     volatile-highlights workgroups2 duplicate-thing
                    smartparens clean-aindent-mode company
                    expand-region ibuffer-vc projectile
                    dired+ recentf-ext ztree
                    vlf saveplace shell-pop
                    diff-hl magit flycheck
                    flycheck-tip nyan-mode golden-ratio
                    highlight-numbers highlight-symbol color-theme-solarized
                    info+ discover-my-major rainbow-mode
                    help+ help-fns+ help-mode+
                    sr-speedbar function-args company-c-headers
                    dtrt-indent ws-butler smex
                    flx-ido ido-ubiquitous ido
                    monokai-theme zenburn-theme color-theme-sanityinc-tomorrow
                    cnfonts ggtags
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

(require 'org)

;; add the path
(add-to-list 'load-path "~/.emacs.d/custom/")

;; OK, we manage our *.el files as package(use require) not the
;; source file (use load)
;;
;; (mapc 'load (directory-files "~/.emacs.d/custom" t ".*\.el"))
;;
;; load modules

(require 'setup-applications)
(require 'setup-communication)
(require 'setup-convenience)
(require 'setup-data)
(require 'setup-development)
(require 'setup-editing)
(require 'setup-environment)
(require 'setup-external)
(require 'setup-faces-and-ui)
(require 'setup-files)
(require 'setup-help)
(require 'setup-programming)
(require 'setup-text) ;; nothing
;; (require 'setup-local)
;; (require 'setup-multimedia)

;;,----------------------------------------------------------
;;| manage the comment Mark the comment region and then "M-Q"
;;`----------------------------------------------------------
(require 'rebox2)
(rebox-mode t)


(require 'cnfonts)
(cnfonts-enable)


;;
;; package: workgroups2
;; convenience -> workgroups
;;
;; restore the session
(require 'workgroups2)
(workgroups-mode 1)



(provide 'init)
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
 '(package-selected-packages
   (quote
    (org org-plus-contrib ztree zenburn-theme yasnippet ws-butler workgroups2 volatile-highlights vlf undo-tree sr-speedbar smex smartparens shell-pop recentf-ext rebox2 rainbow-mode projectile nyan-mode monokai-theme magit info+ ido-ubiquitous ibuffer-vc highlight-symbol highlight-numbers help-mode+ help-fns+ help+ helm golden-ratio gnuplot-mode gnuplot git-rebase-mode git-commit-mode ggtags function-args flycheck-tip flx-ido expand-region duplicate-thing dtrt-indent discover-my-major dired-rainbow dired+ diff-hl company-c-headers color-theme-solarized color-theme-sanityinc-tomorrow cnfonts clean-aindent-mode))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-cb" 'org-iswitchb)

(add-to-list 'tramp-remote-path "/home/xiao.735/externs/bin")

;; active Babel languages
(org-babel-do-load-languages
 'org-babel-load-languages
 '(
   (shell . t)
   (gnuplot . t)
   (perl . t)
   (C . t)
   )
 )
(setq org-confirm-babel-evaluate nil)
;; add additional languages with '((language . t)))
(setq org-src-tab-acts-natively t)


(setenv "PATH"
        (concat "/opt/local/bin" ":" "/usr/texbin" ":" "/Library/TeX/Distributions/.DefaultTeX/Contents/Programs/texbin" ":" (getenv "PATH")))
