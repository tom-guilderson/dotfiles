(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(add-to-list 'load-path "~/.emacs.d/lisp/")
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")

;;
;; turn off the tool bar, turn off scroll bar, no blinking cursor etc
;;
(when window-system
  (tool-bar-mode -1)
  (tooltip-mode -1)
  (scroll-bar-mode -1)
  (mouse-wheel-mode -1)
  (menu-bar-mode t)
  (load-theme 'alect-light t))
(when (memq window-system '(mac ns x))
 (exec-path-from-shell-initialize)
;; (set-frame-font "Andale Mono 18" nil t))
;; (set-frame-font "Monospace-18" nil t))
 (set-frame-font "Monospace-24" nil t))
;;
;; fonts
;;
;; (add-to-list 'default-frame-alist
;;             '(font . "Monospace-24"))
;;
;; (add-to-list 'default-frame-alist
;;             '(font . "Andale Mono 18"))
(blink-cursor-mode -1)
(column-number-mode t)
(setq initial-scratch-message "")
(setq inhibit-startup-message t)
(setq line-number-mode t)
(setq column-number-mode t)
(setq global-column-enforce-mode t)
(setq sentence-end-double-space nil)
(setq require-final-newline t)
(defalias 'yes-or-no-p 'y-or-n-p)

;; use my preferred shortcut for goto-line
;; remap quit from C-g to C-q
;;
(global-unset-key "\C-g")
(global-set-key "\C-q" 'keyboard-quit)
(global-set-key "\C-g" 'goto-line)

;;
;; when doing a list buffers - put it in a split window and move point
;;
(global-unset-key "\C-x\C-b")
(global-set-key "\C-x\C-b" 'buffer-menu-other-window)

;;
;; control split threshold for width for horizontal split screen
;;
(setq split-height-threshold nil)
(setq split-width-threshold 140)

;;
;; do not clutter file system with autosave and backup files
;; place them in ~/.emacs.d/backups and ~/.emacs.d/autosaves
(setq
 backup-by-copying t
 delete-old-versions t
 kept-new-versions 5
 kept-old-versions 2
 version-control t)
(setq backup-directory-alist `((".*" . "~/.emacs.d/backups/")))
(setq auto-save-file-name-transforms `((".*" "~/.emacs.d/autosaves/\\1" t)))
(make-directory "~/.emacs.d/backups/" t)
(make-directory "~/.emacs.d/autosaves/" t)

;;
;; org-mode
;;
;; (require 'org-install)
;; (add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
;; (define-key global-map "\C-cl" 'org-store-link)
;; (define-key global-map "\C-ca" 'org-agenda)
;; (setq org-log-done t)
;; ; org agenda files
;; (setq org-agenda-files (list "~/org/work.org"
;; 			     "~/org/home.org"))
;;

;; markdown-mode for editing/reading markdown text
;;
(autoload 'markdown-mode "markdown-mode"
  "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

;; use aspell instead of ispell
;;
(setq ispell-program-name "aspell"
      ispell-extra-args '("--sug-mode=ultra"))
(add-hook 'text-mode-hook
          (lambda() (flyspell-mode 1)))

;;
;; Some setting to help when coding
;;

;; always turn on color/syntax highlighting
(global-font-lock-mode 1)
;; show matching parens
(show-paren-mode t)
(setq blink-matching-paren-distance nil)
;;
;; C /C++ programming style changes
;;
(setq c-default-style "bsd"
      c-basic-offset 4)
(setq c-basic-offset 4)
(setq c-offsets-alist '((case-label . +)))

;;
;; x86 assembly - NASM
;; - because the default asm mode indentation is messed up
;;
(autoload 'nasm-mode "nasm-mode"
  "Major mode for editing NASM x86 assembly" t)
(add-to-list 'auto-mode-alist '("\\.asm\\'" . nasm-mode))
(add-to-list 'auto-mode-alist '("\\.s\\'" . nasm-mode))
(add-to-list 'auto-mode-alist '("\\.S\\'" . nasm-mode))

;;
;; Perl - use cperl mode
;;
; -> does not play nice with solarized theme
;(defalias 'perl-mode 'cperl-mode)
(setq perl-close-paren-offset -4)
(setq perl-continued-statement-offset 4)
(setq perl-indent-level 4)
(setq perl-indent-parens-as-block t)
(setq perl-tab-always-indent t)

;; Vagrant -> ruby
(add-to-list 'auto-mode-alist '("Vagrantfile$" . ruby-mode))

;;
;; Go
;;
(require 'go-mode)
(autoload 'go-mode "go-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.go\\'" . go-mode))

;;
;; go-dlv debugger GUD integration
;;
(require 'go-dlv)

;;
;; rust  https://rust-lang.org
;;
(require 'rust-mode)
(setq rust-format-on-save t)

;;
;; whitespace
;;
(setq-default show-trailing-whitespace t)
;; (add-hook 'before-save-hook 'delete-trailing-whitespace)

;;
;; tab settings
;;
(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)
(setq tab-stop-list (number-sequence 4 80 4))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(blink-cursor-mode nil)
 '(column-number-mode t)
 '(nil nil t)
 '(package-selected-packages
   '(alect-themes exec-path-from-shell go-mode markdown-mode rust-mode))
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
)
