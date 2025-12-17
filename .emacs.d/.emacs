;; Package setup
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://raw.githubusercontent.com/d12frosted/elpa-mirror/master/melpa/") t)
(package-initialize)

;; Performance
(setq gc-cons-threshold (* 100 1024 1024))
(setq read-process-output-max (* 1024 1024))

;; Exec paths
(add-to-list 'exec-path (expand-file-name "~/.cargo/bin"))
(add-to-list 'exec-path (expand-file-name "/home/marktyrkba/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/bin/"))

;; UI - minimal
(tool-bar-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode 0)
(column-number-mode 1)
(show-paren-mode 1)
(delete-selection-mode 1)
(global-display-line-numbers-mode -1)
(pixel-scroll-precision-mode 1)
(set-default 'cursor-type 'box)

;; Scrolling
(setq redisplay-dont-pause t
      scroll-margin 1
      scroll-step 1
      scroll-conservatively 10000
      scroll-preserve-screen-position 1)

;; Window splitting - horizontal by default
(setq split-height-threshold nil
      split-width-threshold most-positive-fixnum)

;; Indentation
(setq-default tab-width 4
              indent-tabs-mode nil
              c-basic-offset 2)

;; Font
(defun rc/get-default-font ()
  (cond
   ((eq system-type 'windows-nt) "Consolas-13")
   ((eq system-type 'gnu/linux) "Liberation Mono-13")))
(add-to-list 'default-frame-alist `(font . ,(rc/get-default-font)))

;; Theme
(add-to-list 'custom-theme-load-path "~/.emacs.local")
(load-theme 'handmade t)

;; Whitespace
(setq whitespace-display-mappings
      '((space-mark 32 [183] [46])
        (newline-mark 0)
        (end-of-line 0)
        (tab-mark 0)))
(setq whitespace-style '(face tabs spaces trailing space-before-tab indentation empty space-after-tab space-mark tab-mark))
(custom-set-faces
 '(whitespace-space ((t (:foreground "gray30" :background nil)))))

;; Better defaults
(global-auto-revert-mode 1)
(defalias 'yes-or-no-p 'y-or-n-p)
(setq mouse-wheel-mode nil)
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

;; Company - completion
(use-package company
  :ensure t
  :config
  (setq company-minimum-prefix-length 2
        company-idle-delay nil
        company-backends '(company-capf)
        company-tooltip-minimum-width 0
        company-selection-wrap-around t
        completion-show-inline 1
        completion-auto-help -1
        ac-auto-show-menu nil)
  (global-company-mode 1))

;; IDO
(use-package smex :ensure t)
(ido-mode 1)
(ido-everywhere 1)
(setq ido-enable-flex-matching t
      ido-create-new-buffer 'always)

;; Ivy
(use-package ivy
  :ensure t
  :config
  (ivy-mode +1))

;; Swiper
(use-package swiper
  :ensure t
  :bind (("C-s" . swiper)))

;; Move text
(use-package move-text :ensure t)

;; Window swap
(use-package windswap :ensure t)

;; Magit
(use-package magit
  :ensure t
  :config
  (setq magit-auto-revert-mode nil))

;; Multiple cursors
(use-package multiple-cursors :ensure t)

;; Yasnippet
(use-package yasnippet
  :ensure t
  :config
  (setq yas/triggers-in-field nil
        yas-snippet-dirs '("~/.emacs.snippets/"))
  (yas-global-mode 1))

;; LSP
(defvar my-lsp-breadcrumb-enable nil
  "Enable/disable LSP breadcrumb showing current context (struct -> impl -> function).")

(defun toggle-lsp-breadcrumb ()
  "Toggle LSP breadcrumb on/off."
  (interactive)
  (setq my-lsp-breadcrumb-enable (not my-lsp-breadcrumb-enable))
  (setq lsp-headerline-breadcrumb-enable my-lsp-breadcrumb-enable)
  (if my-lsp-breadcrumb-enable
      (lsp-headerline-breadcrumb-mode 1)
    (lsp-headerline-breadcrumb-mode -1))
  (message "LSP breadcrumb %s" (if my-lsp-breadcrumb-enable "enabled" "disabled")))

(use-package lsp-mode
  :ensure t
  :commands lsp
  :hook ((rust-mode . lsp)
         (c-mode . lsp)
         (c++-mode . lsp)
         (zig-mode . lsp))
  :config
  (setq lsp-clients-typescript-server "typescript-language-server"
        lsp-idle-delay 0.5
        lsp-log-io nil
        lsp-enable-file-watchers nil
        lsp-enable-folding nil
        lsp-enable-text-document-color nil
        lsp-enable-on-type-formatting nil
        lsp-rust-analyzer-cargo-watch-command "clippy"
        lsp-rust-analyzer-server-display-inlay-hints nil
        lsp-rust-analyzer-display-chaining-hints nil
        lsp-rust-analyzer-display-parameter-hints nil
        lsp-completion-enable t
        lsp-eldoc-render-all nil
        lsp-eldoc-enable-hover nil
        lsp-enable-symbol-highlighting nil
        lsp-signature-render-documentation nil
        lsp-lens-enable nil
        lsp-modeline-code-actions-enable nil
        lsp-diagnostics-provider :none
        lsp-modeline-diagnostics-enable nil
        lsp-headerline-breadcrumb-enable my-lsp-breadcrumb-enable
        lsp-signature-auto-activate nil))

(use-package lsp-ui
  :ensure t
  :after lsp-mode
  :config
  (setq lsp-ui-doc-enable nil
        lsp-ui-doc-show-with-cursor nil
        lsp-ui-sideline-enable nil
        lsp-ui-sideline-show-hover nil
        lsp-ui-sideline-show-code-actions nil
        lsp-ui-imenu-enable nil
        lsp-ui-flycheck-enable nil
        lsp-ui-peek-enable nil
        lsp-ui-scratch-enable nil))

(global-eldoc-mode -1)

;; Compilation - ANSI color support (fixed for Emacs 30+)
(require 'ansi-color)
(require 'compile)

(defun my-compilation-filter ()
  "Handle ANSI colors in compilation buffer."
  (ansi-color-apply-on-region compilation-filter-start (point-max)))

(add-hook 'compilation-filter-hook 'my-compilation-filter)
(setq compilation-scroll-output 'first-error)

;; Compilation buffer colors - match theme better
(custom-set-faces
 '(compilation-info ((t (:foreground "#7CB8BB" :weight normal))))
 '(compilation-warning ((t (:foreground "#DFAF8F" :weight normal))))
 '(compilation-error ((t (:foreground "#CC9393" :weight normal))))
 '(compilation-line-number ((t (:foreground "#8CD0D3"))))
 '(compilation-column-number ((t (:foreground "#8CD0D3"))))
 '(compilation-mode-line-fail ((t (:foreground "#CC9393"))))
 '(compilation-mode-line-exit ((t (:foreground "#7F9F7F")))))

;; Mode line - cleaner colors
(custom-set-faces
 '(mode-line ((t (:background "#2B2B2B" :foreground "#8FB28F" :box nil))))
 '(mode-line-inactive ((t (:background "#1A1A1A" :foreground "#5F7F5F" :box nil))))
 '(mode-line-buffer-id ((t (:foreground "#F0DFAF" :weight bold)))))

;; Mode associations
(add-to-list 'auto-mode-alist '("\\.asm\\'" . masm-mode))
(add-to-list 'auto-mode-alist '("\\.zig\\'" . zig-mode))
(add-to-list 'auto-mode-alist '("\\.zon\\'" . zig-mode))
(add-to-list 'auto-mode-alist '("\\.js\\'" . js-mode))
(add-to-list 'auto-mode-alist '("\\.c\\'" . c-mode))
(add-to-list 'auto-mode-alist '("\\.h\\'" . c-mode))
(add-to-list 'auto-mode-alist '("\\.rs\\'" . rust-mode))
(add-to-list 'auto-mode-alist '("\\.cpp\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.hpp\\'" . c++-mode))

;; Mode hooks
(add-hook 'c++-mode-hook
          (lambda ()
            (c-set-style "linux")
            (setq c-basic-offset 2
                  tab-width 2)
            (c-toggle-comment-style -1)))

(add-hook 'c-mode-hook
          (lambda ()
            (c-set-style "linux")
            (setq c-basic-offset 2
                  tab-width 2)
            (c-toggle-comment-style -1)))

(add-hook 'js-mode-hook
          (lambda ()
            (setq tab-width 2
                  js-indent-level 2)))

(add-hook 'zig-mode-hook
          (lambda ()
            (setq-local compile-command "zig build --color off")
            (use-local-map (make-sparse-keymap))
            (local-set-key (kbd "M-r") 'recompile)))

(add-hook 'markdown-mode-hook
          (lambda ()
            (toggle-word-wrap 1)))

;; Dired
(require 'dired-x)
(setq dired-omit-files (concat dired-omit-files "\\|^\\..+$")
      dired-dwim-target t
      dired-listing-switches "-alh")

;; Keybindings
(use-package bind-key)
(bind-key* "M-q" 'find-file)

(global-set-key (kbd "TAB") 'tab-to-tab-stop)
(global-set-key (kbd "M-<tab>") 'company-complete-selection)
(global-set-key (kbd "M-[") 'company-select-previous)
(global-set-key (kbd "M-]") 'company-select-next)
(global-set-key (kbd "C-c C-m") 'duplicate-line)
(global-set-key (kbd "M-2") 'other-window)
(global-set-key (kbd "M-`") 'ivy-switch-buffer)
(global-set-key (kbd "M-s") 'shell-command)
(global-set-key (kbd "M-e") 'grep-find)
(global-set-key (kbd "M-r") 'recompile)
(global-set-key (kbd "M-i") 'mark-sexp)
(global-set-key (kbd "M-a") 'async-shell-command)
(global-set-key (kbd "C-c C-k") 'kill-whole-line)
(global-set-key (kbd "C-c C-<backspace>") 'kill-whole-line)
(global-set-key (kbd "M-h") 'windmove-left)
(global-set-key (kbd "M-l") 'windmove-right)
(global-set-key (kbd "C-?") 'comment-or-uncomment-region)
(global-set-key (kbd "M-n") 'move-text-down)
(global-set-key (kbd "M-p") 'move-text-up)
(global-set-key (kbd "C-S-b") 'windswap-left)
(global-set-key (kbd "C-S-n") 'windswap-down)
(global-set-key (kbd "C-S-p") 'windswap-up)
(global-set-key (kbd "C-S-f") 'windswap-right)
(global-set-key (kbd "M-1") 'previous-buffer)
(global-set-key (kbd "M-3") 'next-buffer)
(global-set-key (kbd "C-0") 'shrink-window-horizontally)
(global-set-key (kbd "C--") 'enlarge-window-horizontally)
(global-set-key (kbd "C-=") 'enlarge-window)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "C-c m s") 'magit-status)
(global-set-key (kbd "C-c m l") 'magit-log)
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)
(global-set-key (kbd "C-\"") 'mc/skip-to-next-like-this)
(global-set-key (kbd "C-:") 'mc/skip-to-previous-like-this)
(global-set-key (kbd "M-.") 'lsp-find-definition)
(global-set-key (kbd "<f1>") 'toggle-lsp-breadcrumb)

;; Load local files
(add-to-list 'load-path "~/.emacs.local/")
(load "~/.emacs.rc/rc.el" t)
(load "~/.emacs.local/rush-mode.el" t)
(load "~/.emacs.shadow/shadow-rc.el" t)

(require 'fasm-mode nil t)
(require 'zig-mode nil t)
