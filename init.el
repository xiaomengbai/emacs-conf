;; setup the path to load customized modules
(add-to-list 'load-path "~/.emacs.d/custom/")

(require 'package-management)
(require 'setup-ui)
(require 'setup-convenience)
;; (require 'counsel-ivy-swiper)
(require 'setup-helm)
(require 'help-enhancement)
(require 'setup-programming)
(require 'setup-file)
(require 'setup-org-mode)

(setq
 erc-nick "andrewuds"
 erc-user-full-name "andrewuds")

(defun connect-irc ()
  (lambda ()
    (interactive)
    (erc :server "irc.libera.chat"
         :port   "6667")))
