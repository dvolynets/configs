;; =====================================================================
;;
;;                                Functions
;;
;; =====================================================================

(defun setup-project-root (path)
  (interactive "ssetup project-root variable to: ")
  (setq project-root path)
  (message "project-root: %s" path))

(defun setup-grep-include-file-pattern (pattern)
  (interactive "ssetup grep include file pattern (--include): ")
  (setq grep-include-pattern pattern)
  (message "grep-include-pattern: %s" pattern))

(defun setup-grep-exclude-pattern (pattern)
  (interactive "ssetup grep exclude pattern (--exclude-dir): ")
  (setq grep-exclude-pattern pattern)
  (message "grep-exclude-pattern: %s" pattern))

(defun find-project-file (filename)
  (interactive "sfile to find: ")
  (if (not project-root)
      (call-interactively 'setup-project-root))
  (find-name-dired project-root filename))

(defun find-word-recursive (search-word)
  (interactive 
   (let ((symbol-at-point (thing-at-point 'symbol)))
   (list (read-string 
          (format "word to find (default %s): " symbol-at-point) nil nil symbol-at-point))))

  (if (not project-root)
      (call-interactively 'setup-project-root))

  (if (not grep-include-pattern)
      (call-interactively 'setup-grep-include-file-pattern))

  (if (not grep-exclude-pattern)
      (call-interactively 'setup-grep-exclude-pattern))

  (let ((value 
         (format "grep --color -nH --null -rI --include=*.{%s} --exclude-dir={%s} -w %s %s"
                 grep-include-pattern grep-exclude-pattern search-word project-root)))
    (grep value)))

(defun find-part-word-recursive (search-word)
  (interactive
   (let ((symbol-at-point (thing-at-point 'symbol)))
     (list (read-string 
            (format "word to find (default %s): " symbol-at-point) nil nil symbol-at-point))))

  (if (not project-root)
      (call-interactively 'setup-project-root))

  (if (not grep-include-pattern)
      (call-interactively 'setup-grep-include-file-pattern))

  (if (not grep-exclude-pattern)
      (call-interactively 'setup-grep-exclude-pattern))

  (let ((value 
         (format "grep --color -nH --null -rI --include=*.{%s} --exclude-dir={%s} %s %s"
                 grep-include-pattern grep-exclude-pattern search-word project-root)))
    (grep value)))

(defun kill-thing-at-point (thing)
  "Kill the `thing-at-point' for the specified kind of THING."
  (let ((bounds (bounds-of-thing-at-point thing)))
    (if bounds
        (kill-region (car bounds) (cdr bounds))
      (error "No %s at point" thing))))

(defun yank-thing-at-point (thing)
  "Yank the `thing-at-point' for the specified kind of THING."
  (let ((bounds (bounds-of-thing-at-point thing)))
    (if bounds
        (copy-region-as-kill (car bounds) (cdr bounds))
      (error "No %s at point" thing))))

(defun yank-line (arg)
      "Copy lines (as many as prefix argument) in the kill ring"
      (interactive)
      (kill-ring-save (line-beginning-position)
                      (line-beginning-position (+ 1 arg))))

(defun paste (&optional arg)
      "Paste word at current position or line from new line"
      (interactive)
      (if (or (eq last-command 'yank-line)
	      (eq last-command 'kill-whole-line))
	  (dotimes (i arg)
            (progn
	      (beginning-of-line)
	      (yank 1)
	      (back-to-indentation)))
	(yank 1)))

(defun kill-word-at-point ()
  "Kill the word at point."
  (interactive)
  (kill-thing-at-point 'word))

(defun kill-whole-word-at-point ()
  "Kill the word at point."
  (interactive)
  (kill-thing-at-point 'symbol))

(defun yank-word-at-point ()
  "Kill the word at point."
  (interactive)
  (yank-thing-at-point 'word))

(defun yank-whole-word-at-point ()
  "Kill the word at point."
  (interactive)
  (yank-thing-at-point 'symbol))

;; =====================================================================
;;
;;                                Defaults
;;
;; =====================================================================

;; highlight current line
(global-hl-line-mode 1)
;; set font
(set-frame-font "DejaVu Sans Mono-9" nil t)
;; set emacs theme
(load-theme 'leuven t)
;; disable scroll menu tool bars
(tool-bar-mode -1)
(scroll-bar-mode -1)
(menu-bar-mode -1)
;; set number of column and line
(column-number-mode)
;; non blinking cursor
(blink-cursor-mode 0)
;; highlight pair brackets
(show-paren-mode t)
;; disable backup
(setq backup-inhibited t)
;; disable auto-save
(setq auto-save-default nil)
;; disable automatic windows splitting
(setq split-height-threshold nil
      split-width-threshold nil)
;;disable emacs welcome screen
(setq inhibit-startup-screen t)

(defalias 'yes-or-no-p 'y-or-n-p)

;; search defaults
(setup-project-root nil)
(setup-grep-include-file-pattern nil)
(setup-grep-exclude-pattern nil)

;; =====================================================================
;;
;;                                Keybindings
;;
;; =====================================================================

;; default ibuffer
(global-set-key (kbd "C-x C-b") 'ibuffer)

(global-set-key (kbd "C-x p f") 'find-project-file)
(global-set-key (kbd "C-x p w") 'find-word-recursive)
(global-set-key (kbd "C-x p p") 'find-part-word-recursive)

(global-set-key (kbd "C-c d w") 'kill-word-at-point)
(global-set-key (kbd "C-c d W") 'kill-whole-word-at-point)

(global-set-key (kbd "C-c y w") 'yank-word-at-point)
(global-set-key (kbd "C-c y W") 'yank-whole-word-at-point)

(global-set-key (kbd "C-c y y") 'yank-line)
(global-set-key (kbd "C-c d d") 'kill-whole-line)

(global-set-key (kbd "C-c p p") 'paste)
;; text color
;; (set-foreground-color "#696969")
