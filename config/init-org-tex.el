(require 'use-package)
;;; [LaTeX]
(use-package cdlatex
  :ensure t
  :hook
  (org-mode . turn-on-org-cdlatex)
  (LaTeX-mode . turn-on-cdlatex)
  )
(use-package pdf-tools
  :ensure t
  :init
  (pdf-loader-install)
  )
(defun latexmk-cleanup-all()
  (interactive)
  ;; run latexmk -C
  (let (dir (file-name-directory buffer-file-name))
    (when dir
      (shell-command (concat "latexmk" "-cd" dir " -C")))))
(defun latexmk-cleanup-aux()
  (interactive)
  ;; run latexmk -c at the dir of file opened at current buffer
  (let (dir (file-name-directory buffer-file-name))
    (when dir
      (shell-command (concat "latexmk" "-cd" dir " -c")))))
(use-package auctex
  :ensure t
  :custom
  (TeX-parse-self t)
  :config
  ; AUCTeX find the master file of multi files tex project
  (setq-default TeX-master nil)
  ; The default engine: xelatex
  (setq-default TeX-engine 'xetex)
  ; output pdf instand of dvi
  (setq-default TeX-PDF-mode t)
  ; auto save file
  (setq TeX-auto-save t)
  ; show the compliation
  (setq TeX-show-compilation t)
  ; remove TAB while save
  (setq TeX-auto-untabify t)
 )
  ;;; [LaTeX]
(use-package cdlatex
  :ensure t
  :hook
  (org-mode . turn-on-org-cdlatex)
  (LaTeX-mode . turn-on-cdlatex)
  )
(use-package pdf-tools
  :ensure t
  :init
  (pdf-loader-install)
  )
(defun latexmk-cleanup-all()
  (interactive)
  ;; run latexmk -C
  (let (dir (file-name-directory buffer-file-name))
    (when dir
      (shell-command (concat "latexmk" "-cd" dir " -C")))))
(defun latexmk-cleanup-aux()
  (interactive)
  ;; run latexmk -c at the dir of file opened at current buffer
  (let (dir (file-name-directory buffer-file-name))
    (when dir
      (shell-command (concat "latexmk" "-cd" dir " -c")))))
(setq latex-recipe '())
;; ("name" "command" "args")
(add-to-list 'latex-recipe
	     '("latexmk(xelatex)"
	       "latexmk"
	       "-time"
	       "-xelatex"))
(add-to-list 'latex-recipe
	     '("latexmk(xelatex+bibtex)"
	       "latexmk"
	       "-time"
	       "-file-line-error"
	       "-halt-on-error"
	       "-interaction=nonstopmode"
	       "-synctex=1"
	       "-xelatex"
	       "-bibtex"
	       "-xelatex"
	       "-xelatex"))
(use-package auctex
  :ensure t
  :hook
  (LaTeX-mode . LaTeX-math-mode)
  :custom
  (TeX-parse-self t)
  :config
  ; AUCTeX find the master file of multi files tex project
  (setq-default TeX-master nil)
  ; The default engine: xelatex
  (setq-default TeX-engine 'xetex)
  ; output pdf instand of dvi
  (setq-default TeX-PDF-mode t)
  ; auto save file
  (setq TeX-auto-save t)
  ; show the compliation
  (setq TeX-show-compilation t)
  ; remove TAB while save
  (setq TeX-auto-untabify t)
  ;; use inline latex code \(...\)
  (setq TeX-electric-math (cons "\\(" "\\)"))
  ;; highlights a pair of brace
  (setq LaTeX-electric-left-right-brace t)
  ;; <https://mickey991.gitee.io/elatex/easy-latex-writing-ap01-pdf-tools/>
  ;; search
  )

;;; [orgmode]
;; my-org-emphasis-face
(defface my-org-emphasis-bold
  '((default :inherit bold)
    (((class color) (min-colors 88) (background light))
     :foreground "#a60000")
    (((class color) (min-colors 88) (background dark))
     :foreground "#ff8059"))
  "My bold emphasis for Org.")

(defface my-org-emphasis-italic
  '((default :inherit italic)
    (((class color) (min-colors 88) (background light))
     :foreground "#005e00")
    (((class color) (min-colors 88) (background dark))
     :foreground "#44bc44"))
  "My italic emphasis for Org.")

