(setq inhibit-startup-screen t)
(tool-bar-mode -1) ;; Hide toolbar

;; =======================================
;; Set up package.el to work with MELPA
(require 'package)
(add-to-list 'package-archives 
  '("melpa" . "https://melpa.org/packages/"))
(package-initialize)
(package-refresh-contents)
;; =======================================

;; =======================================
;; Download use-package
;; https://github.com/jwiegley/use-package
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
;; =======================================

;; =======================================
;; Download Evil
(unless (package-installed-p 'evil)
  (package-install 'evil))

;; Enable Evil
(use-package evil
  :ensure t
  :config
  (evil-mode 1))
;; =======================================

;; =======================================
;; Download Doom Themes
;; https://github.com/doomemacs/themes
(unless (package-installed-p 'doom-themes)
  (package-install 'doom-themes))

;; Configure theme
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
;; Arrows movement between different windows
(windmove-default-keybindings)
;; =======================================

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(evil)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
