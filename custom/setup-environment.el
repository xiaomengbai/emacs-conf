(provide 'setup-environment)

;;
;; GROUP: Environment -> Initialization
;;
;; what's this?
(setq inhibit-startup-screen t)

;;
;; GROUP: Environment -> Minibuffer 
;;
;; (icomplete-mode)

;;
;; GROUP: Environment -> Minibuffer -> Savehist
;;
;; savehist saves minibuffer history by defaults
(setq savehist-additional-variables '(search ring regexp-search-ring) ; also save your regexp search queries
      savehist-autosave-interval 60     ; save every minute
      )

;;
;; GROUP: Environment -> Windows -> Winner
;;
;; what's this?
(winner-mode 1)

;;
;; GROUP: Environment -> Mode Line
;;
(column-number-mode 1)


;;
;; PACKAGE: nyan-mode
;;
;; GROUOP: Environment -> Frames -> Nyan
;;
;; only turn on if a window system is available
;; this prevents error under terminal that does not support X
(case window-system
  ((x w32) (nyan-mode)))


;;
;; PACKAGE: golden-ratio
;;
;; GROUP: Environment -> Windows -> Golden Ratio
;;
(require 'golden-ratio)

(add-to-list 'golden-ratio-exclude-modes "ediff-mode")
(add-to-list 'golden-ratio-exclude-modes "helm-mode")
(add-to-list 'golden-ratio-exclude-modes "dired-mode")
(add-to-list 'golden-ratio-inhibit-functions 'pl/helm-alive-p)

(defun pl/helm-alive-p ()
  (if (boundp 'helm-alive-p)
      (symbol-value 'helm-alive-p)))

;; ediff
(eval-after-load "golden-ratio"
  '(progn
     (add-to-list 'golden-ratio-exclude-modes "ediff-mode")
     (add-to-list 'golden-ratio-inhibit-functions 'pl/ediff-comparison-buffer-p)))

(defun pl/ediff-comparison-buffer-p ()
  (and (boundp 'ediff-this-buffer-ediff-sessions)
       ediff-this-buffer-ediff-sessions))

;; The version which also called balance-windows at this point looked
;; a bit broken, but could probably be replaced with:
;;
;; (defun pl/ediff-comparison-buffer-p ()
;;   (and (boundp 'ediff-this-buffer-ediff-sessions)
;;        ediff-this-buffer-ediff-sessions
;;        (prog1 t (balance-windows))))
;;
;; However I think the following has the desired effect, and without
;; messing with the ediff control buffer:
;;
(add-hook 'ediff-startup-hook 'my-ediff-startup-hook)

(defun my-ediff-startup-hook ()
  "Workaround to balance the ediff windows when golden-ratio is enabled."
  ;; There's probably a better way to do it.
  (ediff-toggle-split)
  (ediff-toggle-split))


;; do not enable golden-raio in thses modes
(setq golden-ratio-exclude-modes '("ediff-mode"
                                   "gud-mode"
                                   "gdb-locals-mode"
                                   "gdb-registers-mode"
                                   "gdb-breakpoints-mode"
                                   "gdb-threads-mode"
                                   "gdb-frames-mode"
                                   "gdb-inferior-io-mode"
                                   "gud-mode"
                                   "gdb-inferior-io-mode"
                                   "gdb-disassembly-mode"
                                   "gdb-memory-mode"
                                   "magit-log-mode"
                                   "magit-reflog-mode"
                                   "magit-status-mode"
                                   "IELM"
                                   "eshell-mode" "dired-mode"))
(golden-ratio-mode)

