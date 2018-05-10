;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.



;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(require 'cask "/usr/local/Cellar/cask/0.8.3/cask.el")
(cask-initialize)    
(require 'pallet)
(pallet-mode t)     
(require 'org-install)
(require 'ob-tangle)
(org-babel-load-file (expand-file-name "kingle.org" user-emacs-directory))


(put 'set-goal-column 'disabled nil)
