;;如果我们启用 exec-path-from-shell , 在 emacs 启动时可能会提示 PATH 变量重复定义
(use-package exec-path-from-shell
  :ensure t
  :pin melpa-stable
  :if (and (eq system-type 'darwin) (display-graphic-p))
  :config
  (progn
    (when (string-match-p "/zsh$" (getenv "SHELL"))
      ;; Use a non-interactive login shell.  A login shell, because my
      ;; environment variables are mostly set in `.zprofile'.
      (setq exec-path-from-shell-arguments '("-l")))

    (exec-path-from-shell-initialize)
    )
  )


;;(require 'hungry-delete)
(global-hungry-delete-mode)

;;(require 'smartparens-config)
;;(add-hook 'emacs-lisp-mode-hook 'smartparens-mode)
(smartparens-global-mode t)
(sp-local-pair 'emacs-lisp-mode "'" nil :actions nil) 

(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
;;(setq enable-recursive-minibuffers t)

;;config for js2-mode javascript
(setq auto-mode-alist
      (append
       '(("\\.js\\'" . js2-mode)
	 ("\\.html\\'" . web-mode))
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

;;config for web-mode
(defun my-web-mode-indent-setup ()
  (setq web-mode-markup-indent-offset 2) ; web-mode, html tag in html file
  (setq web-mode-css-indent-offset 2)    ; web-mode, css in html file
  (setq web-mode-code-indent-offset 2)   ; web-mode, js code in html file
  )
(add-hook 'web-mode-hook 'my-web-mode-indent-setup)

(defun my-toggle-web-indent ()
  (interactive)
  ;; web development
  (if (or (eq major-mode 'js-mode) (eq major-mode 'js2-mode))
      (progn
	(setq js-indent-level (if (= js-indent-level 2) 4 2))
	(setq js2-basic-offset (if (= js2-basic-offset 2) 4 2))))

  (if (eq major-mode 'web-mode)
      (progn (setq web-mode-markup-indent-offset (if (= web-mode-markup-indent-offset 2) 4 2))
	     (setq web-mode-css-indent-offset (if (= web-mode-css-indent-offset 2) 4 2))
	     (setq web-mode-code-indent-offset (if (= web-mode-code-indent-offset 2) 4 2))))
  (if (eq major-mode 'css-mode)
      (setq css-indent-offset (if (= css-indent-offset 2) 4 2)))

  (setq indent-tabs-mode nil))



;;config for js2-refactor
(add-hook 'js2-mode-hook #'js2-refactor-mode)


;;imenu 可以显示当前所有缓冲区的列表，下面的配置可以让其拥有更精确的跳转
(defun js2-imenu-make-index ()
  (interactive)
  (save-excursion
    ;; (setq imenu-generic-expression '((nil "describe\\(\"\\(.+\\)\"" 1)))
    (imenu--generic-function '(("describe" "\\s-*describe\\s-*(\\s-*[\"']\\(.+\\)[\"']\\s-*,.*" 1)
			       ("it" "\\s-*it\\s-*(\\s-*[\"']\\(.+\\)[\"']\\s-*,.*" 1)
			       ("test" "\\s-*test\\s-*(\\s-*[\"']\\(.+\\)[\"']\\s-*,.*" 1)
			       ("before" "\\s-*before\\s-*(\\s-*[\"']\\(.+\\)[\"']\\s-*,.*" 1)
			       ("after" "\\s-*after\\s-*(\\s-*[\"']\\(.+\\)[\"']\\s-*,.*" 1)
			       ("Function" "function[ \t]+\\([a-zA-Z0-9_$.]+\\)[ \t]*(" 1)
			       ("Function" "^[ \t]*\\([a-zA-Z0-9_$.]+\\)[ \t]*=[ \t]*function[ \t]*(" 1)
			       ("Function" "^var[ \t]*\\([a-zA-Z0-9_$.]+\\)[ \t]*=[ \t]*function[ \t]*(" 1)
			       ("Function" "^[ \t]*\\([a-zA-Z0-9_$.]+\\)[ \t]*()[ \t]*{" 1)
			       ("Function" "^[ \t]*\\([a-zA-Z0-9_$.]+\\)[ \t]*:[ \t]*function[ \t]*(" 1)
			       ("Task" "[. \t]task([ \t]*['\"]\\([^'\"]+\\)" 1)))))
(add-hook 'js2-mode-hook
	  (lambda ()
	    (setq imenu-create-index-function 'js2-imenu-make-index)))
(require 'iedit)
(require 'org-pomodoro)


;;激活flycheck
(add-hook 'js2-mode-hook 'flycheck-mode)

;;yasnippet激活
(add-to-list 'load-path
	     "~/.emacs.d/plugins/yasnippet")
(require 'yasnippet)
(yas-global-mode 1)
(yas-reload-all)
(add-hook 'prog-mode-hook #'yas-minor-mode)

(evil-mode 1)
(setcdr evil-insert-state-map nil)
(define-key evil-insert-state-map [escape] 'evil-normal-state)
;;(setq-default evil-want-C-u-scroll t)

;;evil-leader
(global-evil-leader-mode)
(evil-leader/set-key
  "ff" 'find-file
  ;;"kk" 'kill-buffer
  "SPC" 'counsel-M-x
  "w" 'save-buffer
  "fr" 'recentf-open-files
  "pf" 'counsel-git
  "ps" 'helm-do-ag-project-root
  "b" 'switch-to-buffer
  "m" 'evil-jump-item
  "pp" 'switch-to-prev-buffer
  "nn" 'switch-to-next-buffer
  "tt" 'neotree-toggle
  "a" 'evil-first-non-blank
  "e" 'evil-end-of-line
  "yy" 'youdao-dictionary-search-at-point
  "yd" 'youdao-dictionary-search
  "1"  'select-window-1
  "2"  'select-window-2
  "3"  'select-window-3
  "|" 'split-window-right
  "-" 'split-window-below
  "d" 'delete-other-windows
  "q" 'delete-window
  "kk" 'save-buffers-kill-terminal
  "i" 'anaconda-mode-complete
  )

(define-key evil-normal-state-map (kbd ",/") 'evilnc-comment-or-uncomment-lines)
(define-key evil-visual-state-map (kbd ",/") 'evilnc-comment-or-uncomment-lines)

;;激活 以便使用alt-0, alt-1
(window-numbering-mode 1)

;;powerline
;;(require 'powerline)
;;(powerline-default-theme)

;; Enable Cache youdaoyun
(setq url-automatic-caching t)

;; evil-escape
(require 'evil-escape)
(setq-default evil-escape-key-sequence "kj")
(setq-default evil-escape-delay 0)

;; evil-surround
(require 'evil-surround)
(global-evil-surround-mode)

;;evil-nerd-commenter
(evilnc-default-hotkeys t)

;;Made some modes to use emacs-state
(dolist (mode '(ag-mode
		flycheck-error-list-mode
		git-rebase-mode))
  (add-to-list 'evil-emacs-state-modes mode))

;;在occur-mode下依然能用j, k
(add-hook 'occur-mode-hook
          (lambda ()
            (evil-add-hjkl-bindings occur-mode-map 'emacs
              (kbd "/")       'evil-search-forward
              (kbd "n")       'evil-search-next
              (kbd "N")       'evil-search-previous
              (kbd "C-d")     'evil-scroll-down
              (kbd "C-u")     'evil-scroll-up
              )))

;;which-key-mode
(which-key-mode 1)
(which-key-setup-side-window-right)

;;然后确保在 company-backends 中有 company-anaconda 这个后端即可
(add-hook 'python-mode-hook 'anaconda-mode)
(add-hook 'python-mode-hook
          (lambda ()
            (set (make-local-variable 'company-backends) '((company-anaconda company-dabbrev-code)
                                                           company-dabbrev)))
          )
;; For elpy
(elpy-enable)

(setq python-shell-interpreter "/Users/kingle/anaconda/bin/ipython"
      python-shell-interpreter-args "--simple-prompt -i")

(setq tramp-ssh-controlmaster-options
      "-o ControlMaster=auto -o ControlPath='tramp.%%C' -o ControlPersist=no")



(provide 'init-packages)
