;;config for swiper
(global-set-key "\C-s" 'swiper)
(global-set-key (kbd "C-c C-r") 'ivy-resume)
(global-set-key (kbd "<f6>") 'ivy-resume)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(global-set-key (kbd "C-h f") 'counsel-describe-function)
(global-set-key (kbd "C-h v") 'counsel-describe-variable)
(global-set-key (kbd "<f1> l") 'counsel-find-library)
;;(global-set-key (kbd "<f4> i") 'counsel-info-lookup-symbol)
;;(global-set-key (kbd "<f4> u") 'counsel-unicode-char)
(global-set-key (kbd "C-c g") 'counsel-git)
(global-set-key (kbd "C-c j") 'counsel-git-grep)
(global-set-key (kbd "C-c k") 'counsel-ag)
(global-set-key (kbd "C-x l") 'counsel-locate)
(global-set-key (kbd "C-S-o") 'counsel-rhythmbox)
(define-key minibuffer-local-map (kbd "C-r") 'counsel-minibuffer-history)

;; 这一行代码，将函数 open-init-file 绑定到 <f2> 键上
(global-set-key (kbd "<f2>") 'open-init-file)

;; 这个快捷键绑定可以用之后的插件 counsel 代替
(global-set-key (kbd "C-x C-r") 'recentf-open-files)

;;函数，变量详解
(global-set-key (kbd "C-h C-f") 'find-function)
(global-set-key (kbd "C-h C-v") 'find-variable)
(global-set-key (kbd "C-h C-k") 'find-function-on-key)

(global-set-key (kbd "C-c p f") 'counsel-git)

;; 设置 org-agenda 打开快捷键
(global-set-key (kbd "C-c a") 'org-agenda)

;;缩进格式化
(global-set-key (kbd "C-M-\\") 'indent-region-or-buffer)

;;补全
(global-set-key (kbd "s-/") 'hippie-expand)

;;搜索函数
(global-set-key (kbd "M-s i") 'counsel-imenu)

;;多行选中相同的词
;;(global-set-key (kbd "M-s e") 'iedit-mode)

;;Org-mode  下面的配置代码来设置一个模板
(global-set-key (kbd "C-c r") 'org-capture)

;;选中
(global-set-key (kbd "C-=") 'er/expand-region)

;;js2r js文件操作的前缀
(js2r-add-keybindings-with-prefix "C-c C-m")

;;切换tab的长度
(global-set-key (kbd "C-c t i") 'my-toggle-web-indent)

;;正则匹配
(global-set-key (kbd "M-s o") 'occur-dwim)

(provide 'init-keybindings)
