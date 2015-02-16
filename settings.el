
;; Insert current date
(defun insert-standard-date ()
    "Inserts standard date time string."
    (interactive)
    (insert (format-time-string "%c")))

(defun scroll-up-one-line()
  (interactive)
  (scroll-up 1))

(defun scroll-down-one-line()
  (interactive)
  (scroll-down 1))

;; (re-)load init.el
(global-set-key [XF86Tools] (lambda ()
 (interactive)
 (load-file (concat user-emacs-directory "init.el"))))

;; read file content, use with split string to get a list of lines
(defun slurp (f)
  (with-temp-buffer
    (insert-file-contents f)
    (buffer-substring-no-properties
       (point-min)
       (point-max))))

;; proxy - cntlm
(setq url-proxy-services '(("http" . "127.0.0.1:3128")))

(require 'package)

(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/") t)
(add-to-list 'package-archives
             '("gnu" . "http://elpa.gnu.org/packages/") t)

(package-initialize)

(defconst demo-packages
  '(anzu
    company
    company-c-headers
    duplicate-thing
    ggtags
    helm
    helm-gtags
    helm-swoop
    helm-projectile
    function-args
    clean-aindent-mode
    comment-dwim-2
    dtrt-indent
    ws-butler
    yasnippet
    smartparens
    sml-mode
    projectile
    volatile-highlights
    undo-tree
    zygospore
    sr-speedbar
    frame-cmds
    expand-region
    highlight-current-line
    highlight-indentation
    iedit
    ;find-file-in-repository
    flycheck
    buffer-move
    framemove
    linum-relative
    markdown-mode
    htmlize
    dirtree
    neotree
    multiple-cursors
    ;magit

    ;jedi
    ;jedi-direx
    ;ein

    ;fill-column-indicator
    ;flymake-google-cpplint
    ;google-c-style
    ;flymake-cursor

    ;virtualenvwrapper
    ;python-mode
    ;pos-tip
    ;request
    ;websocket
)
"List of packages to install.")

(defvar custom-directory-packages
  (concat user-emacs-directory "site-packages"))

;; Custom packages dir, not sourced from online repos or modified manually
(add-to-list 'load-path (concat user-emacs-directory "site-packages"))

(defun install-packages ()
  "Install all required packages."
  (interactive)
  (unless package-archive-contents
    (package-refresh-contents))
  (dolist (package demo-packages)
    (unless (package-installed-p package)
      (package-install package))))

(install-packages)

;; Use latest development version of Cedet
(load-file (concat user-emacs-directory "cedet/cedet-devel-load.el"))
(load-file (concat user-emacs-directory "cedet/contrib/cedet-contrib-load.el"))

;; (add-to-list 'load-path (concat user-emacs-directory "custom"))
;; (defvar custom-directory-themes
;;  (concat custom-directory-root "themes"))

(setq frame-title-format "Editing - %b")

;; Keep track of recently opened-files
(require 'recentf)
(recentf-mode t)
(setq recentf-max-saved-items 50)
(global-set-key (kbd "C-x C-r") 'helm-recentf)

;; Simplistic interface
;; No start-up messages nor splashes
(setq inhibit-splash-screen t)
(setq inhibit-startup-message t)
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

;; Themes
(add-to-list 'custom-theme-load-path (concat user-emacs-directory "themes"))
(load-theme 'zenburn t)

;; Turn beep off
(setq visible-bell 1)

;; Show time
(display-time-mode 1)

;; Default font larger
(set-face-attribute 'default nil :height 130)

;; Winner
(when (fboundp 'winner-mode)
      (winner-mode 1))

;; Don't blink the cursor
(blink-cursor-mode nil)

(defalias 'yes-or-no-p 'y-or-n-p)

;; Package zygospore
(global-set-key (kbd "C-x 1") 'zygospore-toggle-delete-other-windows)

;; Whitespace
(require 'whitespace)
(setq whitespace-line-column 80) ;; limit line length
(setq whitespace-style '(face lines-tail))

(set-face-attribute 'whitespace-line nil
                    :background "#6F6F6F"
                    :foreground "red"
                                        :weight 'normal)
(global-set-key (kbd "C-c w") 'whitespace-mode)


;; Enable narrowing to region permanently
(put 'narrow-to-region 'disabled nil)

;; German characters
(global-set-key [225] (lambda () (interactive) (ucs-insert #x00e4))) ; ä
(global-set-key [233] (lambda () (interactive) (ucs-insert #x00eb))) ; ë
(global-set-key [243] (lambda () (interactive) (ucs-insert #x00f6))) ; ö
(global-set-key [250] (lambda () (interactive) (ucs-insert #x00fc))) ; ü

(global-set-key [193] (lambda () (interactive) (ucs-insert #x00c4))) ; Ä
(global-set-key [201] (lambda () (interactive) (ucs-insert #x00cb))) ; Ë
(global-set-key [211] (lambda () (interactive) (ucs-insert #x00d6))) ; Ö
(global-set-key [218] (lambda () (interactive) (ucs-insert #x00dc))) ; Ü

(global-set-key [164] (lambda () (interactive) (ucs-insert #x20ac))) ; €

;; Intercept Alt-Tab
;(w32-register-hot-key [M-tab])

;; move by paragraph
(global-set-key "\M-p" 'backward-paragraph)
(global-set-key "\M-n" 'forward-paragraph)

(global-set-key (kbd "C-<down>") 'scroll-up-one-line)
(global-set-key (kbd "C-<up>") 'scroll-down-one-line)

;; use mouse scroll to zoom in/out
(global-set-key [C-mouse-4] 'text-scale-increase)
(global-set-key [C-mouse-5] 'text-scale-decrease)
; for Windows
(global-set-key (kbd "<C-wheel-up>")  'text-scale-increase)
(global-set-key (kbd "<C-wheel-down>") 'text-scale-decrease)

;; make cmd meta key
;(setq x-super-keysym 'meta)
;(setq w32-pass-lwindow-to-system nil)
;(setq w32-lwindow-modifier 'super) ; Left Windows key

;; expand region
(require 'expand-region)
(global-set-key (kbd "C-=") 'er/expand-region)

;; make dedicated windows / freeze buffer
(defadvice pop-to-buffer (before cancel-other-window first)
  (ad-set-arg 1 nil))

(ad-activate 'pop-to-buffer)

;; Toggle window dedication
(defun toggle-window-dedicated ()
  "Toggle whether the current active window is dedicated or not"
  (interactive)
  (message
   (if (let (window (get-buffer-window (current-buffer)))
         (set-window-dedicated-p window
                                 (not (window-dedicated-p window))))
       "Window '%s' is dedicated"
     "Window '%s' is normal")
   (current-buffer)))

(global-set-key [kp-enter] 'toggle-window-dedicated)

(require 'framemove)
(require 'buffer-move)
(windmove-default-keybindings)
(setq framemove-hook-into-windmove t)
;; Make windmove work in org-mode:
(add-hook 'org-shiftup-final-hook 'windmove-up)
(add-hook 'org-shiftleft-final-hook 'windmove-left)
(add-hook 'org-shiftdown-final-hook 'windmove-down)
(add-hook 'org-shiftright-final-hook 'windmove-right)

(define-derived-mode dirtree-mode tree-mode "Dir-Tree"
  "A mode to display tree of directory"
  (tree-widget-set-theme "ascii")) ; does not work...

(custom-set-variables 
'(neo-theme 'ascii))


(defcustom neo-theme
  '(coffee-mode python-mode slim-mode haml-mode yaml-mode)
  "Modes for which auto-indenting is suppressed."
  :type 'list)

(global-set-key (kbd "C-c t") 'sr-speedbar-toggle)

;; Abreviations for emails
  (setq abbrev-file-name
  (concat user-emacs-directory "abbrev_defs.el"))
  (if (file-exists-p abbrev-file-name)
      (quietly-read-abbrev-file))
  ;(add-hook 'text-mode-hook 'abbrev-mode)
  (add-to-list 'auto-mode-alist '("\\.outlook\\'" . text-mode))
  (defvar auto-minor-mode-alist ()
    "Alist of filename patterns vs corresponding minor mode functions, see `auto-mode-alist'
  All elements of this alist are checked, meaning you can enable multiple minor modes for the same regexp.")
  (defun enable-minor-mode-based-on-extension ()
    "Check file name against auto-minor-mode-alist to enable minor modes.
  The checking happens for all pairs in auto-minor-mode-alist"
    (when buffer-file-name
      (let ((name buffer-file-name)
            (remote-id (file-remote-p buffer-file-name))
            (alist auto-minor-mode-alist))
        ;; Remove backup-suffixes from file name.
        (setq name (file-name-sans-versions name))
        ;; Remove remote file name identification.
        (when (and (stringp remote-id)
                   (string-match-p (regexp-quote remote-id) name))
          (setq name (substring name (match-end 0))))
        (while (and alist (caar alist) (cdar alist))
          (if (string-match (caar alist) name)
              (funcall (cdar alist) 1))
          (setq alist (cdr alist))))))

(add-hook 'find-file-hook 'enable-minor-mode-based-on-extension)
(add-to-list 'auto-minor-mode-alist '("\\.outlook\\'" . flyspell-mode))
(add-to-list 'auto-minor-mode-alist '("\\.outlook\\'" . abbrev-mode))

;(require 'ibuffer)
;(global-set-key (kbd "C-x C-b") 'ibuffer-other-window) ;'ibuffer)
;(autoload 'ibuffer "ibuffer" "List buffers." t)
;(setq ibuffer-default-sorting-mode 'major-mode)

;; Use spell check by default
  (setq-default ispell-program-name "C:/Tools/Aspell/bin/aspell.exe")
  (setq text-mode-hook '(lambda() (flyspell-mode t) ))
  (setq prog-mode-hook '(lambda() (flyspell-prog-mode) ))
;; switch between english and german
  (defun fd-switch-dictionary()
    (interactive)
    (let* ((dic ispell-current-dictionary)
           (change (if (string= dic "deutsch8") "english" "deutsch8")))
      (ispell-change-dictionary change)
      (message "Dictionary switched from %s to %s" dic change)
      ))

  (global-set-key (kbd "<f8>")   'fd-switch-dictionary)  
(eval-after-load "flyspell"
  '(define-key flyspell-mode-map (kbd "C-;") nil)) ; use for iedit

(require 'multiple-cursors)
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C-S-c a") 'mc/edit-beginnings-of-lines)
(global-set-key (kbd "C-S-c e") 'mc/edit-ends-of-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

(setq mc/cmds-to-run-for-all mc--default-cmds-to-run-for-all)
(add-to-list 'mc/cmds-to-run-for-all 'org-self-insert-command)

(defun show-file-name ()
  "Show the full path file name in the minibuffer."
  (interactive)
  (message (buffer-file-name)))
(global-set-key [C-f1] 'show-file-name)

(defun explorer ()
  "Launch the windows explorer in the current directory and selects current file"
  (interactive)
  (w32-shell-execute
   "open"
   "explorer"
   (concat "/e,/select," (convert-standard-filename buffer-file-name))))
(global-set-key [f12] 'explorer)

;;(setq fill-column 70)
(setq-default default-tab-width 4)

;; Ignore case when searching
(setq case-fold-search t)

;; Backup files in temp directory
(setq backup-directory-alist
          `((".*" . ,temporary-file-directory)))

(setq auto-save-file-name-transforms
          `((".*" ,temporary-file-directory t)))

;; Use windows recycle bin when deleting files
(setq delete-by-moving-to-trash t)

;; Enable upper-/lower-case commands
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

;; GROUP: Editing -> Editing Basics

(setq global-mark-ring-max 5000         ; increase mark ring to contains 5000 entries
      mark-ring-max 5000                ; increase kill ring to contains 5000 entries
      mode-require-final-newline t      ; add a newline to end of file
      tab-width 4                       ; default to 4 visible spaces to display a tab
      )

(add-hook 'sh-mode-hook (lambda ()
                          (setq tab-width 4)))

(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-language-environment "UTF-8")
(prefer-coding-system 'utf-8)

(setq-default indent-tabs-mode nil)
(delete-selection-mode)
(global-set-key (kbd "RET") 'newline-and-indent)

;; GROUP: Editing -> Killing
(setq kill-ring-max 5000 ; increase kill-ring capacity
      kill-whole-line t  ; if NIL, kill whole line and move the next line up
      )

;; show whitespace in diff-mode
(add-hook 'diff-mode-hook (lambda ()
                            (setq-local whitespace-style
                                        '(face
                                          tabs
                                          tab-mark
                                          spaces
                                          space-mark
                                          trailing
                                          indentation::space
                                          indentation::tab
                                          newline
                                          newline-mark))
                            (whitespace-mode 1)))

;; Package: volatile-highlights
;; GROUP: Editing -> Volatile Highlights
(require 'volatile-highlights)
(volatile-highlights-mode t)

;; Package: clean-aindent-mode
;; GROUP: Editing -> Indent -> Clean Aindent
(require 'clean-aindent-mode)
(add-hook 'prog-mode-hook 'clean-aindent-mode)


;; PACKAGE: dtrt-indent
(require 'dtrt-indent)
(dtrt-indent-mode 1)
(setq dtrt-indent-verbosity 0)

;; PACKAGE: ws-butler
(require 'ws-butler)
(add-hook 'c-mode-common-hook 'ws-butler-mode)
(add-hook 'text-mode 'ws-butler-mode)
(add-hook 'fundamental-mode 'ws-butler-mode)

;; Package: undo-tree
;; GROUP: Editing -> Undo -> Undo Tree
(require 'undo-tree)
(global-undo-tree-mode)

;; Package: yasnippet
;; GROUP: Editing -> Yasnippet
(require 'yasnippet)
(yas-global-mode 1)

;; PACKAGE: smartparens
(require 'smartparens-config)
(setq sp-base-key-bindings 'paredit)
(setq sp-autoskip-closing-pair 'always)
(setq sp-hybrid-kill-entire-symbol nil)
(sp-use-paredit-bindings)

(show-smartparens-global-mode +1)
(smartparens-global-mode 1)

;; PACKAGE: comment-dwim-2
(global-set-key (kbd "M-;") 'comment-dwim-2)

;; Jump to end of snippet definition
(define-key yas-keymap (kbd "<return>") 'yas/exit-all-snippets)

;; Inter-field navigation
(defun yas/goto-end-of-active-field ()
  (interactive)
  (let* ((snippet (car (yas--snippets-at-point)))
         (position (yas--field-end (yas--snippet-active-field snippet))))
    (if (= (point) position)
        (move-end-of-line 1)
      (goto-char position))))

(defun yas/goto-start-of-active-field ()
  (interactive)
  (let* ((snippet (car (yas--snippets-at-point)))
         (position (yas--field-start (yas--snippet-active-field snippet))))
    (if (= (point) position)
        (move-beginning-of-line 1)
      (goto-char position))))

(define-key yas-keymap (kbd "C-e") 'yas/goto-end-of-active-field)
(define-key yas-keymap (kbd "C-a") 'yas/goto-start-of-active-field)
;; (define-key yas-minor-mode-map [(tab)] nil)
;; (define-key yas-minor-mode-map (kbd "TAB") nil)
;; (define-key yas-minor-mode-map (kbd "C-<tab>") 'yas-expand)
;; No dropdowns please, yas
(setq yas-prompt-functions '(yas/ido-prompt yas/completing-prompt))

;; No need to be so verbose
(setq yas-verbosity 1)

;; Wrap around region
(setq yas-wrap-around-region t)

(add-hook 'term-mode-hook (lambda() (setq yas-dont-activate t)))

;; PACKAGE: anzu
;; GROUP: Editing -> Matching -> Isearch -> Anzu
(require 'anzu)
(global-anzu-mode)
(global-set-key (kbd "M-%") 'anzu-query-replace)
(global-set-key (kbd "C-M-%") 'anzu-query-replace-regexp)

;; PACKAGE: iedit
(setq iedit-toggle-key-default nil)
(require 'iedit)
(global-set-key (kbd "C-;") 'iedit-mode)

;; PACKAGE: duplicate-thing
(require 'duplicate-thing)
(global-set-key (kbd "C-c d") 'duplicate-thing)

;; Customized functions
(defun prelude-move-beginning-of-line (arg)
  "Move point back to indentation of beginning of line.

Move point to the first non-whitespace character on this line.
If point is already there, move to the beginning of the line.
Effectively toggle between the first non-whitespace character and
the beginning of the line.

If ARG is not nil or 1, move forward ARG - 1 lines first. If
point reaches the beginning or end of the buffer, stop there."
  (interactive "^p")
  (setq arg (or arg 1))

  ;; Move lines first
  (when (/= arg 1)
    (let ((line-move-visual nil))
      (forward-line (1- arg))))

  (let ((orig-point (point)))
    (back-to-indentation)
    (when (= orig-point (point))
      (move-beginning-of-line 1))))

(global-set-key (kbd "C-a") 'prelude-move-beginning-of-line)

(defadvice kill-ring-save (before slick-copy activate compile)
  "When called interactively with no active region, copy a single
line instead."
  (interactive
   (if mark-active (list (region-beginning) (region-end))
     (message "Copied line")
     (list (line-beginning-position)
           (line-beginning-position 2)))))

(defadvice kill-region (before slick-cut activate compile)
  "When called interactively with no active region, kill a single
  line instead."
  (interactive
   (if mark-active (list (region-beginning) (region-end))
     (list (line-beginning-position)
           (line-beginning-position 2)))))

;; kill a line, including whitespace characters until next non-whiepsace character
;; of next line
(defadvice kill-line (before check-position activate)
  (if (member major-mode
              '(emacs-lisp-mode scheme-mode lisp-mode
                                c-mode c++-mode objc-mode
                                latex-mode plain-tex-mode))
      (if (and (eolp) (not (bolp)))
          (progn (forward-char 1)
                 (just-one-space 0)
                 (backward-char 1)))))

;; taken from prelude-editor.el
;; automatically indenting yanked text if in programming-modes
(defvar yank-indent-modes
  '(LaTeX-mode TeX-mode)
  "Modes in which to indent regions that are yanked (or yank-popped).
Only modes that don't derive from `prog-mode' should be listed here.")

(defvar yank-indent-blacklisted-modes
  '(python-mode slim-mode haml-mode)
  "Modes for which auto-indenting is suppressed.")

(defvar yank-advised-indent-threshold 1000
  "Threshold (# chars) over which indentation does not automatically occur.")

(defun yank-advised-indent-function (beg end)
  "Do indentation, as long as the region isn't too large."
  (if (<= (- end beg) yank-advised-indent-threshold)
      (indent-region beg end nil)))

(defadvice yank (after yank-indent activate)
  "If current mode is one of 'yank-indent-modes,
indent yanked text (with prefix arg don't indent)."
  (if (and (not (ad-get-arg 0))
           (not (member major-mode yank-indent-blacklisted-modes))
           (or (derived-mode-p 'prog-mode)
               (member major-mode yank-indent-modes)))
      (let ((transient-mark-mode nil))
        (yank-advised-indent-function (region-beginning) (region-end)))))

(defadvice yank-pop (after yank-pop-indent activate)
  "If current mode is one of `yank-indent-modes',
indent yanked text (with prefix arg don't indent)."
  (when (and (not (ad-get-arg 0))
             (not (member major-mode yank-indent-blacklisted-modes))
             (or (derived-mode-p 'prog-mode)
                 (member major-mode yank-indent-modes)))
    (let ((transient-mark-mode nil))
      (yank-advised-indent-function (region-beginning) (region-end)))))

;; prelude-core.el
(defun indent-buffer ()
  "Indent the currently visited buffer."
  (interactive)
  (indent-region (point-min) (point-max)))

;; prelude-editing.el
(defcustom prelude-indent-sensitive-modes
  '(coffee-mode python-mode slim-mode haml-mode yaml-mode)
  "Modes for which auto-indenting is suppressed."
  :type 'list)

(defun indent-region-or-buffer ()
  "Indent a region if selected, otherwise the whole buffer."
  (interactive)
  (unless (member major-mode prelude-indent-sensitive-modes)
    (save-excursion
      (if (region-active-p)
          (progn
            (indent-region (region-beginning) (region-end))
            (message "Indented selected region."))
        (progn
          (indent-buffer)
          (message "Indented buffer.")))
      (whitespace-cleanup))))

(global-set-key (kbd "C-c i") 'indent-region-or-buffer)

;; add duplicate line function from Prelude
;; taken from prelude-core.el
(defun prelude-get-positions-of-line-or-region ()
  "Return positions (beg . end) of the current line
or region."
  (let (beg end)
    (if (and mark-active (> (point) (mark)))
        (exchange-point-and-mark))
    (setq beg (line-beginning-position))
    (if mark-active
        (exchange-point-and-mark))
    (setq end (line-end-position))
    (cons beg end)))

;; smart openline
(defun prelude-smart-open-line (arg)
  "Insert an empty line after the current line.
Position the cursor at its beginning, according to the current mode.
With a prefix ARG open line above the current line."
  (interactive "P")
  (if arg
      (prelude-smart-open-line-above)
    (progn
      (move-end-of-line nil)
      (newline-and-indent))))

(defun prelude-smart-open-line-above ()
  "Insert an empty line above the current line.
Position the cursor at it's beginning, according to the current mode."
  (interactive)
  (move-beginning-of-line nil)
  (newline-and-indent)
  (forward-line -1)
  (indent-according-to-mode))

(global-set-key (kbd "M-o") 'prelude-smart-open-line)
(global-set-key (kbd "M-o") 'open-line)

(add-hook 'org-mode-hook
            (lambda ()
              (org-indent-mode t))
            t)
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((emacs-lisp . t)
     (ditaa . t)))
  (setq org-src-fontify-natively t)
  (setq org-src-tab-acts-natively t)
(setq org-export-html-postamble nil)
  ;; For keeping buffers up-to-date with tangled files
  ;; (global-auto-revert-mode t)
  (defun revert-all-buffers ()
  "Refreshes all open buffers from their respective files"
  (interactive)
  (let* ((list (buffer-list))
  (buffer (car list)))
  (while buffer
  (when (and (buffer-file-name buffer)
  (not (buffer-modified-p buffer)))
  (set-buffer buffer)
  (revert-buffer t t t))
  (setq list (cdr list))
  (setq buffer (car list))))
  (message "Refreshed open files"))

  ;; For tangling code automatically when saving org-files
  (defun tangle-on-save ()
  "Extract source code from org-files upon saving."
  (message "Tangling sources...")
  (org-babel-tangle)
  (revert-all-buffers))
  (add-hook 'org-mode-hook
  (lambda ()
  (add-hook 'after-save-hook
  'tangle-on-save 'make-it-local)))

  (global-set-key (kbd "M-<down>") 'org-table-move-row-down)
  (global-set-key (kbd "M-<up>") 'org-table-move-row-up)

(require 'company)
(add-hook 'after-init-hook 'global-company-mode)
(require 'company-keywords)
(add-to-list 'company-backends 'company-keywords)
;; (setq company-backends (delete 'company-semantic company-backends))

;; Package: yasnippet
(require 'yasnippet)
(yas-global-mode 1)

;; Project customizations
(defvar my-project-dir "C:/Users/szufnarowski/Desktop/Workspace/_PROJECTS/")
(setq default-directory my-project-dir)
(setq enable-local-eval t)
(put 'default-directory 'safe-local-variable #'stringp)

;; Source-Code-Pro font
(defun use-source-code-pro-font ()
  "Switch the current buffer to a source code pro font."
  (when (member "Source Code Pro" (font-family-list))
        (face-remap-add-relative 'default
                                                         '(:family "Source Code Pro"))))
; :height 1.2))))

(add-hook 'prog-mode-hook 'use-source-code-pro-font)

;; Numbering lines/columns
(require 'linum-relative)
(add-hook 'prog-mode-hook 'linum-mode)
(column-number-mode 1)
(set-face-attribute 'linum nil :height 100) ; linum should not depend on default font

;; show unncessary whitespace that can mess up your diff
(add-hook 'prog-mode-hook (lambda () (interactive) (setq show-trailing-whitespace 1)))

;; use space to indent by default
(setq-default indent-tabs-mode nil)

;; set appearance of a tab that is represented by 4 spaces
(setq-default tab-width 4)

;; Compilation
(global-set-key (kbd "<f5>") (lambda ()
                               (interactive)
                               (setq-local compilation-read-command nil)
                               (call-interactively 'compile)))

;; Package: clean-aindent-mode
(require 'clean-aindent-mode)
(add-hook 'prog-mode-hook 'clean-aindent-mode)

;; Package: dtrt-indent
(require 'dtrt-indent)
(dtrt-indent-mode 1)

;; Package: ws-butler
(require 'ws-butler)
(add-hook 'prog-mode-hook 'ws-butler-mode)

;; iEdit mode
(define-key global-map (kbd "C-c ;") 'iedit-mode)

;; Package: smartparens
(require 'smartparens-config)
(setq sp-base-key-bindings 'paredit)
(setq sp-autoskip-closing-pair 'always)
(setq sp-hybrid-kill-entire-symbol nil)
(sp-use-paredit-bindings)

(show-smartparens-global-mode +1)
(smartparens-global-mode 1)

(require 'helm-config)
(require 'helm-grep)

;; The default "C-x c" is quite close to "C-x C-c", which quits Emacs.
;; Changed to "C-c h". Note: We must set "C-c h" globally, because we
;; cannot change `helm-command-prefix-key' once `helm-config' is loaded.
(global-set-key (kbd "C-c h") 'helm-command-prefix)
(global-unset-key (kbd "C-x c"))

(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebihnd tab to do persistent action
(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB works in terminal
(define-key helm-map (kbd "C-z")  'helm-select-action) ; list actions using C-z

(define-key helm-grep-mode-map (kbd "<return>")  'helm-grep-mode-jump-other-window)
(define-key helm-grep-mode-map (kbd "n")  'helm-grep-mode-jump-other-window-forward)
(define-key helm-grep-mode-map (kbd "p")  'helm-grep-mode-jump-other-window-backward)

(when (executable-find "curl")
  (setq helm-google-suggest-use-curl-p t))

(setq
 helm-scroll-amount 4 ; scroll 4 lines other window using M-<next>/M-<prior>
 helm-quick-update t ; do not display invisible candidates
 helm-ff-search-library-in-sexp t ; search for library in `require' and `declare-function' sexp.
 helm-split-window-in-side-p t ;; open helm buffer inside current window, not occupy whole other window
 helm-candidate-number-limit 500 ; limit the number of displayed canidates
 helm-ff-file-name-history-use-recentf t
 helm-move-to-line-cycle-in-source t ; move to end or beginning of source when reaching top or bottom of source.
 helm-buffers-fuzzy-matching t          ; fuzzy matching buffer names when non-nil
                                        ; useful in helm-mini that lists buffers

 )

(add-to-list 'helm-sources-using-default-as-input 'helm-source-man-pages)

(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)
(global-set-key (kbd "C-x b") 'helm-mini)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "C-h SPC") 'helm-all-mark-rings)
(global-set-key (kbd "C-c h o") 'helm-occur)

(global-set-key (kbd "C-c h C-c w") 'helm-wikipedia-suggest)

(global-set-key (kbd "C-c h x") 'helm-register)
;; (global-set-key (kbd "C-x r j") 'jump-to-register)

(define-key 'help-command (kbd "C-f") 'helm-apropos)
(define-key 'help-command (kbd "r") 'helm-info-emacs)
(define-key 'help-command (kbd "C-l") 'helm-locate-library)

;; use helm to list eshell history
(add-hook 'eshell-mode-hook
          #'(lambda ()
              (define-key eshell-mode-map (kbd "M-l")  'helm-eshell-history)))

;;; Save current position to mark ring
(add-hook 'helm-goto-line-before-hook 'helm-save-current-pos-to-mark-ring)

;; show minibuffer history with Helm
(define-key minibuffer-local-map (kbd "M-p") 'helm-minibuffer-history)
(define-key minibuffer-local-map (kbd "M-n") 'helm-minibuffer-history)

(define-key global-map [remap find-tag] 'helm-etags-select)

(define-key global-map [remap list-buffers] 'helm-buffers-list)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PACKAGE: helm-swoop                ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Locate the helm-swoop folder to your path
(require 'helm-swoop)

;; Change the keybinds to whatever you like :)
(global-set-key (kbd "C-c h o") 'helm-swoop)
(global-set-key (kbd "C-c s") 'helm-multi-swoop-all)

;; When doing isearch, hand the word over to helm-swoop
(define-key isearch-mode-map (kbd "M-i") 'helm-swoop-from-isearch)

;; From helm-swoop to helm-multi-swoop-all
(define-key helm-swoop-map (kbd "M-i") 'helm-multi-swoop-all-from-helm-swoop)

;; Save buffer when helm-multi-swoop-edit complete
(setq helm-multi-swoop-edit-save t)

;; If this value is t, split window inside the current window
(setq helm-swoop-split-with-multiple-windows t)

;; Split direcion. 'split-window-vertically or 'split-window-horizontally
(setq helm-swoop-split-direction 'split-window-vertically)

;; If nil, you can slightly boost invoke speed in exchange for text color
(setq helm-swoop-speed-or-color t)

(helm-mode 1)

;; This variables must be set before loading helm-gtags
(setq helm-gtags-prefix-key "\C-cg")

(require 'helm-gtags)

(setq
 helm-gtags-ignore-case t
 helm-gtags-auto-update t
 helm-gtags-use-input-at-cursor t
 helm-gtags-pulse-at-cursor t
 helm-gtags-prefix-key "\C-cg"
 helm-gtags-suggested-key-mapping t
 )

;; Enable helm-gtags-mode in Dired so you can jump to any tag
;; when navigate project tree with Dired
(add-hook 'dired-mode-hook 'helm-gtags-mode)

;; Enable helm-gtags-mode in Eshell for the same reason as above
(add-hook 'eshell-mode-hook 'helm-gtags-mode)

;; Enable helm-gtags-mode in languages that GNU Global supports
(add-hook 'c-mode-hook 'helm-gtags-mode)
(add-hook 'c++-mode-hook 'helm-gtags-mode)
(add-hook 'java-mode-hook 'helm-gtags-mode)
(add-hook 'asm-mode-hook 'helm-gtags-mode)

;; key bindings
(define-key helm-gtags-mode-map (kbd "C-c g a") 'helm-gtags-tags-in-this-function)
(define-key helm-gtags-mode-map (kbd "C-j") 'helm-gtags-select)
(define-key helm-gtags-mode-map (kbd "M-.") 'helm-gtags-dwim)
(define-key helm-gtags-mode-map (kbd "M-,") 'helm-gtags-pop-stack)
(define-key helm-gtags-mode-map (kbd "C-c <") 'helm-gtags-previous-history)
(define-key helm-gtags-mode-map (kbd "C-c >") 'helm-gtags-next-history)
(define-key helm-gtags-mode-map (kbd "C-c g s") 'helm-gtags-find-symbol)
(define-key helm-gtags-mode-map (kbd "C-c g t") 'helm-gtags-find-tag)
(define-key helm-gtags-mode-map (kbd "C-c g r") 'helm-gtags-find-rtag)
(define-key helm-gtags-mode-map (kbd "C-c g f") 'helm-gtags-find-file)
(define-key helm-gtags-mode-map (kbd "C-c g d") 'helm-gtags-visit-rootdir)

;; Redefine Helm-Gtags functions in order to have support for project-specific GTAGS
(defun helm-gtags--find-tag-simple ()
  (or (locate-dominating-file default-directory "GTAGS")
      (getenv "GTAGSDBPATH")
      (if (not (yes-or-no-p "File GTAGS not found. Run 'gtags'? "))
          (user-error "Abort")
        (let* ((tagroot (read-directory-name "Root Directory: "))
               (label (helm-gtags--read-gtagslabel))
               (default-directory tagroot))
          (message "gtags is generating tags....")
          (unless (zerop (process-file "gtags" nil nil nil
                                       "-q" (helm-gtags--label-option label)))
            (error "Faild: 'gtags -q'"))
          tagroot))))

(defun helm-gtags-dwim ()
  "Find by context. Here is
- on include statement then jump to included file
- on symbol definition then jump to its references
- on reference point then jump to its definition."
  (interactive)
  (let ((dd (expand-file-name default-directory)))
         (setenv "GTAGSROOT" (directory-file-name dd))
         (setenv "GTAGSLIBPATH" (concat dd ".ext"))
         (setenv "GTAGSDBPATH" (concat dd ".loc")))
  (let ((line (helm-current-line-contents)))
    (if (string-match helm-gtags--include-regexp line)
        (let ((helm-gtags-use-input-at-cursor t))
          (helm-gtags-find-files (match-string-no-properties 1 line)))
      (if (thing-at-point 'symbol)
          (helm-gtags-find-tag-from-here)
        (call-interactively 'helm-gtags-find-tag)))))

;; CEDET completion
(set-default 'semantic-case-fold t)

;; Load this to let Cedet parse STL libraries (important GCC defines)
(require 'semantic)
(require 'semantic/bovine/c)

(global-semanticdb-minor-mode 1)
(global-semantic-idle-scheduler-mode 1)
(global-semantic-idle-summary-mode 1)
(global-semantic-stickyfunc-mode 1)
(setq-local eldoc-documentation-function #'ggtags-eldoc-function)
(set-default 'semantic-case-fold t)

(semantic-mode 1)

(defun alexott/cedet-hook ()
  (local-set-key "\C-c\C-j" 'semantic-ia-fast-jump)
  (local-set-key "\C-c\C-s" 'semantic-ia-show-summary))


;; Enable EDE only in C/C++
(require 'ede)
(global-ede-mode)

(require 'cc-mode)
(add-hook 'c-mode-common-hook 'alexott/cedet-hook)
;; Edit h-files in C++ mode
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))

;; Delete as much whitespace as possible
(add-hook 'c-mode-common-hook (lambda ()
 (c-toggle-hungry-state 1)))

(add-hook 'c-mode-common-hook 'flycheck-mode)

(add-hook 'c++-mode-hook 'alexott/cedet-hook)

;; Available C style:
;; “gnu”: The default style for GNU projects
;; “k&r”: What Kernighan and Ritchie, the authors of C used in their book
;; “bsd”: What BSD developers use, aka “Allman style” after Eric Allman.
;; “whitesmith”: Popularized by the examples that came with Whitesmiths C, an early commercial C compiler.
;; “stroustrup”: What Stroustrup, the author of C++ used in his book
;; “ellemtel”: Popular C++ coding standards as defined by “Programming in C++, Rules and Recommendations,” Erik Nyquist and Mats Henricson, Ellemtel
;; “linux”: What the Linux developers use for kernel development
;; “python”: What Python developers use for extension modules
;; “java”: The default style for java-mode (see below)
;; “user”: When you want to define your own style
(setq
 c-default-style "linux" ;; set style to "linux"
 )

(global-set-key (kbd "RET") 'newline-and-indent)  ; automatically indent when press RET

(define-key c-mode-map  [(shift tab)] 'company-complete)
(define-key c++-mode-map  [(shift tab)] 'company-complete)

(add-hook 'c++-mode-hook
(lambda ()
(hack-local-variables)
  (let ((dd (expand-file-name default-directory)))
           (setenv "GTAGSROOT" (directory-file-name dd))
           (setenv "GTAGSLIBPATH" (concat dd ".ext"))
           (setenv "GTAGSDBPATH" (concat dd ".loc")))))

(require 'function-args)
(fa-config-default)
(define-key c-mode-map  [(ctrl tab)] 'moo-complete)
(define-key c++-mode-map  [(ctrl tab)] 'moo-complete)

;; company-c-headers
  ;; (defvar cpp-system-includes 
  ;;   (let ((file (concat my-project-dir ".global-includes")))
  ;;     (if (file-exists-p file)
  ;;     (split-string
  ;;                                ;; Output of echo "" | g++ -v -x c++ -E -
  ;;                                ;; Use absolute paths
  ;;      (slurp file))
  ;;     nil)))
  ;;   ;; Local includes (below in projectile per project)
  ;;   (defvar cpp-local-includes (split-string
  ;;                               "
  ;;   .
  ;;   inc
  ;;   .ext
  ;;   "
  ;;                               ))

    (require 'company-c-headers)
    (add-to-list 'company-backends 'company-c-headers)
    (setq company-c-headers-path-system nil company-c-headers-path-user nil)
    (semantic-reset-system-include 'c++-mode)
    (semantic-gcc-setup)

    ;; Global includes
    ;; (mapc (lambda (x)
    ;;           (add-to-list 'company-c-headers-path-system x)
    ;;           (semantic-add-system-include x 'c++-mode))
    ;;         cpp-system-includes)

    
    (add-hook 'c++-mode-hook
    (lambda ()
    (hack-local-variables)
    (let ((local (concat default-directory ".local-includes"))
          (global (concat default-directory ".global-includes")))
    (when (file-exists-p local)
    (mapc (lambda (x) (add-to-list 'company-c-headers-path-user x))
          (split-string (slurp local))))
    (when (file-exists-p global)
      (mapc (lambda (x) (add-to-list 'company-c-headers-path-system x))
            (split-string (slurp global))))))

(setq company-backends '((company-c-headers company-dabbrev-code company-dabbrev company-keywords company-gtags))))

;; Also add clang includes for flycheck usage
;;(add-hook 'c++-mode-hook
;;          (lambda () (setq flycheck-clang-include-path
;;                           (list (expand-file-name "~/local/include/")))))

    ;; (defvar cpp-local-includes (list "." "inc"))
    ;; (mapcar (lambda (x) (add-to-list 'company-c-headers-path-user x)) cpp-local-includes)
    ;; For Cedet
    ;; Project settings for CEDET
    (load (concat my-project-dir "projects.el"))

(add-hook 'c-mode-common-hook 'hs-minor-mode)

;; Member functions
(require 'member-functions)
;; Make to body of mf--infer-c-filename (buffer-name (ido-switch-buffer))
;; Comment out (find-file-noselect [header|c-file]) in expand-member-functions
(setq mf--source-file-extension "cpp")
(add-hook 'c-mode-common-hook
                  (lambda ()
                        (local-set-key "\C-cm" #'expand-member-functions)))

;; setup GDB
(setq
 ;; use gdb-many-windows by default
 gdb-many-windows t

 ;; Non-nil means display source file containing the main routine at startup
 gdb-show-main t
 )

(require 'projectile)
(projectile-global-mode)
(setq projectile-completion-system 'helm)
(helm-projectile-on)
(setq projectile-indexing-method 'alien)
(setq projectile-enable-caching t)

(custom-set-variables 
'(

projectile-project-root-files-bottom-up 
'(".projectile" ; projectile project marker
    ".git"        ; Git VCS root dir
    ".dir-locals.el" ; ADDED THIS TO DEFAULT SETTINGS
    ".hg"         ; Mercurial VCS root dir
    ".fslckout"   ; Fossil VCS root dir
    ".bzr"        ; Bazaar VCS root dir
    "_darcs"      ; Darcs VCS root dir
    )
)
)

(add-to-list 'projectile-other-file-alist '("org" . ("h" "cpp" "c" "py")))

(autoload 'markdown-mode "markdown-mode"
   "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

(autoload 'orgtbl-to-markdown
       "orgtbl-to-markdown" "Convert org-mode tables to markdown format" t)

;; Specify the fringe width for windows
;(require 'fringe)
;(fringe-mode 10)
;(setq overflow-newline-into-fringe t)
;(setq truncate-lines t)
;(setq truncate-partial-width-windows t)

;; Highlight current line
;(require 'highlight-current-line)
;(global-hl-line-mode t)
;(setq highlight-current-line-globally t)
;(setq highlight-current-line-high-faces nil)
;(setq highlight-current-line-whole-line nil)
;(setq hl-line-face (quote highlight))

;; Truncate long lines visually
;(global-visual-line-mode)

;; Highlight parentheses when the cursor is next to them
(require 'paren)
;(show-paren-mode t)

;; Use mouse wheel even in plain terminal
;(require 'mwheel)
;(mouse-wheel-mode t)

;(require 'pos-tip)
;(setq ac-quick-help-prefer-x t)

;; Indentation
;(require 'highlight-indentation)
;(set-face-background 'highlight-indentation-face "#6F6F6F")
;(set-face-background 'highlight-indentation-current-column-face "#6F6F6F")

;; Skip trailing whitespace on save (leave one)
;(add-hook 'prog-mode-hook
;                 (lambda ()
;                       (custom-set-variables
;                        '(require-final-newline t))
;                       (add-to-list 'write-file-functions
;                                                'delete-trailing-whitespace)))
