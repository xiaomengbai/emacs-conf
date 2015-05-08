(provide 'setup-programming)
;; GROUP: Programming -> Languages -> C

;; Available C style:
;; “gnu”: The default style for GNU projects
;; “k&r”: What Kernighan and Ritchie, the authors of C used in their book
;; “bsd”: What BSD developers use, aka “Allman style” after Eric Allman.
;; “whitesmith”: Popularized by the examples that came with Whitesmiths C, an early commercial C compiler.
;; “stroustrup”: What Stroustrup, the author of C++ used in his book
;; “ellemtel”: Popular C++ coding standards as defined by “Programming in C++, Rules and Recommendations,” Erik Nyquist and Mats Henricson, Ellemtel
;; “linux”: What the Linux developers use for kernel development
;; “python”: What Python developers use for extension modules
;; “java”: The default style for java-mode (see below)
;; “user”: When you want to define your own style
(setq c-default-style "k&r" ; set style to "linux"
      c-basic-offset 4)

;;
;; GROUP: Programming -> Tools -> Gdb
;;
(setq gdb-many-windows t        ; use gdb-many-windows by default
      gdb-show-main t)          ; Non-nil means display source file containing the main routine at startup

;;
;; GROUP: Programming -> Tools -> Compilation
;;
;; Compilation from Emacs
(defun prelude-colorize-compilation-buffer ()
  "Colorize a compilation mode buffer."
  (interactive)
  ;; we don't want to mess with child modes such as grep-mode, ack, ag, etc
  ;; how?
  (when (eq major-mode 'compilation-mode)
    (let ((inhibit-read-only t))
      (ansi-color-apply-on-region (point-min) (point-max)))))

;; setup compilation-mode used by `compile' command
(require 'compile)
(setq compilation-ask-about-save nil          ; Just save before compiling
      compilation-always-kill t               ; Just kill old compile processes before starting the new one
      compilation-scroll-output 'first-error) ; Automatically scroll to first
;;(global-set-key (kbd "<f5>") 'compile)
(global-set-key (kbd "C-c C-c") 'compile)

;; GROUP: Programming -> Tools -> Makefile
;; takenn from prelude-c.el:48: https://github.com/bbatsov/prelude/blob/master/modules/prelude-c.el
;; what's this...
(defun prelude-makefile-mode-defaults ()
  (whitespace-toggle-options '(tabs))
  (setq indent-tabs-mode t ))

(setq prelude-makefile-mode-hook 'prelude-makefile-mode-defaults)

(add-hook 'makefile-mode-hook (lambda ()
                                (run-hooks 'prelude-makefile-mode-hook)))

;; GROUP: Programming -> Tools -> Ediff
;; never used...
(setq ediff-diff-options "-w"
      ediff-split-window-function 'split-window-horizontally
      ediff-window-setup-function 'ediff-setup-windows-plain)

;;
;; PACKAGE: diff-hl
;;
;; GROUP: Programming -> Tools -> Vc -> Diff Hl
;;
(global-diff-hl-mode)
(add-hook 'dired-mode-hook 'diff-hl-dired-mode)


;;
;; PACKAGE: magit
;;
;; GROUP: Programming -> Tools -> Magit
;;
(require 'magit)
(set-default 'magit-stage-all-confirm nil)
(add-hook 'magit-mode-hook 'magit-load-config-extensions)

;; full screen magit-status
(defadvice magit-status (around magit-fullscreen activate)
  (window-configuration-to-register :magit-fullscreen)
  ad-do-it
  (delete-other-windows))

;; OK, "C-x g" for git
;;
;; Usage:
;;
;; Getting started with Magit is really easy:
;;
;; M-x magit-status to see git status, and in the status buffer:
;; s to stage files
;; c c to commit, type in your commit message then C-c C-c to save the message and commit, C-c C-k to abort current commit message and go back magit-status.
;; b b to switch to a branch.
;; Other handy keys:
;;
;; P P to do a git push
;; F F to do a git pull
;; try to press TAB on entries.
;; If you want to view the raw git commands, i.e. you want to know how git push is doing, press $.
;;
;; For more usage, please refer to the official manual.
;; http://magit.github.io/documentation

(global-unset-key (kbd "C-x g"))
(global-set-key (kbd "C-x g h") 'magit-log)
(global-set-key (kbd "C-x g f") 'magit-file-log)
(global-set-key (kbd "C-x g b") 'magit-blame-mode)
(global-set-key (kbd "C-x g m") 'magit-branch-manager)
(global-set-key (kbd "C-x g c") 'magit-branch)
(global-set-key (kbd "C-x g s") 'magit-status)
(global-set-key (kbd "C-x g r") 'magit-reflog)
(global-set-key (kbd "C-x g t") 'magit-tag)


;;
;; PACKAGE: flycheck
;;
;; GROUP: Programming -> Tools -> Flycheck
;;
;; (require 'flycheck)
;; (add-hook 'after-init-hook 'global-flycheck-mode)
;; which is wrong?
;;(add-hook 'after-init-hook #'global-flycheck-mode)

;;
;; PACKAGE: flycheck-tip
;;
;; GROUP: Flycheck Tip, but just consider it part of Flycheck
;;
;; error: eclim-tip.el:31:1:Error: Cannot open load file: eclim

;; (require 'flycheck-tip)
;; (flycheck-tip-use-timer 'verbose)



;; ggtags
;; This is a code navigation component
;; also tag generation thing?
;;
;; the ggtags seems need install 3rd software
;; get it work larter
;;
;;
;; (require 'ggtags)
;; (add-hook 'c-mode-common-hook
;;           (lambda ()
;;             (when (derived-mode-p 'c-mode 'c++-mode 'java-mode 'asm-mode)
;;               (ggtags-mode 1))))

;; (define-key ggtags-mode-map (kbd "C-c g s") 'ggtags-find-other-symbol)
;; (define-key ggtags-mode-map (kbd "C-c g h") 'ggtags-view-tag-history)
;; (define-key ggtags-mode-map (kbd "C-c g r") 'ggtags-find-reference)
;; (define-key ggtags-mode-map (kbd "C-c g f") 'ggtags-find-file)
;; (define-key ggtags-mode-map (kbd "C-c g c") 'ggtags-create-tags)
;; (define-key ggtags-mode-map (kbd "C-c g u") 'ggtags-update-tags)

;; (define-key ggtags-mode-map (kbd "M-,") 'pop-tag-mark)



;; Semantics

(require 'cc-mode)
(require 'semantic)

;; restore parsing result to database
(global-semanticdb-minor-mode 1)
;; parsing when idle
(global-semantic-idle-scheduler-mode 1)

(semantic-mode 1)

;; add header files to system include
;; (semantic-add-system-include "/usr/include/boost" 'c++-mode)
;; (semantic-add-system-include "~/linux/kernel")
;; (semantic-add-system-include "~/linux/include")
;;
;; try semantic-ia-fast-jump to jump to the point
(semantic-add-system-include "/usr/local/include/")
;; sticky function name
(global-semantic-stickyfunc-mode 1)


;;
;; Package: function-args
;;
(require 'function-args)
(fa-config-default)
;;(define-key c-mode-map  [(contrl tab)] 'moo-complete)
;;(define-key c++-mode-map  [(control tab)] 'moo-complete)
(define-key c-mode-map (kbd "M-o")  'fa-show)
(define-key c++-mode-map (kbd "M-o")  'fa-show)

(add-hook 'c-mode-common-hook (lambda ()
                                (local-set-key (kbd "C-c C-c") 'compile)))
