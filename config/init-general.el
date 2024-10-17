;; Time
(display-time-mode t)
(setq display-time-24hr-format t)
(setq display-time-day-and-date t)
;; auto save
(setq auto-save-default t)
;; close bell 
(setq visible-bell t)
(setq ring-bell-function 'ignore)
;; close tool bar
(tool-bar-mode 0)
;; highlight current line
(global-hl-line-mode 1)
;; highlight a pair of electric
(electric-pair-mode t)
;; cursor
(setq cursor-type 'bar)

(add-hook 'prog-mode-hook #'show-paren-mode)
;;; Apperence
(use-package spacemacs-theme
  :ensure t
  )
(load-theme 'spacemacs-dark t)
;;;  modeline with Spacemacs style
(use-package spaceline
  :ensure t
  :init (spaceline-spacemacs-theme)
  )
;;; Icon
;;; run M-x all-the-icons-install-fonts manually
(use-package all-the-icons
  :if (display-graphic-p))

;;; Useful Tools
(use-package which-key
  :ensure t
  :hook
  (after-init . which-key-mode)
  :config
  (setq which-key-popup-type 'minibuffer)
  )
(use-package company
  :ensure t
  :pin melpa
  :hook
  (prog-mode . company-mode)
  (text-mode . company-mode)
  )
(use-package ivy
  :ensure t
  :pin melpa
  :hook
  (after-init . ivy-mode)
  )
;; Chinese
;;; About Chinese
(use-package popup :ensure t)
(use-package posframe :ensure t)
(use-package cnfonts
  :ensure t
  :pin melpa
  :hook
  (after-init . cnfonts-mode)
  :config
  (setq cnfonts-use-face-font-rescale t)
  )
(use-package pyim
  :ensure t
  :custom
  (setq default-input-method "pyim")
  :bind
  ("C-\\" . toggle-input-method)
  :config
  (pyim-basedict-enable)
  (setq pyim-cloudim nil)
  (setq pyim-page-length 7)
  (pyim-default-scheme 'ziranma-shuangpin)
  (setq pyim-page-tooltip '(posframe popup minibuffer))
  
  )
(use-package pyim-basedict
  :ensure t)
;; treemacs
(use-package treemacs
  :ensure t
  :defer t
  :init
  (with-eval-after-load 'winum
    (define-key winum-keymap (kbd "M-0") #'treemacs-select-window))
  :config
  (progn
    (setq treemacs-collapse-dirs                   (if treemacs-python-executable 3 0)
          treemacs-deferred-git-apply-delay        0.5
          treemacs-directory-name-transformer      #'identity
          treemacs-display-in-side-window          t
          treemacs-eldoc-display                   'simple
          treemacs-file-event-delay                2000
          treemacs-file-extension-regex            treemacs-last-period-regex-value
          treemacs-file-follow-delay               0.2
          treemacs-file-name-transformer           #'identity
          treemacs-follow-after-init               t
          treemacs-expand-after-init               t
          treemacs-find-workspace-method           'find-for-file-or-pick-first
          treemacs-git-command-pipe                ""
          treemacs-goto-tag-strategy               'refetch-index
          treemacs-header-scroll-indicators        '(nil . "^^^^^^")
          treemacs-hide-dot-git-directory          t
          treemacs-indentation                     2
          treemacs-indentation-string              " "
          treemacs-is-never-other-window           nil
          treemacs-max-git-entries                 5000
          treemacs-missing-project-action          'ask
          treemacs-move-files-by-mouse-dragging    t
          treemacs-move-forward-on-expand          nil
          treemacs-no-png-images                   nil
          treemacs-no-delete-other-windows         t
          treemacs-project-follow-cleanup          nil
          treemacs-persist-file                    (expand-file-name ".cache/treemacs-persist" user-emacs-directory)
          treemacs-position                        'left
          treemacs-read-string-input               'from-child-frame
          treemacs-recenter-distance               0.1
          treemacs-recenter-after-file-follow      nil
          treemacs-recenter-after-tag-follow       nil
          treemacs-recenter-after-project-jump     'always
          treemacs-recenter-after-project-expand   'on-distance
          treemacs-litter-directories              '("/node_modules" "/.venv" "/.cask")
          treemacs-project-follow-into-home        nil
          treemacs-show-cursor                     nil
          treemacs-show-hidden-files               t
          treemacs-silent-filewatch                nil
          treemacs-silent-refresh                  nil
          treemacs-sorting                         'alphabetic-asc
          treemacs-select-when-already-in-treemacs 'move-back
          treemacs-space-between-root-nodes        t
          treemacs-tag-follow-cleanup              t
          treemacs-tag-follow-delay                1.5
          treemacs-text-scale                      nil
          treemacs-user-mode-line-format           nil
          treemacs-user-header-line-format         nil
          treemacs-wide-toggle-width               70
          treemacs-width                           35
          treemacs-width-increment                 1
          treemacs-width-is-initially-locked       t
          treemacs-workspace-switch-cleanup        nil)

    ;; The default width and height of the icons is 22 pixels. If you are
    ;; using a Hi-DPI display, uncomment this to double the icon size.
    ;;(treemacs-resize-icons 44)

    (treemacs-follow-mode t)
    (treemacs-filewatch-mode t)
    (treemacs-fringe-indicator-mode 'always)
    (when treemacs-python-executable
      (treemacs-git-commit-diff-mode t))

    (pcase (cons (not (null (executable-find "git")))
                 (not (null treemacs-python-executable)))
      (`(t . t)
       (treemacs-git-mode 'deferred))
      (`(t . _)
       (treemacs-git-mode 'simple)))

    (treemacs-hide-gitignored-files-mode nil))
  :bind
  (:map global-map
        ("M-0"       . treemacs-select-window)
        ("C-x t 1"   . treemacs-delete-other-windows)
        ("C-x t t"   . treemacs)
        ("C-x t d"   . treemacs-select-directory)
        ("C-x t B"   . treemacs-bookmark)
        ("C-x t C-t" . treemacs-find-file)
        ("C-x t M-t" . treemacs-find-tag)))
(use-package treemacs-projectile
  :after (treemacs projectile)
  :ensure t)

(use-package treemacs-icons-dired
  :hook (dired-mode . treemacs-icons-dired-enable-once)
  :ensure t)
(provide 'init-general)
