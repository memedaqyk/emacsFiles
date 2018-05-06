(package-initialize)

;; 注意 elpa.emacs-china.org 是 Emacs China 中文社区在国内搭建的一个 ELPA 镜像
 ;; cl - Common Lisp Extension
 (require 'cl)

 ;; Add Packages
 (defvar kingle/packages '(
                ;; --- Auto-completion ---
                company
                ;; --- Better Editor ---
                hungry-delete
                swiper
                counsel
                smartparens
		;;smex
                ;; --- Major Mode ---
                js2-mode
                ;; --- Minor Mode ---
                nodejs-repl
                exec-path-from-shell
                ;; --- Themes ---
                monokai-theme
                ;; solarized-theme
		spacemacs-theme
		popwin
                ) "Default packages")

 (setq package-selected-packages kingle/packages)

 (defun kingle/packages-installed-p ()
     (loop for pkg in kingle/packages
           when (not (package-installed-p pkg)) do (return nil)
           finally (return t)))

 (unless (kingle/packages-installed-p)
     (message "%s" "Refreshing package database...")
     (package-refresh-contents)
     (dolist (pkg kingle/packages)
       (when (not (package-installed-p pkg))
         (package-install pkg))))


 ;; Find Executable Path on OS X
 (when (memq window-system '(mac ns))
   (exec-path-from-shell-initialize))



 (when (>= emacs-major-version 24)
     (require 'package)
     (package-initialize)
     (setq package-archives '(("gnu"   . "http://elpa.emacs-china.org/gnu/")
                      ("melpa" . "http://elpa.emacs-china.org/melpa/"))))


(require 'hungry-delete)
(global-hungry-delete-mode)


;;(require 'smartparens-config)
;;(add-hook 'emacs-lisp-mode-hook 'smartparens-mode)
(smartparens-global-mode t)

(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)

;;config for js2-mode javascript
(setq auto-mode-alist
      (append
       '(("\\.js\\'" . js2-mode))
       auto-mode-alist))

;; 开启全局 Company 补全
(global-company-mode 1)


;;popwin
(require 'popwin) 
(popwin-mode t)


;;javascript
(require 'nodejs-repl)
;; let emacs could find the executable
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))


(provide 'init-packages)