(defface my-org-emphasis-underline
  '((default :inherit underline)
    (((class color) (min-colors 88) (background light))
     :foreground "#813e00")
    (((class color) (min-colors 88) (background dark))
     :foreground "#d0bc00"))
  "My underline emphasis for Org.")

(defface my-org-emphasis-strike-through
  '((((class color) (min-colors 88) (background light))
     :strike-through "#972500" :foreground "#505050")
    (((class color) (min-colors 88) (background dark))
     :strike-through "#ef8b50" :foreground "#a8a8a8"))
  "My strike-through emphasis for Org.")
;; end
;; This org-mode configuration make org like a LaTeX article.
;; No other typographical needs are considered.
(use-package org
  :ensure t; org-mode is contained in Emacs by default
  :init 
  :hook
  (org-mode . (lambda () (setq truncate-lines nil)))
  ;; heading auto numbering
  (org-mode . org-num-mode)
  ;; To display the buffer in the indented view, activate Org Indent minor mode
  ;(org-mode . org-indent-mode)
  ;(org-mode .  (lambda () (variable-pitch-mode 1) visual-line-mode))
  
  :config
  (setq org-hide-emphasis-markers t
	org-fontify-done-headline t
	;org-hide-leading-stars t ; I like leading stars.
	org-pretty-entities t)
  ;;chapter section, subsection, subsubsection
  (setq org-num-max-level 4)
  ;; set the size of latex preview images 
  (setq org-format-latex-options
	(plist-put org-format-latex-options :scale 0.6))
  ;; use svg to preview latex fragments, instend of png
  ;; svg is clearer than png when images zoom out
  (setq org-preview-latex-default-process 'dvisvgm)

  ;; Latex article Styles
  ;;Recommanded Setting for Latex Style headlings

  ;;; Titles and Sections
  ;; hide #+TITLE:
  ;(setq org-hidden-keywords '(title))
  ;; set basic title font
  (set-face-attribute 'org-level-8 nil :weight 'bold :inherit 'default)
  ;; Low levels are unimportant => no scaling
  (set-face-attribute 'org-level-7 nil :inherit 'org-level-8)
  (set-face-attribute 'org-level-6 nil :inherit 'org-level-8)
  (set-face-attribute 'org-level-5 nil :inherit 'org-level-8)
  (set-face-attribute 'org-level-4 nil :inherit 'org-level-8)
  ;; Top ones get scaled the same as in LaTeX (\large, \Large, \LARGE)
  (set-face-attribute 'org-level-3 nil :inherit 'org-level-8 :height 1.2) ;\large, as subsubsection
  (set-face-attribute 'org-level-2 nil :inherit 'org-level-8 :height 1.44) ;\Large, as subsection
  (set-face-attribute 'org-level-1 nil :inherit 'org-level-8 :height 1.728) ;\LARGE, as section
  ;; Only use the first 4 styles and do not cycle.
  (setq org-cycle-level-faces nil)
  (setq org-n-level-faces 4)
  ;; Document Title, (\huge)
  (set-face-attribute 'org-document-title nil
                      :height 2.074
                      :foreground 'unspecified
                      :inherit 'org-level-8)
  ;; Emphasis Words Style
  (setq org-emphasis-alist
      '(("*" my-org-emphasis-bold)
        ("/" my-org-emphasis-italic)
        ("_" my-org-emphasis-underline)
        ("=" org-verbatim verbatim)
        ("~" org-code verbatim)
        ("+" my-org-emphasis-strike-through)))
  ;; src tab
  (setq org-src-tab-acts-natively t)
  ;; sub/superscripts
  (setq-default org-use-sub-superscripts "{}")
  ;; Line spacing
  ;; Increase line spacing
  (setq line-spacing 2)
  )
;;; org-babel support languages
(org-babel-do-load-languages
 'org-babel-load-languages
 '((python . t)
   (C . t); capital "C", which give access to C,C++,D
   (gnuplot .t)
   )
 )
(provide 'init-org-tex)
