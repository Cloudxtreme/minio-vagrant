#!/bin/sh

# Init pkg-install.el
cat <<EOF > /root/pkg-install.el
;;
;; Install package from command line. Example:
;;
;;   $ emacs --batch --expr "(defconst pkg 'go-autocomplete)" -l pkg-install.el
;;

(require 'package)

(package-initialize)

(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)

(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/") t)

;; Fix HTTP1/1.1 problems
(setq url-http-attempt-keepalives nil)

(package-refresh-contents)

(package-install pkg)
EOF

# Install emacs packages
for pkg in $("go-autocomplete go-mode go-eldoc git-gutter go-mode-autoloads auto-complete auto-complete-config"); do
    emacs --batch --eval "(defconst pkg '$pkg)" -l /root/pkg-install.el
done

# Initialize emacs
mkdir -p /home/vagrant/.emacs.d
chown -R vagrant /home/vagrant/.emacs.d

cat <<EOF > /home/vagrant/.emacs.d/init.el
;; Go mode
(require 'git-gutter)
;; If you enable global minor mode
(global-git-gutter-mode t)
(setq git-gutter:modified-sign " ")
(setq git-gutter:added-sign "+")
(setq git-gutter:deleted-sign "-")

(require 'go-mode-autoloads)
(require 'auto-complete)
(require 'go-eldoc)
(require 'auto-complete-config) ;; get these from melpa
(require 'go-autocomplete) ;; get these from melpa
(ac-config-default)

(defun my-linux-c-mode ()
  "C mode with adjusted defaults for use with the linux kernel."
  (c-set-style "linux"))
(add-hook 'c-mode-hook 'my-linux-c-mode)

;; I hate tabs!
(setq-default indent-tabs-mode nil)

;; Compile key binding
(defun go-mode-setup ()
 (global-auto-complete-mode t)
 (projectile-global-mode)
 (go-eldoc-setup)
 (setq gofmt-command "goimports")
 (add-hook 'before-save-hook 'gofmt-before-save))
(add-hook 'before-save-hook 'gofmt-before-save)
(add-hook 'go-mode-hook 'go-mode-setup)
(setq compilation-scroll-output 'first-error)

EOF
