;;; package --- My init file

;;; Commentary:

;;; Code:

(setq inhibit-startup-screen t)
(tool-bar-mode -1) ;; Hide gui toolbar

;; Use ibuffer
(global-set-key [remap list-buffers] 'ibuffer)

;; =======================================
;; Set up package.el to work with MELPA
(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/"))
(package-initialize)
;; =======================================

;; =======================================
;; Download use-package
;; https://github.com/jwiegley/use-package
(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(require 'use-package)
;; =======================================

(use-package sml-mode
  :ensure t)

;; =======================================
;; F-star
(use-package fstar-mode
  :ensure t)
;; =======================================

;; =======================================
;; Project management
(use-package ripgrep
  :ensure t)

(use-package projectile
  :ensure t
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :init
  (projectile-mode 1)
  (setq projectile-project-search-path '(("~/devel" . 1))))
;; =======================================

;; =======================================
;; Enable flycheck globally
(use-package flycheck
  :ensure t ; Install
  :init
  (global-flycheck-mode))
;; =======================================

;; =======================================
;; Company
(use-package company
  :ensure t)
;; =======================================

;; =======================================
;; Enable the language server protocol mode
(use-package lsp-mode
  :ensure t ; Install
  :commands lsp
  :hook
  (tuareg-mode . lsp) ; LSP with OCaml
  (c-mode . lsp)
  )

;; =======================================

;; =======================================
;; Show messages on the right-side margin
(use-package lsp-ui
  :ensure t ; Install
  :hook (tuareg-mode . lsp-ui-sideline-mode))
;; =======================================

;; =======================================
;; Lua
(use-package lua-mode
  :ensure t)
;; =======================================

;; =======================================
;; Git
;; https://ianyepan.github.io/posts/emacs-git-gutter/
(use-package git-gutter
  :hook (prog-mode . git-gutter-mode)
  :config
  (setq git-gutter:update-interval 0.02)
  :ensure t)

(use-package git-gutter-fringe
  :config
  (define-fringe-bitmap 'git-gutter-fr:added [224] nil nil '(center repeated))
  (define-fringe-bitmap 'git-gutter-fr:modified [224] nil nil '(center repeated))
  (define-fringe-bitmap 'git-gutter-fr:deleted [128 192 224 240] nil nil 'bottom)
  :ensure t)
;; =======================================

;; =======================================
;; OCaml
;; Format before save
(use-package ocamlformat
  :ensure t ; Install
  :hook (before-save . ocamlformat-before-save))

;; Error reporting
(use-package flycheck-ocaml
  :ensure t
  :config
  (add-hook 'tuareg-mode-hook
            (lambda ()
              ;; disable Merlin's own error checking
              (setq-local merlin-error-after-save nil)
              ;; enable Flycheck checker
              (flycheck-ocaml-setup))))

;; ## added by OPAM user-setup for emacs / base ## 56ab50dc8996d2bb95e7856a6eddb17b ## you can edit, but keep this line
(require 'opam-user-setup "~/.emacs.d/opam-user-setup.el")
;; ## end of OPAM user-setup addition for emacs / base ## keep this line
;; =======================================

;; =======================================
;; Vertico
;; https://github.com/minad/vertico
;; Enable vertico
(use-package vertico
  :init
  (vertico-mode))

;; Configure directory extension.
(use-package vertico-directory
  :after vertico
  :ensure nil
  ;; More convenient directory navigation commands
  :bind (:map vertico-map
              ("RET" . vertico-directory-enter)
              ("DEL" . vertico-directory-delete-char)
              ("M-DEL" . vertico-directory-delete-word))
  ;; Tidy shadowed file names
  :hook (rfn-eshadow-update-overlay . vertico-directory-tidy))
;; =======================================

;; =======================================
;; Magit
(use-package magit
  :ensure t)
;; =======================================

(use-package marginalia
  :ensure t
  :init
  (marginalia-mode))

(use-package consult
  :ensure t
  :hook (completion-list-mode . consult-preview-at-point-mode))

(use-package consult-dir
  :ensure t
  :bind (([remap list-directory] . consult-dir)
         :map vertico-map
         ("C-x C-d" . consult-dir)
         ("C-x C-j" . consult-dir-jump-file)))

(use-package orderless
  :ensure t
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles basic partial-completion)))))

;; =======================================
;; Ivy
(use-package counsel
  :ensure t
  :init
  (setq ivy-use-virtual-buffers t)
  (setq ivy-count-format "(%d/%d) ")
  (ivy-mode 1))

;; Sorting and filtering.
;; This will sort M-x by last used.
(use-package ivy-prescient
  :ensure t
  :init
  (ivy-prescient-mode 1))
;; =======================================

;; =======================================
;; Evil
;; (use-package evil
;;   :ensure t
;;   :config
;;   (evil-mode 1))
;; =======================================

;; =======================================
;; Download Doom Themes
;; https://github.com/doomemacs/themes
(use-package doom-themes
  :ensure t
  :config
  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled
  (load-theme 'doom-one t)

  ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config)
  ;; Enable custom neotree theme (all-the-icons must be installed!)
  (doom-themes-neotree-config)
  ;; or for treemacs users
  (setq doom-themes-treemacs-theme "doom-colors")
  (doom-themes-treemacs-config)
  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))
;; =======================================

;; =======================================
;; Download format-all
;; https://github.com/lassik/emacs-format-all-the-code
(use-package format-all
  :ensure t
  ;; Ensure that a default formatter is always selected
  :hook (format-all-mode . format-all-ensure-formatter))
;; =======================================

;; =======================================
;; Arrows movement between different windows
(windmove-default-keybindings)
;; =======================================

;; =======================================
;; Always display line numbers
(global-display-line-numbers-mode)
;; =======================================

;; Put all backup files here
(setq backup-directory-alist '(("" . "~/.emacs.d/backup")))

(global-set-key (kbd "C-c q") 'auto-fill-mode)
(setq-default fill-column 80)
(add-hook 'prog-mode-hook #'display-fill-column-indicator-mode)

;; Remove them
(add-hook 'before-save-hook
          'delete-trailing-whitespace)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(ivy-prescient fstar-mode tidy git-gutter-fringe git-gutter ripgrep ocamlformat lsp-ui lsp-mode consult-dir orderless consult marginalia vertico magit counsel evil))
 '(warning-suppress-types '((comp))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
