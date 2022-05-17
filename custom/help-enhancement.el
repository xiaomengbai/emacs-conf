;; This module is for help enhancement

;; list possible key-bindings in the minibuffer
(use-package which-key
  :diminish which-key-mode
  :config
  (which-key-mode t)
  (setq which-key-idle-delay 0.3)
  )

;; enhance the help info, like the ones displayed in describe-function
(use-package helpful
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-command] . helpful-command)
  ([remap describe-key] . helpful-key)
  )

(provide 'help-enhancement)
