;; Let's begin !
;; only the init.el and custom/ are useful

;; First we want to add the package manage
(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.milkbox.net/packages/") t)

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





;;
;; package: workgroups2
;; convenience -> workgroups
;;
;; restore the session
(require 'workgroups2)
(workgroups-mode 1)



(provide 'init)
;;; init.el ends here
