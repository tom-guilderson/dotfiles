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
  (load-theme 'solarized-light t))
(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize)
  (set-frame-font "Andale Mono 14" nil t))
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
;; uncomment to use horizontal split screen instead of vertical
;;
;(setq split-height-threshold nil)
;(setq split-width-threshold 0)
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
(require 'org-install)
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)
; org agenda files
(setq org-agenda-files (list "~/org/work.org"
			     "~/org/home.org"))
;;
;; markdown-mode for editing/reading markdown text
;;
(autoload 'markdown-mode "markdown-mode"
  "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))
;;
;; linum-mode - use M-x linum-mode to toggle on/off
;;
(require 'linum)
(setq linum-format "%5d ")
;;
;; post-mode for editing email from mutt
;;
;; (load "~/.mutt/post")
;;
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
(require 'go-guru)
(require 'gotest)
(require 'company)
(require 'company-go)
;; post from the creator of go-mode that has some useful info
;; http://dominik.honnef.co/posts/2013/03/writing_go_in_emacs/
;;
;; need to learn how to configure/use flycheck:
;; https://github.com/flycheck/flycheck
;; https://github.com/weijiangan/flycheck-golangci-lint
;;
;; disable megacheck - others says it is a resource hog ...
;; (add-to-list 'flycheck-disabled-checkers 'go-megacheck)
(add-hook 'go-mode-hook
          (lambda ()
            (setq tab-width 4 indent-tabs-mode 1)
            (go-eldoc-setup)
            (set (make-local-variable 'company-backends) '(company-go))
            (company-mode)
            ;; run gofmt before saving
            (add-hook 'before-save-hook 'gofmt-before-save)
            ;; manage imports
            ;; C-c C-a is mapped to go-import-add by default in go-mode
            (local-set-key (kbd "C-c C-r") 'go-remove-unused-imports)
            (local-set-key (kbd "C-c c") 'go-goto-imports)
            (go-guru-hl-identifier-mode)))
(setenv "GOPATH" "/Users/tom.guilderson/go")
(setenv "CGO_CXX_FLAGS_ALLOW" "-lpthread")
(add-to-list 'exec-path "/Users/tom.guilderson/go/bin")
;; https://github.com/mdempsky/gocode
;; using the go-autocomplete.el copied from gocode repository
;; (require 'go-autocomplete)
;; (require 'auto-complete-config)
;; (ac-config-default)
;;
;; whitespace
;;
(setq-default show-trailing-whitespace t)
(add-hook 'before-save-hook 'delete-trailing-whitespace)
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
 '(package-selected-packages
   (quote
    (markdown-mode gotest go-guru go-eldoc flycheck-golangci-lint exec-path-from-shell company-go auto-complete))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
