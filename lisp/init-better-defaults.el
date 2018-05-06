;;忽略警告提醒声音
(setq ring-bell-function 'ignore)

;;自动恢复加载
(global-auto-revert-mode t)

(set-language-environment "UTF-8")

;;缩写自动补全
(setq-default abbrev-mode t)
(define-abbrev-table 'global-abbrev-table '(
					    ("8kg" "kingle")
					    ))

;;~ 为后缀的文件为自动生成的备份文件我们可以使用下面的方法将其关闭。
(setq make-backup-files nil)
(setq auto-save-default nil)

;;更快捷的在图形界面的菜单中打开最近 编辑过的文件
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 20)

;;光标在中间，括号高亮
(define-advice show-paren-function (:around (fn) fix-show-paren-function)
  "Highlight enclosing parens."
  (cond ((looking-at-p "\\s(") (funcall fn))
        (t (save-excursion
             (ignore-errors (backward-up-list))
             (funcall fn)))))

;;括号匹配高亮
(add-hook 'emacs-lisp-mode-hook 'show-paren-mode)

;;当你选中一段文字 之后输入一个字符会替换掉你选中部分的文字。
(delete-selection-mode 1)

(defun indent-buffer()
  (interactive)
  (indent-region (point-min) (point-max)))

(defun indent-region-or-buffer()
  (interactive)
  (save-excursion
    (if (region-active-p)
        (progn
          (indent-region (region-beginning) (region-end))
          (message "Indent selected region."))
      (progn
	(indent-buffer)
        (message "Indent buffer.")))))

(setq hippie-expand-try-function-list '(try-expand-debbrev
                                        try-expand-debbrev-all-buffers
                                        try-expand-debbrev-from-kill
                                        try-complete-file-name-partially
                                        try-complete-file-name
                                        try-expand-all-abbrevs
                                        try-expand-list
                                        try-expand-line
                                        try-complete-lisp-symbol-partially
                                        try-complete-lisp-symbol))

;; less typing when Emacs ask you yes or no
(fset 'yes-or-no-p 'y-or-n-p)

;; always delete and copy recursively
(setq dired-recursive-deletes 'always)
(setq dired-recursive-copies 'always)

;;"C-x C-j"快捷键打开当前目录
(require 'dired-x)
;; Emacs 重用唯一的一个缓冲区作为 Dired Mode 显示专用缓冲区
(put 'dired-find-alternate-file 'disabled nil)

;; 延迟加载
(with-eval-after-load 'dired
  (define-key dired-mode-map (kbd "RET") 'dired-find-alternate-file))

;;使当一个窗口（frame）中存在两个分屏 （window）时，将另一个分屏自动设置成拷贝地址的目标。
(setq dired-dwin-target 1)

;;去掉文件中的换行标志
(defun hidden-dos-eol ()
  "Do not show ^M in files containing mixed UNIX and DOS line endings."
  (interactive)
  (setq buffer-display-table (make-display-table))
  (aset buffer-display-table ?\^M []))
(defun remove-dos-eol ()
  "Replace DOS eolns CR LF with Unix eolns CR"
  (interactive)
  (goto-char (point-min))
  (while (search-forward "\r" nil t) (replace-match "")))

;;增强正则搜索,dwin = do what i mean.
(defun occur-dwim ()
  "Call `occur' with a sane default."
  (interactive)
  (push (if (region-active-p)
	    (buffer-substring-no-properties
	     (region-beginning)
	     (region-end))
	  (let ((sym (thing-at-point 'symbol)))
	    (when (stringp sym)
	      (regexp-quote sym))))
	regexp-history)
  (call-interactively 'occur))

;;这个功能除了可以记录待办事项还有其他许许多多的功能例如获取将当前浏览器中的 URL
(defun kingle/insert-chrome-current-tab-url()
  "Get the URL of the active tab of the first window"
  (interactive)
  (insert (kingle/retrieve-chrome-current-tab-url)))

(defun kingle/retrieve-chrome-current-tab-url()
  "Get the URL of the active tab of the first window"
  (interactive)
  (let ((result (do-applescript
                 (concat
                  "set frontmostApplication to path to frontmost application\n"
                  "tell application \"Google Chrome\"\n"
                  " set theUrl to get URL of active tab of first window\n"
                  " set theResult to (get theUrl) \n"
                  "end tell\n"
                  "activate application (frontmostApplication as text)\n"
                  "set links to {}\n"
                  "copy theResult to the end of links\n"
                  "return links as string\n"))))
    (format "%s" (s-chop-suffix "\"" (s-chop-prefix "\"" result)))))


(provide 'init-better-defaults)
