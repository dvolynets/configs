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
(add-hook 'after-init-hook 'global-company-mode)
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

(add-to-list 'custom-theme-load-path
             (file-name-as-directory "/home/dimav/.emacs.d/themes"))

(load-theme 'aalto-light t t)
(enable-theme 'aalto-light)

(defun toggle-frame-split ()
    "If the frame is split vertically, split it horizontally or vice versa.
  Assumes that the frame is only split into two."
    (interactive)
      (unless (= (length (window-list)) 2) (error "Can only toggle a frame split in two"))
        (let ((split-vertically-p (window-combined-p)))
	      (delete-window) ; closes current window
	          (if split-vertically-p
		            (split-window-horizontally)
			          (split-window-vertically)
				  (split-window-horizontally)) ; gives us a split with the other window twice
		      (switch-to-buffer nil))) ; restore the original window in this part of the frame

;; I don't use the default binding of 'C-x 5', so use toggle-frame-split instead
(global-set-key (kbd "C-x 4") 'toggle-frame-split)

