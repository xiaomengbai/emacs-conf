;; we load "package" and "use-package" in this module
(message "Loading package management packages...")
(require 'package)
(setq package-archives '(
                         ;;("melpa" . "https://melpa.org/packages/")
                         ;;("melpa" . "https://elpa.zilongshanren.com/melpa/")
			 ;;("org" . "https://orgmode.org/elpa/")
                         ;;("org" . "https://elpa.zilongshanren.com/org/")
                         ;;("gnu" . "https://elpa.gnu.org/packages/")
                         ;;("gnu" . "https://mirror.iscas.ac.cn/elpa/")
                         ;;("gnu" . "https://elpa.zilongshanren.com/gnu/")
                         ("melpa" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")
                         ("org" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/org/")
                         ("gnu" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
			 ))
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; install use-package
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))
;; use-package automatically install the package
(setq use-package-always-ensure t)

(provide 'package-management)
