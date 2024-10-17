(use-package markdown-mode
  :ensure t)
;;; terminal emulator
(use-package vterm :ensure t)
(use-package yasnippet
  :ensure t
  :init (yas-global-mode))
;;; Language Support
(use-package cmake-mode :ensure t)
(use-package meson-mode
  :ensure t
  :hook (meson-mode . company-mode)
  )
(use-package rust-mode :ensure t)
(use-package cargo
  :ensure t
  :hook
  (rust-mode . cargo-minor-mode)
  )
(use-package cargo-mode :ensure t)
(use-package lsp-mode
  :ensure t
  :init
  (setq lsp-keymap-prefix "C-c l")
  :hook
  (lsp-mode . lsp-enable-which-key-integration)
  (c++-mode . lsp-deferred); clangd
  (c-mode . lsp-deferred); clangd
  (cmake-mode . lsp-deferred); cmake-language-server
  (rust-mode . lsp-deferred); rust-analyzer
  (meson-mode . lsp-deferred); MesonLSP
  (LaTeX-mode . lsp-deferred); texlab
  :commands lsp
  )
(use-package lsp-ivy
  :ensure t
  :commands lsp-ivy-workspace-symbol)
;;; Projectile
;;  https://docs.projectile.mx/projectile/index.html
(use-package projectile
  :ensure t
  :init 
  (projectile-mode +1)
  (add-hook 'project-find-functions #'project-projectile)
  :bind-keymap
  ("C-c p" . projectile-command-map); C-c is as the super key in Windows or Linux
  :config
  (setq projectile-project-search-path '("~/projects/" . 1)); rec search these dirs in the list, the last element is the depth of search
  (projectile-register-project-type 'meson '("meson.build")
				    :project-file "meson.build"
				    :compile "meson setup build --buildtype=debugoptimized"; clangd search $SRC/build by default
				    :run "meson complie -C build"
				    :test "meson test -C builddir"
				    )
  (projectile-register-project-type 'cmake '("CMakeLists.txt")
				    :project-file "CMakeLists.txt"
				    :compile "cmake -S . -B build -DCMAKE_EXPORT_COMPILE_COMMANDS=ON"
				    :run "cmake --build build"
				    )
  )
;;; Usage:
;; s-p f          (f: find)                      Find file in the current project
;; s-p p          (p: project)                   Switch Project
;; s-p r          (r: replace)                   Replace
;; s-p s g        (s: search g: grep)            Search for text/regex
;; s-p c          (c: complie)                   build/compile the current project
;; s-p T          (t: Test)                      Test the project
;; s-p u          --------                       run the current project with predefined config
;; s-p t          (t: test)                      Toggle between test and impl
;; s-p a          (a: associate)                 Toggle betwwen related files(like foo.hpp <-> foo.cpp)
;; s-p S          (S: Save)                      Save all the project
;; s-p D          (D: Dired)                     Open current in a dired frame
;; s-p x v        (v: vterm)                     Open a vterm in the path of current project
;; s-p x g        (g: gdb)                       start/viste gdb for current project
;; s-p !(s-p &)   -------                        run shell command at the root of project, !for sync commands, & for async commands

(provide 'init-code)
