(require 'package)

(add-to-list 'exec-path (expand-file-name "~/.cargo/bin"))

(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)
(pixel-scroll-precision-mode 1)

(setq split-height-threshold nil)
(setq split-width-threshold most-positive-fixnum)

(use-package company
  :ensure t
  :config
  (add-hook 'after-init-hook 'global-company-mode))

(setq company-tooltip-minimum-width 0)
(setq completion-show-inline 1)
(setq company-selection-wrap-around t)

(setq company-idle-delay nil)
(setq completion-auto-help -1)
(setq ac-auto-show-menu nil)

(global-set-key (kbd "TAB") 'tab-to-tab-stop)
(global-set-key (kbd "M-<tab>") 'company-complete-selection)
(global-set-key (kbd "M-[") 'company-select-previous)
(global-set-key (kbd "M-]") 'company-select-next)
(global-set-key (kbd "C-c C-m") 'duplicate-line)

(global-set-key (kbd "M-2") 'other-window)
(global-set-key (kbd "M-q") 'find-file)
(global-set-key (kbd "M-`") 'ivy-switch-buffer)
(global-set-key (kbd "M-s") 'shell-command)
(global-set-key (kbd "M-e") 'grep-find)
(global-set-key (kbd "M-r") 'recompile)
(global-set-key (kbd "M-i") 'mark-sexp)
(global-set-key (kbd "M-a") 'async-shell-command)

(global-set-key (kbd "C-c C-k") 'kill-whole-line)
(global-set-key (kbd "C-c C-<backspace>") 'kill-whole-line)

(global-display-line-numbers-mode -1)

(defun set-rectangle-cursor ()
  (setq cursor-type 'box))

(set-default 'cursor-type 'box)

(define-key global-map (kbd "M-h") #'windmove-left)
(define-key global-map (kbd "M-l") #'windmove-right)
(define-key global-map (kbd "C-?") #'comment-or-uncomment-region)

(use-package surround :ensure t)

(use-package move-text :ensure t)
(global-set-key (kbd "M-n") 'move-text-down)
(global-set-key (kbd "M-p") 'move-text-up)

(use-package windswap :ensure t)
(global-set-key (kbd "C-S-b") 'windswap-left)
(global-set-key (kbd "C-S-n") 'windswap-down)
(global-set-key (kbd "C-S-p") 'windswap-up)
(global-set-key (kbd "C-S-f") 'windswap-right)

(global-set-key (kbd "M-1")   'previous-buffer)
(global-set-key (kbd "M-3")   'next-buffer)

(global-set-key (kbd "C-0") 'shrink-window-horizontally)
(global-set-key (kbd "C--") 'enlarge-window-horizontally)
(global-set-key (kbd "C-=") 'enlarge-window)

(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)

(add-to-list 'load-path "~/.emacs.local/")

(load "~/.emacs.rc/rc.el")
(load "~/.emacs.local/rush-mode.el")

(defun rc/get-default-font ()
  (cond
   ((eq system-type 'windows-nt) "Consolas-13")
   ;; ((eq system-type 'gnu/linux) "Iosevka-20")))
   ;; ((eq system-type 'gnu/linux) "Fira Code-15")))
   ((eq system-type 'gnu/linux) "Consolas-14")))

(add-to-list 'default-frame-alist `(font . ,(rc/get-default-font)))

;; (rc/require-theme 'gruber-darker)

;; (use-package-theme 'zenburn :ensure t)
;; (custom-set-faces
;;  '(font-lock-constant-face ((t (:foreground "#96A6C8"))))
;;  '(font-lock-function-name-face ((t (:foreground "#94BFF3"))))
;;  '(font-lock-keyword-face ((t (:foreground "#F0DFAF" :weight bold))))
;;  '(font-lock-reference-face ((t (:foreground (\, "#DCDCCC")))))
;;  '(font-lock-type-face ((t (:foreground "#F0DFAF" :weight bold))))
;;  '(font-lock-variable-name-face ((t (:foreground "#DCDCCC")))))
;; (defun rust-unsafe ()
;;   (font-lock-add-keywords nil
;;     '(("\\<\\(unsafe\\)\\>"
;;        1 '(:foreground "ff4f58") t))))
;; (add-hook 'rust-mode-hook 'rust-unsafe)

(tool-bar-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode 0)
(column-number-mode 1)
(show-paren-mode 1)
(delete-selection-mode 1)

(setq redisplay-dont-pause t
  scroll-margin 1
  scroll-step 1
  scroll-conservatively 10000
  scroll-preserve-screen-position 1)

;; (use-package gruber-darker-theme :ensure t)
(use-package naysayer-theme :ensure t)
(load-theme 'naysayer t)

;; (custom-set-faces
;;   '(font-lock-variable-face ((t (:foreground "#FFFFFF" :weight bold))))
;;   '(font-lock-variable-name-face ((t (:foreground "#FFFFFF"))))
;;   '(font-lock-constant-face ((t (:foreground "#95a99f"))))
;;   '(font-lock-keyword-face ((t (:foreground "#FFDD33" :weight bold))
;;   '(font-lock-type-face ((t (:foreground "#95a99f")))))
;; ))

(setq whitespace-display-mappings
      '((space-mark 32 [183] [46])
        (newline-mark 0)
        (end-of-line 0)
        (tab-mark 0)))

(custom-set-faces
 '(whitespace-space ((t (:foreground "gray30" :background nil)))))

(setq whitespace-style '(face tabs spaces trailing space-before-tab indentation empty space-after-tab space-mark tab-mark))
(use-package smex :ensure t)

(ido-mode 1)
(ido-everywhere 1)

(global-set-key (kbd "M-x") 'smex)

(add-hook 'c++-mode-hook (lambda ()
                       (interactive)
                       (c-set-style "linux")
                       (setq-default indent-tabs-mode nil)
                       ;; (setq indent-tabs-mode t)
                       (setq c-basic-offset 2)
                       (setq tab-width 2)
                       (c-toggle-comment-style -1)))

(add-hook 'js-mode-hook (lambda ()
                       (interactive)
                       (setq-default indent-tabs-mode nil)
                       (setq tab-width 2)
                       (setq js-indent-level 2)))

(add-hook 'c-mode-hook (lambda ()
                       (interactive)
                       (c-set-style "linux")
                       (setq c-basic-offset 2)
                       (setq tab-width 2)
                       (c-toggle-comment-style -1)))

(require 'fasm-mode)
(add-to-list 'auto-mode-alist '("\\.asm\\'" . masm-mode))

(require 'zig-mode)
(add-to-list 'auto-mode-alist '("\\.zig\\'" . zig-mode))
(add-to-list 'auto-mode-alist '("\\.zon\\'" . zig-mode))

(use-package magit :ensure t)

(setq magit-auto-revert-mode nil)

(global-set-key (kbd "C-c m s") 'magit-status)
(global-set-key (kbd "C-c m l") 'magit-log)

(use-package multiple-cursors :ensure t)

(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->")         'mc/mark-next-like-this)
(global-set-key (kbd "C-<")         'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<")     'mc/mark-all-like-this)
(global-set-key (kbd "C-\"")        'mc/skip-to-next-like-this)
(global-set-key (kbd "C-:")         'mc/skip-to-previous-like-this)

(require 'dired-x)
(setq dired-omit-files (concat dired-omit-files "\\|^\\..+$"))
(setq-default dired-dwim-target t)
(setq dired-listing-switches "-alh")

(use-package yasnippet :ensure t)
(require 'yasnippet)
(setq yas/triggers-in-field nil)
(setq yas-snippet-dirs '("~/.emacs.snippets/"))

;; (yas-global-mode 1)
(setq mouse-wheel-mode nil)

(defun rc/enable-word-wrap ()
  (interactive)
  (toggle-word-wrap 1))

(add-hook 'markdown-mode-hook 'rc/enable-word-wrap)

(global-company-mode 1)
(global-eldoc-mode -1)

(add-to-list 'auto-mode-alist '("\\.js\\'" . js-mode))
(add-to-list 'auto-mode-alist '("\\.c\\'" . c-mode))
(add-to-list 'auto-mode-alist '("\\.h\\'" . c-mode))
(add-to-list 'auto-mode-alist '("\\.cpp\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.hpp\\'" . c++-mode))

;; (electric-pair-mode 1)
;; (setq electric-pair-pairs '(
;;                             (?\" . ?\")
;;                             (?\{ . ?\})
;;                             (?\( . ?\))
;;                             ))

(require 'ansi-color)
(defun colorize-compilation-buffer ()
  (ansi-color-apply-on-region compilation-filter-start (point-max)))
(add-hook 'compilation-filter-hook 'colorize-compilation-buffer)

(add-to-list 'auto-mode-alist '("\\.c\\'" . c-mode))
(add-to-list 'auto-mode-alist '("\\.h\\'" . c-mode))

(setq-default c-basic-offset 2)

(load "~/.emacs.shadow/shadow-rc.el" t)

(add-to-list 'custom-theme-load-path "~/.emacs.local")

(use-package ivy
  :ensure t
  :config
  (ivy-mode +1))

(require 'compile)

(defun update-rust-tags ()
  (when (eq major-mode 'rust-mode)
    (let ((default-directory (locate-dominating-file buffer-file-name "Cargo.toml")))
      (when default-directory
        (start-process "ctags" nil "ctags" "-e" "-R" "--languages=Rust" "--langmap=Rust:.rs")))))

(add-hook 'after-save-hook 'update-rust-tags)

(defun my-xref-find-tag-files ()
  "Find the TAGS file in the Rust project root."
  (let ((root (locate-dominating-file buffer-file-name "Cargo.toml")))
    (when root
      (list (expand-file-name "TAGS" root)))))

(setq xref-etags-file-name 'my-xref-find-tag-files)
(setq xref-search-program 'etags)

(defun my-auto-load-tags ()
  (let ((root (locate-dominating-file buffer-file-name "Cargo.toml")))
    (when root
      (visit-tags-table (expand-file-name "TAGS" root) t))))

(add-hook 'rust-mode-hook #'my-auto-load-tags)
(setq tags-revert-without-query t)

;; (use-package dumb-jump
;;   :bind (("M-." . dumb-jump-go)
;;          ("M-g b" . dumb-jump-back)
;;          ("M-g q" . dumb-jump-quick-look))
;;   :config (setq dumb-jump-prefer-searcher 'rg))

(add-to-list 'compilation-error-regexp-alist
             '("\\([a-zA-Z0-9\\.]+\\)(\\([0-9]+\\)\\(,\\([0-9]+\\)\\)?) \\(Warning:\\)?"
               1 2 (4) (5)))

(require 'ansi-color)
(add-hook 'compilation-filter-hook 'ansi-color-compilation-filter)

(use-package bind-key)
(bind-key* "M-q" 'find-file)

(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
