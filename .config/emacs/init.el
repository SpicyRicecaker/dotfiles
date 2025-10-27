;;; ...  -*- lexical-binding: t -*-
;; try to save pinkies
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

;; disable syntax highlighting
(global-font-lock-mode -1)

(setq backup-directory-alist '(("." . "~/.local/share/emacs"))
  backup-by-copying t    ; Don't delink hardlinks
  version-control t      ; Use version numbers on backups
  delete-old-versions t  ; Automatically delete excess backups
  kept-new-versions 6   ; how many of the newest versions to keep
  kept-old-versions 2    ; and how many of the old
  )

;; packages

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

(require 'use-package)

;; (use-package gnuplot
;;   :ensure t)

(use-package vundo
  :ensure t
  :bind
  ("C-c v" . vundo))

(pcase system-type
  ('darwin
   (setq exec-path (cons "/usr/local/bin" exec-path))
   (setq exec-path (cons "/opt/homebrew/bin" exec-path))
   (setenv "PATH" (mapconcat 'identity exec-path ":"))))

;; getting gnuplot to work
(setq explicit-shell-file-name "zsh")
(setq calc-gnuplot-default-device "qt")

(defun s ()
  (interactive)
  (cd "~/git/2025F/cs474/xv6-labs-2025"))

(defun n ()
  (interactive)
  (cd "~/git/notes-obsidian"))

(defun h ()
  (interactive)
  (cd "~/git/tulip2"))

(defun c ()
  (interactive)
  (cd "~/.config/emacs"))

(setq xref-search-program 'ripgrep)

;; store customizations in a separate file
(setq custom-file (locate-user-emacs-file "custom.el"))
(load custom-file 'noerror)
