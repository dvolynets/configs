(package-initialize)

;; melpa packages
(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
		                        (not (gnutls-available-p))))
              (url (concat (if no-ssl "http" "https") "://melpa.org/packages/")))
    (add-to-list 'package-archives (cons "melpa" url) t))
(when (< emacs-major-version 24)
    ;; For important compatibility libraries like cl-lib
      (add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/")))

;; directory for emacs config files
(defconst toc:emacs-config-dir "~/.emacs.d/emacs_configs/" "")

(defun toc:load-config-file (filelist)
  (dolist (file filelist)
    (load (expand-file-name
	    (concat toc:emacs-config-dir file)))
  (message "Loaded config file:%s" file)
  ))

(toc:load-config-file '("basic_config"))

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

;; combine two functions in one!
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

;; (thing-at-point 'word 'no-properties)

(setup-project-root nil)
(setup-grep-include-file-pattern nil)
(setup-grep-exclude-pattern nil)

(global-set-key (kbd "C-x p f") 'find-project-file)
(global-set-key (kbd "C-x p w") 'find-word-recursive)
(global-set-key (kbd "C-x p p") 'find-part-word-recursive)

;; (set-foreground-color "#696969")
