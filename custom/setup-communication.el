(provide 'setup-communication)

;; go-to-address-mode
;; the URLs
(add-hook 'prog-mode-hook 'goto-address-mode)
(add-hook 'text-mode-hook 'goto-address-mode)

;; tramp
(require 'tramp)
(setq password-cache-expiry nil)
