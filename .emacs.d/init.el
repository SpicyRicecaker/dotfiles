;; Set up custom.el file
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (and custom-file
           (file-exists-p custom-file))
  (load custom-file nil :nomessage))

(load "~/git/crafted-emacs/modules/crafted-init-config")

(defun crafted-emacs-load-modules (modules)
  "Initialize crafted-emacs modules.

MODULES is a list of module names without the -packages or
-config suffixes.  Note that any user-provided packages should be
added to `package-selected-packages' before invoking this
function."
  (dolist (m modules)
    (require (intern (format "crafted-%s-packages" m)) nil :noerror))
  (package-install-selected-packages :noconfirm)
  (dolist (m modules)
    (require (intern (format "crafted-%s-config" m)) nil :noerror)))

(customize-set-variable 'package-selected-packages '(ef-themes evil))
(crafted-emacs-load-modules '(defaults completion ui ide))

(add-hook 'after-init-hook
          (lambda ()
            (setq frame-inhibit-implied-resize t)
            (load-theme 'ef-dream t)
            (make-frame-visible)))

(evil-mode)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(load-prefer-newer t t)
 '(mouse-wheel-progressive-speed nil)
 '(package-archive-priorities
   '(("gnu" . 99) ("nongnu" . 80) ("stable" . 70) ("melpa" . 0)))
 '(package-selected-packages nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
