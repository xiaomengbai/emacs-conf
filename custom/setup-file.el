;; This module setup file/dir related issues

(setq dired-dwim-target t)
(setq dired-recursive-copies 'always)
(setq dired-recursive-deletes 'top)
(setq dired-listing-switches "-lha")
(unless (eq system-type 'windows-nt)
  (setq dired-listing-switches "-lha --group-directories-first"))

(define-key dired-mode-map (kbd "TAB") 'dired-hide-subdir)

(recentf-mode 1)
(savehist-mode 1)
(save-place-mode 1)
(setq use-dialog-box nil)
(global-auto-revert-mode 1)

;; tramp
(require 'tramp)
(setq password-cache-expiry nil)

(provide 'setup-file)
