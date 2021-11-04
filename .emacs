(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(fill-column 100)
 '(gud-gdb-command-name "gdb --annotate=1")
 '(large-file-warning-threshold nil)
 '(package-selected-packages
   '(dockerfile-mode yaml-mode transpose-frame auto-complete reason-mode merlin haskell-mode groovy-mode tuareg scala-mode))
 '(safe-local-variable-values '((TeX-master . t))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(comint-highlight-prompt ((t nil)))
 '(diff-added ((t (:inherit diff-changed :background "black" :foreground "color-40"))))
 '(diff-header ((t (:background "brightwhite" :foreground "color-17"))))
 '(diff-hunk-header ((t (:inherit diff-header :foreground "color-17"))))
 '(diff-removed ((t (:inherit diff-changed :background "color-16" :foreground "brightred"))))
 '(tuareg-font-lock-extension-node-face ((t (:inherit tuareg-font-lock-infix-extension-node-face :background "gray92" :foreground "black")))))

;;(set-face-attribute 'region nil :background "#666")
(set-face-attribute 'region nil :background "#666")

(require 'package)
(add-to-list 'package-archives
	          '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)


(setq column-number-mode t)
(setq linum-format "%d ")
(global-linum-mode t)
(setq frame-title-format
      (list (format "%s %%S: %%j " (system-name))
        '(buffer-file-name "%f" (dired-directory dired-directory "%b"))))
(setq backup-directory-alist `(("." . "~/.emacs-backups")))
(setq backup-by-copying t)
(setq delete-old-versions t
      kept-new-versions 6
      kept-old-versions 2
      version-control t)
(setq split-height-threshold 100)
(global-set-key "\C-xp" 'previous-multiframe-window)
(global-set-key "\C-xt" 'transpose-frame)
(add-hook 'prog-mode-hook #'display-fill-column-indicator-mode)

;; ## added by OPAM user-setup for emacs / base ## 56ab50dc8996d2bb95e7856a6eddb17b ## you can edit, but keep this line
(require 'opam-user-setup "~/.emacs.d/opam-user-setup.el")
;; ## end of OPAM user-setup addition for emacs / base ## keep this line

(let ((opam-share (ignore-errors (car (process-lines "opam" "config" "var" "share")))))
      (when (and opam-share (file-directory-p opam-share))
       ;; Register Merlin
       (add-to-list 'load-path (expand-file-name "emacs/site-lisp" opam-share))
       (autoload 'merlin-mode "merlin" nil t nil)
       ;; Automatically start it in OCaml buffers
       (add-hook 'tuareg-mode-hook 'merlin-mode t)
       (add-hook 'caml-mode-hook 'merlin-mode t)
       (require 'merlin-ac)
       ;; Use opam switch to lookup ocamlmerlin binary
       (setq merlin-command 'opam)))

;; custom merlin setup below:
;;  * configure autocompletion, but only open menu on explicit M-tab command
;;  * ignore warnings, errors only.
(ac-config-default)
(setq merlin-ac-setup 'easy)
(global-set-key "\M-\t" 'auto-complete)
(setq merlin-report-warnings t)
