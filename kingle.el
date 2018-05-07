
(package-initialize)

(add-to-list 'load-path "~/.emacs.d/lisp/")


(setq custom-file (expand-file-name "lisp/custom.el" user-emacs-directory))

(load-file custom-file)


;; 快速打开配置文件
(defun open-init-file()
  (interactive)
  (find-file "~/.emacs.d/init.el"))

(require 'init-packages)
(require 'init-ui)
(require 'init-better-defaults)
(require 'init-org)
(require 'init-keybindings)
