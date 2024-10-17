(add-to-list 'load-path "~/.emacs.d/config/")
;;; [ELPA]
(eval-when-compile (require 'package))
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(unless package-archive-contents (package-refresh-contents))

;;; must have use-package
(require 'use-package)
(require 'init-general)
(require 'init-code)
(require 'init-org-tex)


;;; [Lisp]
(load (expand-file-name "~/.quicklisp/slime-helper.el"))
(setq inferior-lisp-program "sbcl")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(pyim-basedict pyim treemacs-icons-dired treemacs-projectile treemacs pdf-tools json-mode yaml-mode lsp-ivy lsp-mode meson-mode cargo-mode cargo eglot auctex all-the-icons projectile vterm cdlatex rust-mode cmake-mode yasnippet markdown-mode spaceline which-key spacemacs-theme cnfonts use-package)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
