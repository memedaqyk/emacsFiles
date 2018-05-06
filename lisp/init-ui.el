;;光标
(tool-bar-mode -1)

;; 关闭文件滑动控件
(scroll-bar-mode -1)

;; 显示行号
(global-linum-mode 1)

;; 关闭启动帮助画面
(setq inhibit-splash-screen 1)

;;全屏
(setq initial-frame-alist (quote ((fullscreen . maximized))))

;; 更改光标的样式（不能生效，解决方案见第二集）
(setq-default cursor-type 'bar)


;;主题
(load-theme 'spacemacs-dark t)

;;当前行高亮
(global-hl-line-mode t)

;; 更改显示字体大小 16pt
;; http://stackoverflow.com/questions/294664/how-to-set-the-font-size-in-emacs
(set-face-attribute 'default nil :height 220)

;; 关闭缩进 (第二天中被去除)
;; (electric-indent-mode -1)


(provide 'init-ui)
