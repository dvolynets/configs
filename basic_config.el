(global-hl-line-mode 1)
;; set font
(set-frame-font "DejaVu Sans Mono-9" nil t)
;;set emacs theme
;;(load-theme 'leuven t)
;;disable scroll menu tool bars
(tool-bar-mode -1)
(scroll-bar-mode -1)
(menu-bar-mode -1)
;;set number of column and line
(column-number-mode)
;; highlight pair brackets
(show-paren-mode t)
;; disable backup
(setq backup-inhibited t)
;; enable company-mode everywhere
;;(add-hook 'after-init-hook 'global-company-mode)
;; disable auto-saves
(setq auto-save-default nil)
;; ban new windows creation in emacs
(setq split-height-threshold nil
            split-width-threshold nil)
;; disable indentation
(electric-indent-mode -1)
;; set up ibuffer
(global-set-key (kbd "C-x C-b") 'ibuffer)
;; dislable font of code
(global-font-lock-mode 0)
;; use spaces instead tabs
(setq-default indent-tabs-mode nil)
;; set default grep command
(setq grep-command "grep --color -nH --null -rI --include=*.{} --exclude-dir={} -w search folder")
