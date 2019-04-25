;; set compile-command to make
(defun compile_cpp()
  (interactive)
  (compile "make -j8"))
;; set compile-command to make clean
(defun make_clean_cpp()
  (interactive)
  (compile "make clean"))
;; define keybinds for make and make clean c++-mode
(defun mp-add-c++-keys ()
  (define-key c++-mode-map (kbd "<f9>") 'compile_cpp)
  (define-key c++-mode-map (kbd "<f8>") 'make_clean_cpp))
;;  define keybinds for make and make clean c-mode
(defun mp-add-c-keys ()
  (define-key c-mode-map (kbd "<f9>") 'compile_cpp)
  (define-key c-mode-map (kbd "<f8>") 'make_clean_cpp))
;; set c-style indention
;;(setq c-default-style "bsd" c-basic-offset 4)
;; define .h files like c++-mode
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))
;; add hooks for keybinds in c/c++ modes
(add-hook 'c++-mode-hook 'mp-add-c++-keys)
(add-hook 'c-mode-hook 'mp-add-c-keys)
;; add hooks for irony in c/c++ modes
;; (add-hook 'c++-mode-hook 'irony-mode)
;; (add-hook 'c-mode-hook 'irony-mode)
;; hook compile database
;; (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)
;; set company-backend to company-irony
(eval-after-load 'company
		 '(add-to-list 'company-backends '(company-gtags)))
