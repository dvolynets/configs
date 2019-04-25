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

(toc:load-config-file '("basic_config"
			"c_cpp_config"
			"py_config"
			"setup-ggtags"))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 ;;'(company-auto-complete t)
 '(company-auto-complete nil)
 '(company-backends
   (quote
    (company-bbdb company-nxml company-eclim company-semantic company-clang company-cmake company-files
		  (company-dabbrev-code company-gtags company-etags company-keywords)
		  company-oddmuse company-dabbrev)))
 '(company-clang-insert-arguments t)
 '(company-global-modes t)
 '(company-idle-delay 0)
 '(company-minimum-prefix-length 2)
 '(ggtags-highlight-tag 0.15)
 '(inhibit-startup-screen nil)
 '(package-selected-packages (quote (ranger ggtags company-jedi company-irony irony))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ggtags-global-line ((t (:inherit secondary-selection))))
 '(ggtags-highlight ((t nil))))
