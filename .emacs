;;; package --- Summary
;;; Commentary:
;;; Code:
(setq default-directory "~/sites/")
(setq inhibit-startup-message t)
;; Do this first to avoid annoying flickering
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))

(require 'package)
(add-to-list 'package-archives
             '("melpa-stable" . "http://stable.melpa.org/packages/") t)
(add-to-list 'package-archives
	                  '("marmalade" . "http://marmalade-repo.org/packages/") t)

(setq package-enable-at-startup nil)
(package-initialize)

(setq x-select-enable-clipboard t)

(prefer-coding-system 'utf-8)

(setq file-name-coding-system 'chinese-gbk-unix)
(setq coding-system-for-read 'utf-8)
(setq coding-system-for-write 'utf-8)
(setq buffer-file-coding-system 'utf-8)
(setq locale-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
;; (set-selection-coding-system 'utf-8)

(set-language-environment "UTF-8")
(setq process-coding-system-alist '(("svn" . utf-8)))
;; (setq svn-status-svn-process-coding-system 'utf-8)
(setenv "LC_ALL" "zh_CN.UTF-8")
(setenv "LANG" "zh_CN.UTF-8")

(setq-default indent-tabs-mode nil)
(setq tab-width 4)
;; (setq tab-width 4
;; 	c-basic-offset 4)
(setq tab-stop-list '(4 8 12 16 20 24 28 32 36 40
44 48 52 56 60 64 68 72 76 80 84 88 92 96))
;; (setq ruby-indent-level 4)
;; (setq sgml-basic-offset 4)

;; Font and color theme
;; (set-default-font "Source Code Pro Semibold-14")
(set-frame-font "Hack-14")


(load-theme 'charcoal-black t t)
(enable-theme 'charcoal-black)

(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.tmpl$" . html-mode))


(require 'ido)
(ido-mode t)
;; company
(add-hook 'after-init-hook 'global-company-mode)

(setq bookmark-save-flag 1)

;; (require 'highlight-indentation)
;; (set-face-background 'highlight-indentation-face "#666666")
;; (set-face-background 'highlight-indentation-current-column-face "#666666")

 ;; https://github.com/rooney/zencoding
(require 'zencoding-mode)
(add-hook 'sgml-mode-hook 'zencoding-mode) ;;Auto-start on any markup modes

;; electric
(require 'electric)
(add-to-list 'electric-layout-rules '(?{ . after))
;;(add-to-list 'electric-pair-pairs '(?{ . ?}))
;;系统本身内置的智能自动补全括号
(electric-pair-mode t)
;;特定条件下插入新行
;;(electric-layout-mode t)
;;编辑时智能缩进，类似于C-j的效果――这个C-j中，zencoding和electric-pair-mode冲突
(electric-indent-mode t)

;; (require 'yasnippet)
;; (setq yas-snippet-dirs '("~/emacs-lisp/snippets"))
;; (setq yas-snippet-dirs '("~/.emacs.d/custom/snippets"))
;;(setq yas/prompt-functions '(yas/ido-prompt
;;                             yas/completing-prompt))
;; (require 'dropdown-list) ;; this is a separate package, that needs to be installed
(setq yas-prompt-functions
      '(yas-ido-prompt
        yas-x-prompt
        yas-completing-prompt
        yas-no-prompt))

(yas-global-mode 1)
(add-hook 'prog-mode-hook
          '(lambda ()
             (yas-minor-mode)))


  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PACKAGE: helm              ;;
;;                            ;;
;; GROUP: Convenience -> Helm ;;
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (require 'helm)

;; must set before helm-config,  otherwise helm use default
;; prefix "C-x c", which is inconvenient because you can
;; accidentially pressed "C-x C-c"
(setq helm-command-prefix-key "C-c h")

(require 'helm-config)
(require 'helm-eshell)
(require 'helm-files)
(require 'helm-grep)

(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebihnd tab to do persistent action
(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB works in terminal
(define-key helm-map (kbd "C-z")  'helm-select-action) ; list actions using C-z

(define-key helm-grep-mode-map (kbd "<return>")  'helm-grep-mode-jump-other-window)
(define-key helm-grep-mode-map (kbd "n")  'helm-grep-mode-jump-other-window-forward)
(define-key helm-grep-mode-map (kbd "p")  'helm-grep-mode-jump-other-window-backward)

(setq
 helm-net-prefer-curl t
 helm-scroll-amount 4 ; scroll 4 lines other window using M-<next>/M-<prior>
 helm-quick-update t ; do not display invisible candidates
 helm-idle-delay 0.01 ; be idle for this many seconds, before updating in delayed sources.
 helm-input-idle-delay 0.01 ; be idle for this many seconds, before updating candidate buffer
 helm-ff-search-library-in-sexp t ; search for library in `require' and `declare-function' sexp.

 helm-split-window-default-side 'other ;; open helm buffer in another window
 helm-split-window-in-side-p t ;; open helm buffer inside current window, not occupy whole other window
 helm-buffers-favorite-modes (append helm-buffers-favorite-modes
                                     '(picture-mode artist-mode))
 helm-candidate-number-limit 200 ; limit the number of displayed canidates
 helm-M-x-requires-pattern 0     ; show all candidates when set to 0
 helm-boring-file-regexp-list
 '("\\.git$" "\\.hg$" "\\.svn$" "\\.CVS$" "\\._darcs$" "\\.la$" "\\.o$" "\\.i$") ; do not show these files in helm buffer
 helm-ff-file-name-history-use-recentf t
 helm-move-to-line-cycle-in-source t ; move to end or beginning of source
                                        ; when reaching top or bottom of source.
 ido-use-virtual-buffers t      ; Needed in helm-buffers-list
 helm-buffers-fuzzy-matching t          ; fuzzy matching buffer names when non--nil
                                        ; useful in helm-mini that lists buffers
 )

;; Save current position to mark ring when jumping to a different place
(add-hook 'helm-goto-line-before-hook 'helm-save-current-pos-to-mark-ring)

(helm-mode 1)

(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)
(global-set-key (kbd "C-x b") 'helm-mini)
(global-set-key (kbd "C-x C-f") 'helm-find-files)


(add-hook 'js2-mode-hook (lambda () (highlight-parentheses-mode t)))
(add-hook 'php-mode-hook (lambda () (highlight-parentheses-mode t)))
(add-hook 'css-mode-hook (lambda () (highlight-parentheses-mode t)))

(projectile-global-mode)

(setq scss-compile-at-save nil)

;; use web-mode for .jsx files
;; (add-to-list 'auto-mode-alist '("\\.jsx$" . web-mode))

;; http://www.flycheck.org/manual/latest/index.html
(require 'flycheck)

;; turn on flychecking globally
(add-hook 'after-init-hook #'global-flycheck-mode)

;; disable jshint since we prefer eslint checking
(setq-default flycheck-disabled-checkers
              (append flycheck-disabled-checkers
                      '(javascript-jshint)))

;; use eslint with web-mode for jsx files
(flycheck-add-mode 'javascript-eslint 'web-mode)

;; disable json-jsonlist checking for json files
(setq-default flycheck-disabled-checkers
              (append flycheck-disabled-checkers
                      '(json-jsonlist)))

;; https://github.com/purcell/exec-path-from-shell
;; only need exec-path-from-shell on OSX
;; this hopefully sets up path and other vars better
(when (memq window-system '(mac ns))
   (exec-path-from-shell-initialize))

(provide '.emacs)
;;; .emacs ends here

