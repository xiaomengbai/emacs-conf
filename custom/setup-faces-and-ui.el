(provide 'setup-faces-and-ui)

;; theme
;; solarized
;; Too dark
;; (load-theme 'solarized t)
;; (set-frame-parameter nil 'background-mode 'dark)
;; (enable-theme 'solarized)

;;;; (add-hook 'after-make-frame-functions
;;;;           (lambda (frame)
;;;;             (set-frame-parameter frame
;;;;                                  'background-mode
;;;;                                  (if (display-graphic-p frame) 'light 'dark))
;;;;             (enable-theme 'solarized)))


;; weird font in org-mode
;; (load-theme 'monokai t)
;; (enable-theme 'monokai) 

;; zenburn theme
;;(load-theme 'zenburn t)

;; sanitynic-tomorrow
(setq custom-safe-themes t)
(require 'color-theme-sanityinc-tomorrow)

;; (color-theme-sanityinc-tomorrow-day) ;; worst one
(color-theme-sanityinc-tomorrow-night)
;; (color-theme-sanityinc-tomorrow-blue) ;; blue!
;; (color-theme-sanityinc-tomorrow-bright) ;; not bad
;; (color-theme-sanityinc-tomorrow-eighties)


;; set face size
(set-face-attribute 'default nil :height 130)

;; you won't need any of the bar thingies
;; turn it off to save screen estate
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))

;; the blinking cursor is nothing, but an annoyance
(blink-cursor-mode -1)

(setq scroll-margin 0
      scroll-conservatively 100000
      scroll-preserve-screen-position 1)

(size-indication-mode t)

;; more useful frame title, that show either a file or a
;; buffer name (if the buffer isn't visiting a file)
;; taken from prelude-ui.el
(setq frame-title-format
      '("" invocation-name " - " (:eval (if (buffer-file-name)
                                                    (abbreviate-file-name (buffer-file-name))
                                                  "%b"))))

;; change font to Inconsolata for better looking text
;; remember to install the font Inconsolata first
;; (setq default-frame-alist '((font . "Inconsolata-11")))
;; set italic font for italic face, since Emacs does not set italic
;; face automatically
;; (set-face-attribute 'italic nil
;;                     :family "Inconsolata-Italic")


;;
;; PACKAGE: highlight-numbers
;;
;; GROUP: Faces -> Number Font Lock
;;
(add-hook 'prog-mode-hook 'highlight-numbers-mode)


;;
;; PACKAGE: highlight-symbol
;;
(require 'highlight-symbol)

(highlight-symbol-nav-mode)

(add-hook 'prog-mode-hook (lambda () (highlight-symbol-mode)))
(add-hook 'org-mode-hook (lambda () (highlight-symbol-mode)))

(setq highlight-symbol-idle-delay 0.2
      highlight-symbol-on-navigation-p t)

(global-set-key [(control shift mouse-1)]
                (lambda (event)
                  (interactive "e")
                  (goto-char (posn-point (event-start event)))
                  (highlight-symbol-at-point)))

;; next/previous symbol
(global-set-key (kbd "M-n") 'highlight-symbol-next)
(global-set-key (kbd "M-p") 'highlight-symbol-prev)

;; chinese-font
(set-fontset-font t 'han (font-spec :name "Songti SC"))
