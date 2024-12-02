
;; Setup the package manager
(require 'package)
(setq package-archives '(
                         ("melpa" . "https://melpa.org/packages/")
                         ;;("melpa" . "https://elpa.zilongshanren.com/melpa/")
                         ;;("org" . "https://orgmode.org/elpa/")
                         ;;("org" . "https://elpa.zilongshanren.com/org/")
                         ("gnu" . "https://elpa.gnu.org/packages/")
                         ;;("gnu" . "https://mirror.iscas.ac.cn/elpa/")
                         ;;("gnu" . "https://elpa.zilongshanren.com/gnu/")
                         ;;("melpa" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")
                         ;;("org" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/org/")
                         ;;("gnu" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
                         ))
(package-initialize)
(eval-after-load 'gnutls
  '(add-to-list 'gnutls-trustfiles "/etc/ssl/cert.pem"))

(unless package-archive-contents
  (package-refresh-contents))

;; use-package
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))
;; use-package automatically install the package
(setq use-package-always-ensure t)


;; directly load from the org file
(org-babel-load-file (expand-file-name "~/.emacs.d/myinit.org"))



;; ;; setup the path to load customized modules
;; (add-to-list 'load-path "~/.emacs.d/custom/")


;; (require 'package-management)
;; (require 'setup-ui)
;; (require 'setup-convenience)
;; ;; (require 'counsel-ivy-swiper)
;; (require 'setup-helm)
;; (require 'help-enhancement)
;; (require 'setup-programming)
;; (require 'setup-file)
;; (require 'setup-org-mode)

;; (global-set-key (kbd "<f5>") 'revert-buffer)
;; (use-package try
;;   :ensure t)


;; (setq
;;  erc-nick "andrewuds"
;;  erc-user-full-name "andrewuds")

;; (defun connect-irc ()
;;   (lambda ()
;;     (interactive)
;;     (erc :server "irc.libera.chat"
;;          :port   "6667")))

;; (require 'desktop)
;; (defun xmb/desktop-read ()
;;   (interactive)
;;   (progn
;;     (desktop-release-lock)
;;     (desktop-read)))
;; ;; customize the variables in another file
;; (setq custom-file (locate-user-emacs-file "custom-vars.el"))
;; (load custom-file 'noerror 'nomessage)
