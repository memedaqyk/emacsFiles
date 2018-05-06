;;忽略警告提醒声音
(setq ring-bell-function 'ignore)

;;自动恢复加载
(global-auto-revert-mode t)

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

(provide 'init-better-defaults)
