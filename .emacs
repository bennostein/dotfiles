(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(fill-column 80)
 '(gud-gdb-command-name "gdb --annotate=1")
 '(highlight-indent-guides-auto-enabled nil)
 '(highlight-indent-guides-delay 0.02)
 '(highlight-indent-guides-method 'character)
 '(highlight-indent-guides-responsive 'top)
 '(indent-guide-recursive t)
 '(large-file-warning-threshold nil)
 '(package-selected-packages
   '(auto-complete deadgrep dockerfile-mode go-mode groovy-mode haskell-mode
		   highlight-indent-guides indent-guide magit markdown-mode
		   merlin merlin-company reason-mode reformatter scala-mode
		   terraform-mode tide transient transpose-frame tuareg
		   typescript-mode vertico which-key yaml-mode))
 '(safe-local-variable-values '((TeX-master . t)))
 '(skip-format-in-docker "sk-dev")
 '(typescript-indent-level 2))
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
 '(font-lock-keyword-face ((t (:foreground "mediumturquoise"))))
 '(highlight-indent-guides-character-face ((t (:foreground "gray24"))))
 '(highlight-indent-guides-top-character-face ((t (:foreground "cadetblue"))))
 '(markdown-code-face ((t (:inherit fixed-pitch :foreground "mediumturquoise"))))
 '(markdown-language-keyword-face ((t (:foreground "cadetblue"))))
 '(tuareg-font-lock-extension-node-face ((t (:inherit tuareg-font-lock-infix-extension-node-face :background "gray92" :foreground "black"))))
 '(typescript-jsdoc-value ((t (:foreground "lightsalmon")))))

;;(set-face-attribute 'region nil :background "#666")
(set-face-attribute 'region nil :background "#666")

(require 'package)
(require 'use-package)
(add-to-list 'package-archives
	          '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)


(use-package vertico
  :init
  (vertico-mode)
  ;; Different scroll margin
  ;; (setq vertico-scroll-margin 0)

  ;; Show more candidates
  (setq vertico-count 10)

  ;; Grow and shrink the Vertico minibuffer
  ;; (setq vertico-resize t)

  ;; Optionally enable cycling for `vertico-next' and `vertico-previous'.
  (setq vertico-cycle t)
  )

(use-package savehist :init (savehist-mode))

(setq column-number-mode t)
(setq menu-bar-mode nil)
(global-display-line-numbers-mode)
(setq-default display-line-numbers-width 4)
(setq which-key-idle-delay 2)
(setq which-key-idle-secondary-delay 0.05)
(which-key-mode)
(which-key-setup-side-window-right-bottom)
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

(set-display-table-slot standard-display-table 'vertical-border (make-glyph-code ?│))

;;(add-hook 'prog-mode-hook #'display-fill-column-indicator-mode)

;;(let ((opam-share (ignore-errors (car (process-lines "opam" "config" "var" "share")))))
;;      (when (and opam-share (file-directory-p opam-share))
;;       ;; Register Merlin
;;       (add-to-list 'load-path (expand-file-name "emacs/site-lisp" opam-share))
;;       (autoload 'merlin-mode "merlin" nil t nil)
;;       ;; Automatically start it in OCaml buffers
;;       (add-hook 'tuareg-mode-hook 'merlin-mode t)
;;       (add-hook 'caml-mode-hook 'merlin-mode t)
;;       ;; Use opam switch to lookup ocamlmerlin binary
;;       (setq merlin-command 'opam)
;;       (setq merlin-report-warnings t)))

;;(global-set-key "\M-\t" 'company-complete)
;;(setq company-idle-delay (lambda () (if (company-in-string-or-comment) nil 0.5)))

;; Force emacsclient to open multiple files when given as arguments
;; Sourced from: [https://emacs.stackexchange.com/a/5816]
(defvar server-visit-files-custom-find:buffer-count)
(defadvice server-visit-files
  (around server-visit-files-custom-find
      activate compile)
  "Maintain a counter of visited files from a single client call."
  (let ((server-visit-files-custom-find:buffer-count 0))
    ad-do-it))
(defun server-visit-hook-custom-find ()
  "Arrange to visit the files from a client call in separate windows."
  (if (zerop server-visit-files-custom-find:buffer-count)
      (progn
    (delete-other-windows)
    (switch-to-buffer (current-buffer)))
    (let ((buffer (current-buffer))
      (window (split-window-sensibly)))
      (switch-to-buffer buffer)
      (balance-windows)))
  (setq server-visit-files-custom-find:buffer-count
    (1+ server-visit-files-custom-find:buffer-count)))
(add-hook 'server-visit-hook 'server-visit-hook-custom-find)

(add-hook 'prog-mode-hook 'highlight-indent-guides-mode)

;; Suprress warning when opening a version-controlled file via symlink
(setq vc-follow-symlinks t)

;; Skip-specific stuff
(require 'skip "~/code/skip/ide/emacs/skip.el")
(add-to-list 'auto-mode-alist '("\\.sk$" . skip-mode))
(require 'skip-formatter "~/code/skip/ide/emacs/skip-formatter.el")
(add-hook 'skip-mode-hook 'skip-format-on-save-mode)
(add-hook 'skip-mode-hook (lambda () (electric-indent-mode -1)))
(require 'skip-flycheck "~/code/skip/ide/emacs/skip-flycheck.el")
(eval-after-load 'flycheck '(skip-flycheck-setup))

(defun skip-workdir ()
  (string-remove-prefix "~/code" (locate-dominating-file buffer-file-name "Skargo.toml")))

(add-hook 'skip-mode-hook
      #'(lambda ()
              (setq compile-command
                    '(concat "docker exec -it -w " (skip-workdir) " " skip-format-in-docker  " skargo check"))))

(add-hook 'compilation-finish-functions 'change-container-to-local)
(defun change-container-to-local (buffer &optional stat)
  "change paths from container to local"
  (interactive "b")
  (save-excursion
    (set-buffer buffer)
    (goto-char (point-min))
    (let ((buffer-read-only nil))
      (while (re-search-forward "File \\\"/skip/" nil t)
        (replace-match "File \"~/code/skip/")))))

(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  (company-mode +1))
(add-hook 'typescript-mode-hook #'setup-tide-mode)

(add-hook 'text-mode-hook #'auto-fill-mode)
(add-hook 'markdown-mode-hook #'auto-fill-mode)

(global-set-key (kbd "C-x s") #'deadgrep)
(global-set-key (kbd "C-x *") #'name-last-kbd-macro)
(put 'upcase-region 'disabled nil)
