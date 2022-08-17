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
;; exwm
;; https://github.com/ch11ng/exwm
(unless (package-installed-p 'exwm)
  (package-install 'exwm))

;; Before exwm-enable
(require 'exwm-randr)
(setq exwm-randr-workspace-output-plist '(1 "HDMI-1"))
(add-hook 'exwm-randr-screen-change-hook
          (lambda ()
            (start-process-shell-command
             "xrandr" nil "xrandr --output HDMI-1 --right-of eDP-1 --auto")))
(exwm-randr-enable)

;; Before exwm-enable
(require 'exwm-systemtray)
(exwm-systemtray-enable)

;; exwm-enable
(require 'exwm)
(require 'exwm-config)
(exwm-config-default)

;; Configure EXWM to send C-c with C-c C-c in XTerm
(add-hook 'exwm-manage-finish-hook
          (lambda ()
            (when (and exwm-class-name
                       (string= exwm-class-name "XTerm"))
              (exwm-input-set-local-simulation-keys '(([?\C-c ?\C-c] . ?\C-c))))))
;; =======================================

;; =======================================
;; Magit
(unless (package-installed-p 'magit)
  (package-install 'magit))
;; =======================================

;; =======================================
;; Ivy
(unless (package-installed-p 'counsel)
  (package-install 'counsel))

;; Enable Ivy completion everywhere
(ivy-mode 1)

;; Basic customisation
(setq ivy-use-virtual-buffers t)
(setq ivy-count-format "(%d/%d) ")
;; =======================================

;; =======================================
;; Slack
(unless (package-installed-p 'slack)
  (package-install 'slack))

(use-package slack
  :commands (slack-start)
  :init
  (setq slack-buffer-emojify t) ;; if you want to enable emoji, default nil
  (setq slack-prefer-current-team t)
  :config
  (slack-register-team
   :name "APNIC"
   :default t
   :token "xoxc-28238289457-316239614309-3686964963175-ea294adb0d96e2f41aa0f1a617cd77358308fcf69b6da8c7433b81a8395d37d1"
   :cookie "xoxd-lv59IgFENWUrm8aL4uADBMWGQjFVxjpkPI56fkcuDtbQaoWm8thncpsd%2BnUv%2BxPhX98NXW61pjpnWDcgD4sRW0fNVnwZt25gbZk4LJS1K7pA0zt6mMqw1G4nSChZwcmFra9Ur%2BoQF083RHxeYRQIPy3wL0q3RjJ2WNBawLUYU6V2eP3DeTciGL0%3D"
   :full-and-display-names t))

(use-package alert
  :commands (alert)
  :init
  (setq alert-default-style 'notifier))
;; =======================================

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
;; Download format-all
;; https://github.com/lassik/emacs-format-all-the-code
(unless (package-installed-p 'format-all)
  (package-install 'format-all))

;; Ensure that a default formatter is selected in case
;; you don't have one set
(add-hook 'format-all-mode-hook 'format-all-ensure-formatter)
;; =======================================

;; =======================================
;; OCaml
;; Format on save
(add-hook 'tuareg-mode-hook 'format-all-mode)
;; =======================================

;; =======================================
;; Arrows movement between different windows
(windmove-default-keybindings)
;; =======================================

;; =======================================
;; Below this line, everything was appended by some tool

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(magit counsel evil))
 '(warning-suppress-types '((comp))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; ## added by OPAM user-setup for emacs / base ## 56ab50dc8996d2bb95e7856a6eddb17b ## you can edit, but keep this line
(require 'opam-user-setup "~/.emacs.d/opam-user-setup.el")
;; ## end of OPAM user-setup addition for emacs / base ## keep this line
