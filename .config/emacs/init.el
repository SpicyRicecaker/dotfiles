;;; ...  -*- lexical-binding: t -*-
;; try to save pinkys
(global-set-key (kbd "C-,") ctl-x-map)
(global-set-key (kbd "M-,") 'execute-extended-command)

;; indent
(setq-default tab-width 2)         ; Set tab width to 4 spaces
(setq-default indent-tabs-mode nil)
(setq-default js-indent-level 2)

(setq blink-cursor-mode 'nil)
;; turn off the os menu bar
(menu-bar-mode -1)
;; get rid of the gtk toolbar
(tool-bar-mode -1)
(setq ring-bell-function (lambda () ()))
;; delete on paste selection
(delete-selection-mode 1)
;; disable scroll bars because it likes to pop for word-wrapped line in macos
(scroll-bar-mode -1)
;; focus
(select-frame-set-input-focus (selected-frame))

;; never have gc
(setq gc-cons-threshold most-positive-fixnum)
;; Later, after startup is complete:
(setq gc-cons-threshold 50000000)

(setq backup-directory-alist '(("." . "~/.local/share/emacs"))
  backup-by-copying t    ; Don't delink hardlinks
  version-control t      ; Use version numbers on backups
  delete-old-versions t  ; Automatically delete excess backups
  kept-new-versions 6   ; how many of the newest versions to keep
  kept-old-versions 2    ; and how many of the old
  )

;; Optional: To truly get "boring white text," disable syntax highlighting
;; This will make all text (code, comments, strings) the default white color.
;; Remove or comment out this line if you want to keep syntax highlighting.
(global-font-lock-mode -1)

;; Store customizations in a separate file
(setq custom-file (locate-user-emacs-file "custom.el"))
(load custom-file 'noerror)
