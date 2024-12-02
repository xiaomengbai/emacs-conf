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


;; notmuch
;; (require 'notmuch)
;; (setq +notmuch-sync-backend 'mbsync)
;; (setq notmuch-saved-searches '((:name "Unread"
;;                                 :query "tag:inbox and tag:unread"
;;                                 :count-query "tag:inbox and tag:unread"
;;                                 :sort-order newest-first)
;;                                (:name "Inbox"
;;                                 :query "tag:inbox"
;;                                 :count-query "tag:inbox"
;;                                 :sort-order newest-first)
;;                                (:name "Archive"
;;                                 :query "tag:archive"
;;                                 :count-query "tag:archive"
;;                                 :sort-order newest-first)
;;                                (:name "Sent"
;;                                 :query "tag:sent or tag:replied"
;;                                 :count-query "tag:sent or tag:replied"
;;                                 :sort-order newest-first)
;;                                (:name "Trash"
;;                                 :query "tag:deleted"
;;                                 :count-query "tag:deleted"
;;                                 :sort-order newest-first))
;;       )

(provide 'setup-file)
