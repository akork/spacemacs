;; minor (bound-and-true-p yas-minor-mode)
;; major (derived-mode-p 'json-mode 'emacs-lisp-)

;; frame title settings
(add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))
(add-to-list 'default-frame-alist '(ns-appearance . dark))
;; (setq ns-use-proxy-icon nil)

;; (setq frame-title-format
;;       '((:eval (if (buffer-file-name)
;;                    (concat (abbreviate-file-name (buffer-file-name)) "; %m")
;;                  "%b; %m"))))

;; (defun set-frame-title ()
;;   (let ((kill-ring (replace-regexp-in-string "\n" "___\\\\n___" (substring-no-properties (car kill-ring))))
;;         (system-clipboard (evil-get-register ?+)))
;;     (setq frame-title-format
;;           (concat kill-ring ";   " system-clipboard))))

;; (setq interval 1)

;; (defun run-every-ten-seconds ()
;;   ;; (message (current-time-string))
;;   (set-frame-title))

;; (defun start-timer ()
;;   (setq timer
;;         (run-at-time (current-time)  interval
;;                      'run-every-ten-seconds)))
;; (run-at-time
;;  (time-add (current-time) (seconds-to-time interval))
;;  interval 'run-every-ten-seconds)


;; general settings
(setq evil-move-beyond-eol t)
(setq scroll-margin 15)

;; some global strings
(setq dot-path "/Users/Aleksey/Dropbox/Settings/")

;; separate clipboards
(setq save-interprogram-paste-before-kill t)
(setq select-enable-clipboard nil)

(define-key evil-visual-state-map (kbd "s-c") (kbd "\"+y"))
(define-key evil-insert-state-map  (kbd "s-c") (kbd "\"+y"))
(define-key evil-insert-state-map  (kbd "s-x") (kbd "\"+d"))
(define-key evil-normal-state-map  (kbd "s-v") (kbd "\"+p"))
(define-key evil-insert-state-map  (kbd "s-v") (kbd "+"))
(define-key evil-ex-completion-map (kbd "s-v") (kbd "+"))
(define-key evil-ex-search-keymap  (kbd "s-v") (kbd "+"))

;; functions
(defadvice compile (around split-horizontally activate)
  (let ((split-width-threshold 0)
        (split-height-threshold nil))
    ad-do-it))

(setq split-height-threshold 0)
(setq split-width-threshold nil)

(defun ak/yank-pop-forwards (arg)
  (interactive "p")
  (yank-pop (- arg)))

(defun ak/half-page-down ()
  (interactive)
  (next-line 20))

(defun ak/half-page-up ()
  (interactive)
  (previous-line 20))

(global-set-key "\M-Y" 'ak/yank-pop-forwards)
(global-set-key (kbd "<next>") 'ak/half-page-down)
(global-set-key (kbd "<prior>") 'ak/half-page-up)

(defun latex-build-cmd ()
  (let* ((fnm (file-name-nondirectory (file-name-sans-extension (current-file-name)))))
    (concat
     "texfot lualatex --jobname="
     fnm
     " -shell-escape -file-line-error --synctex=1 -interaction=nonstopmode \"\\input\" "
     fnm
     ".tex")))

;; (defun latex-build-cmd ()
;;   (let* ((fnm (file-name-nondirectory (file-name-sans-extension (current-file-name)))))
;;     (concat
;;      "texfot pdflatex --jobname="
;;      fnm
;;      " -shell-escape -file-line-error --synctex=1 -interaction=nonstopmode \"\\input\" "
;;      fnm
;;      ".tex")))

(defun pythontex-build-cmd ()
  (let* ((fnm (file-name-nondirectory (file-name-sans-extension (current-file-name)))))
     (concat
     "pythontex "
     fnm)))

;;;; GLOBAL VARS / OPTIONS {{{
;; (defvar projectile-main-project) (setq projectile-main-project nil)
(setq-default evil-cross-lines t)

(defun set-vim-foldmarker (fmr)
  "Set Vim-type foldmarkers for the current buffer"
  (interactive "sSet local Vim foldmarker: ")
  (if (equal fmr "")
      (message "Abort")
    (setq fmr (regexp-quote fmr))
    (set (make-local-variable 'outline-regexp)
         (concat ".*" fmr "\\([0-9]+\\)?"))
    (set (make-local-variable 'outline-level)
         `(lambda ()
            (save-excursion
              (re-search-forward
               ,(concat fmr "\\([0-9]+\\)") nil t)
              (if (match-string 1)
                  (string-to-number (match-string 1))
                (string-to-number "0")))))))

;; (global-set-key (kbd "C-<tab>") 'outline-toggle-children)

;; (defun set-vim-foldmarker (fmr)
;;   "Set Vim-type foldmarkers for the current buffer"
;;   (interactive "sSet local Vim foldmarker: ")
;;   (if (equal fmr "")
;;       (message "Abort")
;;     (setq fmr (regexp-quote fmr))
;;     (set (make-local-variable 'outline-regexp)
;;          (concat ".*" fmr "\\([0-9]+\\)"))
;;     (set (make-local-variable 'outline-level)
;;          `(lambda ()
;;             (save-excursion
;;               (re-search-forward
;;                ,(concat fmr "\\([0-9]+\\)") nil t)
;;               (string-to-number (match-string 1)))))))

(set-vim-foldmarker (concat "_" "__"))

;; }}}

;;;; BORDERLESS / SCROLLING {{{
;; =============================================================
(setq frame-resize-pixelwise t)
;; (set abc\\q ns-auto-hide-menu-bar t)
;; (tool-bar-mode 0)


;;; scroll one line at a time (less "jumpy" than defaults)
(setq mouse-wheel-scroll-amount '(2 ((shift) . 1))) ;; two lines at a abc\\ time
(setq mouse-wheel-progressive-speed nil) ;; don't accelerate scrolling
(setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse
;; =============================================================
;; }}}

;;;; INPUT SOURCES {{{
(fix-input "english-dvorak"   ;; matches alternative layout
           "russian-computer" ;; works with QWERTY
           "dvorak-russian")  ;; name of new input method that preserves
;; }}}

;;;; KEY-CHORD {{{
(use-package key-chord :ensure t
  :defer 1 ; do not load right at startup
  :config
  (setq key-chord-two-keys-delay 0.2)
  (key-chord-mode 1)
  (use-package key-seq :ensure t
    :config
    ;; (key-seq-define my-mode-map "mv" #'helm-projectile-find-file)
    ;; (key-seq-define my-mode-map "eu" 'helm-buffers-list)
    ;; (key-seq-define my-mode-map "mw" 'helm-semantic-or-imenu)
    ))

;; }}}

;;;; MODES {{{
;;;; MY-MODE u{{
(defvar my-mode-map (make-sparse-keymap)
  "Keymap for `my-mode'.")
;;;###autoload
(define-minor-mode my-mode
  "A minor mode so that my key settings override annoying major modes."
  ;; If init-value is not set to t, this mode does not get enabled in
  ;; `fundamental-mode' buffers even after doing \"(global-my-mode 1)\".
  ;; More info: http://emacs.stackexchange.com/q/16693/115
  :init-value t
  :lighter " my-mode"
  :keymap my-mode-map)

;;;###autoload
(define-globalized-minor-mode global-my-mode my-mode my-mode)

;; https://github.com/jwiegley/use-package/blob/master/bind-key.el
;; The keymaps in `emulation-mode-map-alists' take precedence over
;; `minor-mode-map-alist'

(delight 'my-mode nil my-mode) ; do not display mode name in mode line

(evil-make-overriding-map my-mode-map)
(add-to-list 'emulation-mode-map-alists `((my-mode . ,my-mode-map)))
;; }}}

;;;; TERM-MODE {{{
(defvar terminal-mode-map (make-sparse-keymap)
  "Keymap for `terminal-mode'.")
;;;###autoload
(define-minor-mode terminal-mode
  "A minor mode so that my key settings override annoying major modes."
  ;; If init-value is not set to t, this mode does not get enabled in
  ;; `fundamental-mode' buffers even after doing \"(global-terminal-mode 1)\".
  ;; More info: http://emacs.stackexchange.com/q/16693/115
  :init-value nil
  :lighter " terminal-mode"
  :keymap terminal-mode-map)

;;;###autoload
;; (define-globalized-minor-mode global-terminal-mode terminal-mode terminal-mode)

;; https://github.com/jwiegley/use-package/blob/master/bind-key.el
;; The keymaps in `emulation-mode-map-alists' take precedence over
;; `minor-mode-map-alist'

;; (delight 'terminal-mode nil terminal-mode) ; do not display mode name in mode line

(evil-make-overriding-map terminal-mode-map 'insert)
;; (evil-make-overriding-map term-raw-map 'insert)
;; (add-to-list 'emulation-mode-map-alists `((terminal-mode . ,terminal-mode-map)))
;; }}}

;;;; NON-TERM-MODE {{{
(defvar non-term-mode-map (make-sparse-keymap)
  "Keymap for `non-term-mode'.")
;;;###autoload
(define-minor-mode non-term-mode
  "A minor mode so that my key settings override annoying major modes."
  ;; If init-value is not set to t, this mode does not get enabled in
  ;; `fundamental-mode' buffers even after doing \"(global-non-term-mode 1)\".
  ;; More info: http://emacs.stackexchange.com/q/16693/115
  :init-value t
  :lighter " non-term-mode"
  :keymap non-term-mode-map)

;;;###autoload
(define-globalized-minor-mode global-non-term-mode non-term-mode non-term-mode)

;; https://github.com/jwiegley/use-package/blob/master/bind-key.el
;; The keymaps in `emulation-mode-map-alists' take precedence over
;; `minor-mode-map-alist'

(delight 'non-term-mode nil non-term-mode) ; do not display mode name in mode line

(add-to-list 'emulation-mode-map-alists `((non-term-mode . ,non-term-mode-map)))
;; }}}

;;;; evil {{{
(setq evil-search-module 'evil-search)
;;;; }}}

;;;; FOLDING {{{
(add-hook 'emacs-lisp-mode-hook
          (lambda ()
            ;; (setq-local origami-fold-style 'triple-braces)
            (outline-minor-mode 1)
            (set-vim-foldmarker (concat "{" "{{"))
            (lispy-mode)))

(add-hook 'json-mode-hook
          (lambda ()
            (outline-minor-mode 1)
            (set-vim-foldmarker (concat "_" "__"))))

(add-hook 'vimrc-mode-hook
          (lambda ()
            (setq-local origami-fold-style 'triple-braces)
            (outline-minor-mode 1)
            (set-vim-foldmarker (concat "{" "{{"))))

;; different fold engines for different modes
(defun fold-show-all ()
  (interactive)
  (cond ((or (string= (message "%s" major-mode) "nxml-mode"))
         (hs-show-all))
        ((string= (message "%s" major-mode) "modelica-mode")
         (outline-show-subtree))
        ((string= (message "%s" major-mode) "latex-mode")
         ;; (TeX-fold-env)
         (outline-show-all) (message "outline-show-all"))
        ((derived-mode-p 'json-mode 'emacs-lisp-mode) (outline-show-all))
        (t (origami-open-all-nodes (current-buffer)))))

(defun fold-toggle ()
  (interactive)
  (cond ((or (string= (message "%s" major-mode) "nxml-mode"))
         (hs-toggle-hiding))
        ((string= (message "%s" major-mode) "modelica-mode")
         (outline-show-subtree))
        ((derived-mode-p 'json-mode 'emacs-lisp-mode) (outline-toggle-children))
        ((derived-mode-p 'latex-mode) (outline-toggle-children) (message "outline-toggle-children"))
        (t (origami-forward-toggle-node (current-buffer) (point)))))

(defun fold-open ()
  (interactive)
  (cond ((or (string= (message "%s" major-mode) "nxml-mode"))
         (progn (save-excursion
                  (hs-show-block))))
        ((string= (message "%s" major-mode) "modelica-mode")
         (outline-hide-other))
        ((derived-mode-p 'json-mode 'emmacs-lisp-mode) (outline-show-subtree))
        ((derived-mode-p 'latex-mode) (outline-show-subtree) (message "outline-show-subtree"))
        (t (origami-open-node (current-buffer) (point)))))

(defun fold-reduce ()
  (interactive)
  (cond ((or (string= (message "%s" major-mode) "nxml-mode"))
         (progn (save-excursion
                  (sgml-skip-tag-backward 1)
                  (evil-digit-argument-or-evil-beginning-of-line)
                  (hs-hide-level 0))))
        ((string= (message "%s" major-mode) "modelica-mode")
         (outline-hide-other))
        ((derived-mode-p 'latex-mode) (outline-hide-body) (message "outline-hide-body"))
        ((derived-mode-p 'json-mode 'emacs-lisp-mode) (outline-hide-body))
        (t (message "default"))))

(defun fold-hide-except ()
  (interactive)
  (fold-reduce)
  (fold-open))

(defun create-fold ()
  (interactive)
  (kill-region (region-beginning) (region-end))
  (evil-open-above 1)
  ;; (indent-according-to-mode)
  (insert (concat ";"))
  (save-excursion (insert (concat "; {{" "{\n"))
                  (yank)
                  (indent-according-to-mode)
                  (insert (concat ";; }}" "}\n"))
                  (evil-normal-state)))

;; (advice-add #'helm-swoop :before #'fold-show-all)
;; (advice-add #'helm-swoop :after #'fold-hide-except)

;; nXML folding using hide-show
(add-to-list 'hs-special-modes-alist
             '(nxml-mode
               "<!--\\|<[^/>]*[^/]>(gmap :states 'insert
      "SPC" 'aking/yas-expand-or-self-insert

      ;; "e u" 'russian-input-method
      ;; "t n" 'reset-input-method
      "," 'self-insert-command
      "C-e" 'move-end-of-line
      "C-a" 'evil-first-non-blank
      ;; move-end-of-line
      ;; move-beginning-of-line
      "C-t" 'yas-next-field-or-maybe-expand
      "C-c C-l" 'helm-colors
      "C-j" (general-simulate-keys "C-q C-j")
      "C-c C-n" 'aking/yas-next-field
      "q" 'aking/self-insert-or-expand
      "t" 'aking/self-insert-or-expand
      "b" 'aking/self-insert-or-expand
      "r" 'aking/self-insert-or-expand
      "n" 'aking/self-insert-or-expand)"
      "-->\\|</[^/>]*[^/]>"
      "<!--"
      ;; nxml-forward-element
      sgml-skip-tag-forward
      nil))

(defun mdc-forward-multiple-block (arg)
  (interactive)
  (dotimes (number arg) (mdc-forward-block)))


(add-to-list 'hs-special-modes-alist
             '(modelica-mode
               "Geometry"
               "Animation"
               "//"
               mdc-forward-multiple-block nil))

(setq outline-regexp " *\\(?:\\(model\\)\\)*?\\(end\\)")

;; }}}

;;;; EX-COMMANDS DEFINITION {{{


(evil-define-motion aking/evil-end-of-line (count)
  "Move the cursor to the last non-blank character
on the current line. If COUNT is given, move COUNT - 1
lines downward first."
  :type inclusive
  (evil-end-of-line count)
  (re-search-backward "^\\|[^[:space:]]")
  (setq evil-this-type (if (eolp) 'exclusive 'inclusive)))

(evil-define-command indent-buffer ()
  (c-set-style "myC")
  (spacemacs/indent-region-or-buffer))

(evil-define-command current-file-name ()
  "Copy the current buffer file name to the clipboard."
  (let ((filename (if (equal major-mode 'dired-mode)
                      default-directory
                    (buffer-file-name))))
    (when filename
      (setq select-enable-clipboard t)
      (kill-new filename)
      (setq select-enable-clipboard nil)
      (message "Copied buffer file name '%s' to the clipboard." filename)
      filename)))

(evil-define-command current-file-dir ()
  "Copy the current buffer file name to the clipboard."
  (let ((filename (if (equal major-mode 'dired-mode)
                      default-directory
                    (buffer-file-name))))
    (when filename
      (setq select-enable-clipboard t)
      (kill-new (file-name-directory filename))
      (setq select-enable-clipboard nil)
      (message "Copied buffer file name '%s' to the clipboard." (file-name-directory filename))
      (file-name-directory filename))))

(defun ns-copy-including-secondary ()
  (interactive)
  (call-interactively 'kill-ring-save)
  (gui-set-selection 'SECONDARY (buffer-substring (point) (mark t)))
  )

(evil-define-command current-mode ()
  (message "%s" major-mode))

(evil-define-command select-till-line-end ()
  ;; (message (number-to-string (- (region-end) (region-beginning))))
  (if (use-region-p) (goto-char (region-beginning)))
  (set-mark-command nil)
  (move-end-of-line nil)
  (setq deactivate-mark nil))

(evil-define-command yank-till-line-end ()
  ;; (set-mark (line-end-position))
  (evil-yank (point) (line-end-position)))

(setq ak/current-input-method "en")

(defun aking/ru-input-method ()
  (interactive)
  (set-input-method 'aking/ru-layout)
  (setq ak/current-input-method "ru")
  (set-cursor-color "red")
  (setq evil-insert-state-cursor '((bar . 2) "red")
        evil-normal-state-cursor '(box "red")))

(evil-define-command aking/reset-input-method ()
  (toggle-input-method)
  (setq ak/current-input-method "en")
  (set-cursor-color "yellow")
  (setq evil-insert-state-cursor '((bar . 2) "yellow")
        evil-normal-state-cursor '(box "yellow")))

(evil-define-command aking/toggle-input-method ()
  (if (string= ak/current-input-method "ru")
      (aking/reset-input-method)
    (aking/ru-input-method)))

(evil-define-command russian-input-method ()
  (message current-input-method)
  (if (string= current-input-method "dvorak-russian")
      (if (string= evil-state "insert")(insert "ва"))
    (set-input-method 'aking/ru-)))

(defun aking//toggle-off-input-method ()
  (interactive)
  (if current-input-method (deactivate-input-method))
  )

(defun aking/TeX-insert-dollar ()
  (interactive)
  (evil-insert-state)
  (aking//toggle-off-input-method)
  (TeX-insert-dollar 2)
  (left-char))

(evil-define-command aking/isearch-forward-ru ()
  (evil-insert-state)
  (aking/ru-input-method)
  (isearch-forward-regexp))

(evil-define-command aking/isearch-backward-ru ()
  (evil-insert-state)
  (aking/ru-input-method)
  (isearch-backward-regexp))

(evil-define-command aking/evil-insert-ru ()
  (evil-insert 0)
  (aking/ru-input-method))

(evil-define-command aking/evil-insert-en ()
  (evil-insert 0)
  (aking//toggle-off-input-method))

(evil-define-command aking/evil-append-ru ()
  (evil-append 0)
  (aking/ru-input-method))

(evil-define-command aking/evil-append-en ()
  (evil-append 0)
  (aking//toggle-off-input-method))

(evil-define-command aking/evil-open-below-en ()
  (evil-open-below 0)
  (aking//toggle-off-input-method))

(evil-define-command aking/evil-open-above-en ()
  (evil-open-above 0)
  (aking//toggle-off-input-method))

(defun aking/isearch-cancel-advice-around (orig-func &rest args)
  (message "my isearch-cancel")
  ;; (interactive)
  (aking//toggle-off-input-method)
  (evil-normal-state)
  (apply orig-func args)
  ;; (evil-force-normal-state)
  (message "my isearch-cancel end")
  )

(defun aking/isearch-cancel ()
  "Terminate the search and go back to the starting point."
  (interactive)
  (if (and isearch-push-state-function isearch-cmds)
      ;; For defined push-state function, restore the first state.
      ;; This calls pop-state function and restores original point.
      (let ((isearch-cmds (last isearch-cmds)))
        (isearch--set-state (car isearch-cmds)))
    (goto-char isearch-opoint))
  (isearch-done t)                      ; Exit isearch..
  (isearch-clean-overlays)
  (evil-normal-state)
  (signal 'quit nil))                   ; ..and pass on quit signal.

;; (advice-add 'isearch-cancel :after #'evil-force-normal-state)
;;(add-function :after (isearch-cancel) 'evil-force-normal-state)

(advice-add 'isearch-cancel :around #'aking/isearch-cancel-advice-around)

(evil-define-command project-dired ()
  (if projectile-main-project
      (projectile-dired)
    (dired-jump)))

(evil-define-command switch-term ()
  (term "/usr/local/bin/bash"))
;; (set-buffer (make-term "terminal" "/usr/local/bin/bash"))
;; (term-mode)
;; (term-char-mode)
;; (switch-to-buffer "*terminal*"))
(evil-define-command save-reload-init ()
  (evil-write-all nil)
  (dotspacemacs/sync-configuration-layers))
(evil-define-command save-restart ()
  (evil-write-all nil)
  (spacemacs/restart-emacs))
(evil-define-command save-restart-resume ()
  (evil-write-all nil)
  (spacemacs/restart-emacs-resume-layouts))
(evil-define-command edit-config ()
  (find-file (expand-file-name "~/Dropbox/Settings/spacemacs/spacemacs.el")))
(evil-define-command edit-config-keymap ()
  (find-file (expand-file-name "~/Dropbox/Settings/spacemacs/keymap.el")))
(evil-define-command latex-build ()
  (evil-write-all nil)
  (latex/build))
(evil-define-command latex-preview ()
  (evil-write-all nil)
  (preview-document)
  ;; (latex/build)
  )

(defun aking/test-message (doc)
  (interactive)
  (message "test message!!!")
  (remove-hook 'TeX-after-compilation-finished-functions #'aking/test-message))

(defun aking/conf-karabiner ()
  (interactive)
  (find-file (expand-file-name "~/.config/karabiner/karabiner.json")))

(defun aking/conf-bash ()
  (interactive)
  (find-file (expand-file-name "~/Dropbox/Settings/bash/bashrc")))

(defun aking/conf-hammerspoon ()
  (interactive)
  (find-file (expand-file-name "~/.hammerspoon/init.lua")))

(defun aking/conf-spacemacs-quail ()
  (interactive)
  (find-file (expand-file-name "~/Dropbox/Settings/spacemacs/quail-map.el")))

(evil-define-command aking/latex-build ()
  (evil-write-all nil)
  (latex/build)
  )

(evil-define-command aking/latex-preview ()
  (evil-write-all nil)
  (preview-buffer)
  )

(defun aking/latex-preview-after-build (doc)
  (interactive)
  (setq unread-command-events (listify-key-sequence "\C-c\C-o\C-p"))
  (remove-hook 'TeX-after-compilation-finished-functions
               #'aking/latex-preview-after-build)
  )

(evil-define-command aking/latex-build-and-preview ()
  (evil-write-all nil)
  (save-window-excursion
    ;; (shell-command (latex-build-cmd))
    ;; (shell-command (pythontex-build-cmd))
    ;; (shell-command (latex-build-cmd)))
    ;; (TeX-command "aking/LaTeX" 'TeX-master-file -1)
    ;; (add-hook 'TeX-after-compilation-finished-functions
    ;;           #'aking/latex-preview-after-build)
    )
  )

;; (evil-define-command aking/latex-build-and-preview ()
;;   (evil-write-all nil)
;;   (let* (
;;          (fnm (file-name-nondirectory (file-name-sans-extension (current-file-name))))
;;         (build-cmd
;;          (concat
;;           "lualatex --jobname="
;;           fnm
;;           " -file-line-error --synctex=1 -interaction=nonstopmode \"\\input\" "
;;           fnm
;;           ".tex"))
;;         (pythontex-build-cmd
;;          (concat
;;           "pythontex "
;;           fnm))
;;         (filename (current-file-name)))
;;     (message build-cmd)
;;     ;; (latex/build)
;;     (save-window-excursion
;;       (shell-command build-cmd)
;;       (shell-command pythontex-build-cmd)
;;       (shell-command build-cmd))
;;     )
;;   ;; (TeX-command "aking/LaTeX" 'TeX-master-file -1)
;;   ;; (add-hook 'TeX-after-compilation-finished-functions
;;   ;;           #'aking/latex-preview-after-build)
;;   )

(eval-after-load "tex"
  '(add-to-list
    'TeX-command-list
    '("aking/LaTeX"
      "%`lualatex --jobname=main %(file-line-error) %(extraopts) %S%(mode) %' %t"
      TeX-run-TeX nil
      (latex-mode doctex-mode)
      :help "Convert DVI->PDF")))

(evil-define-command restart-emacs ()
  (evil-write-all nil)
  (spacemacs/restart-emacs-resume-layouts))

(defun duplicate-line ()
  (interactive)
  (cond
   ((string= evil-state "normal")
    (move-beginning-of-line 1)
    (kill-line)
    (yank)
    (move-beginning-of-line 1)
    (kill-line)
    (yank)
    (open-line 1)
    (next-line 1)
    (yank))
   ((string= evil-state "visual")
    (setq size (- (region-end) (region-beginning)))
    ;; (evil-delete (region-beginning) (region-end))
    (kill-ring-save (region-beginning) (region-end))
    (yank)
    ;; (yank)
    ;; (forw-char)
    )))

(defun forw-char ()
  (interactive)
  (forward-char 20))

(defun cpp-terminate-line ()
  (interactive)
  (if (let ((point-old (point)))
        (save-excursion
          (if (= (line-end-position) (point));
              t
            nil)))
      (progn
        (insert ";")
        (evil-normal-state))
    (forward-char)))

(defun backward-kill-line (arg)
  "Kill ARG lines backward."
  (interactive "p")
  (kill-line (- 1 arg))
  (indent-for-tab-command))

(defun aking/normal-and-undo ()
  (interactive)
  (evil-normal-state 1)
  (undo-tree-undo))

;; }}}

;;;; YAS FUNCTIONS {{{

(defun aking/yas-expand-or-self-insert ()
  "Try to expand a snippet at a key before point.
Otherwise insert space"
  (interactive)
  (if (bound-and-true-p yas-minor-mode)
      (progn (if yas-triggers-in-field
                 (let ((yas-fallback-behavior 'return-nil)
                       )
                   (unless (yas-expand)
                     (progn (message (current-time-string))
                            (self-insert-command 1))))
               ))
    (self-insert-command 1)
    )
  )

(defun aking/yas-reload ()
  (interactive)
  (evil-write-all nil)
  (shell-command (concat "cd " dot-path "/snippets/ && ./yas-latex.pl"))
  (yas-reload-all))

(defun aking/yas-latex ()
  (interactive)
  (find-file (concat dot-path "/snippets/snip-latex")))

(defun aking/yas-latex-script ()
  (interactive)
  (find-file (concat dot-path "/snippets/yas-latex.pl")))

(defun aking/LaTeX-environment ()
  (interactive)
  (let ((environment (LaTeX-current-environment 1)))
    (message environment)))


;; +++++++++++++++++++++++++++++++++++++++++++
(defun aking/test ()
  (interactive)
  (save-excursion
    (if  (search-backward "test" (- (point) (length "test")) t)
        (message "found")
      (message "not found"))))

(setq aking/latex-snippets '("ar" "un" "ob" "on" "sq" "ti" "hi"))

(defun aking/expand (string)
  (let ((len (length string)))
    (if (save-excursion (search-backward string (- (point) len) t))
        (progn (delete-backward-char len)
               (yas-expand-snippet (yas-lookup-snippet (concat string "_t"))))
      nil)))

(defun aking/expand-all (list)
  (loop for string in list do
        (when (aking/expand string)
          (return))))

(defun aking/self-insert-or-expand ()
  (interactive)
  (self-insert-command 1)
  (and (derived-mode-p 'latex-mode)
       (texmathp)
       (aking/expand-all aking/latex-snippets)))

(defun aking/yas-next-field ()
  (interactive)
  (yas-next-field))

(defun aking/latex-math-mode ()
  "key: m"
  (interactive)
  (unless (texmathp)
    (progn  (yas-expand-snippet (yas-lookup-snippet "mathm"))
            (aking//toggle-off-input-method))))

(defun aking/LaTeX-new-equation ()
  (interactive)
  (if (or (string= (LaTeX-current-environment 1) "equation*") (string= (LaTeX-current-environment 1) "equation"))
      (progn (preview-environment 0)
             (LaTeX-find-matching-end)
             (newline)
             (yas-expand-snippet (yas-lookup-snippet "ens")))
    (progn (LaTeX-indent-line)
      ;; (reindent-then-newline-and-indent)
      (yas-expand-snippet (yas-lookup-snippet "ens")))))

(defun aking/latex-convert-to-big ()
  (interactive)
  (re-search-backward "\\\\(")
  (kill-region (point) (+ (point) 2))
  (insert "\n\\begin{equation*}\n")
  (re-search-forward "\\\\)")
  (kill-region (point) (+ (point) -2))
  (insert "\n\\end{equation*}\n"))

;; +++++++++++++++++++++++++++++++++++++++++++



(defun aking/match-latex-math-end ()
  (interactive)
  (re-search-forward "\\\\)"))

(defun LaTeX-delete-environment ()
  (interactive)
  (when (LaTeX-current-environment)
    (save-excursion
      (let* ((begin-start (save-excursion
                            (LaTeX-find-matching-begin)
                            (point)))
             (begin-end (save-excursion
                          (goto-char begin-start)
                          (search-forward-regexp "begin{.*?}")))
             (end-end (save-excursion
                        (LaTeX-find-matching-end)
                        (point)))
             (end-start (save-excursion
                          (goto-char end-end)
                          (1- (search-backward-regexp "\\end")))))
        ;; delete end first since if we delete begin first it shifts the
        ;; location of end
        (delete-region end-start end-end)
        (delete-region begin-start begin-end)))))

;; }}}

;;;; MISC FUNCTIONS {{{

;; move cursor after yank

(defun aking/view-pdf ()
  (interactive)
  (let ((filename (file-name-sans-extension (current-file-name))))
    (shell-command (concat "open -a skim " filename ".pdf"))))

(defun aking/dired-home ()
  (interactive)
  (dired "/Users/Aleksey/"))

(defun aking/dired-file ()
  (interactive)
  (dired (current-file-dir)))

(defun aking/dired-dot ()
  (interactive)
  (dired "/Users/Aleksey/Dropbox/Settings/"))

(defun aking/dired-math ()
  (interactive)
  (dired "/Users/Aleksey/Dropbox/Studies/Math/"))

(defun aking/dired-cs ()
  (interactive)
  (dired "/Users/Aleksey/Dropbox/Studies/_CS/"))

(defalias 'aking/save 'evil-write)
(defalias 'aking/save-all 'evil-write-all)

(defun aking/paste0 ()
  (interactive)
  (evil-paste-after 1 ?0))

(defun aking/paste-visual ()
  (interactive)
  ;; (evil-)
  ;; (evil-paste-after 1 ?0)
  )

(defun aking/return ()
  (interactive)
  (message "aking/return")
  (if (derived-mode-p 'dired-mode)
      (dired-find-file)
    (helm-buffers-list)))

(defun aking/shell-command ()
  (interactive)
  (shell-command "make"))

(defun evil-yank-after (beg end type register yank-handler)
  (if (= (point) beg)
      (goto-char (1- end))
    (goto-char beg)))

(advice-add #'evil-yank :after #'evil-yank-after)

(defun aking/end-of-line ()
  (interactive)
  (end-of-line))

(defun change-till-end-word () (interactive)
       (evil-visual-char)
       (evil-backward-char)
       (evil-forward-word-end)
       (evil-change (region-beginning) (1+ (region-end))))

;; till end word operator
(defun till-end-word () (interactive)
       (evil-visual-char)
       (evil-backward-char)
       (evil-forward-word-end))

;; cn
(defun change-till () (interactive)
       (call-interactively 'evil-change)
       (evil-snipe-t))

(evil-define-motion evil-forward-word-end (count &optional bigword)
  "Move the cursor to the end of the COUNT-th next word.
If BIGWORD is non-nil, move by WORDS."
  :type inclusive
  (let ((thing (if bigword 'evil-WORD 'evil-word))
        (count (or count 1)))
    (evil-signal-at-bob-or-eob count)
    ;; Evil special behaviour: e or E on a one-character word in
    ;; operator state does not move point
    (unless (and (evil-operator-state-p)
                 (= 1 count)
                 (let ((bnd (bounds-of-thing-at-point thing)))
                   (and bnd
                        (message (number-to-string (point)))
                        (message (number-to-string (car bnd)))
                        (message (number-to-string (cdr bnd)))
                        ;; (= (car bnd) (point))
                        (= (cdr bnd) (1+ (point)))))
                 ;; (looking-at "[[:word:]]")
                 )
      (evil-forward-end thing count))))

;; }}}

;;;; vertigo {{{
(setq vertigo-home-row '(?a ?o ?e ?u ?i ?d ?h ?t ?s ?n))
;; }}}


;;;; main-project permanent {{{
(defun set-main-project (&optional dir)
  (setq projectile-main-project nil)
  "Set the projectile main project based on the current buffer.
   When called with argument DIR, make that main project instead."
  (interactive)
  (if dir
      (setq projectile-main-project dir)
    (let ((current-project))
      (let ((projectile-main-project nil))
        (setq current-project (projectile-project-root)))
      (setq projectile-main-project current-project))))

(defun use-main-project (&rest args)
  "Skip calling `projectile-project-root' when there is a main project defined."
  (when projectile-main-project
    projectile-main-project))

;; (defun set-main-pro (project-to-switch &optional arg))
(advice-add #'projectile-project-root :before-until #'use-main-project)
(advice-add #'projectile-switch-project-by-name :before #'set-main-project)
(setq projectile-generic-command "find -L . -type f -print0")
;; }}}

;;;; some stuff {{{
(setq avy-keys '(?a ?o ?e ?u ?h ?t ?n ?s))
;;}}}

;;;; LaTex {{{

(defun aking/latex-template ()
  (interactive)
  (find-file (concat dot-path "latex/template.tex")))

(defun aking/latex-new (path)
  (interactive "sEnter path: ")
  (save-window-excursion
    (shell-command
     (concat  dot-path "scripts/tex-new.sh " "./" path)))
  (set-main-project (concat (current-file-dir) path))
  (find-file (concat path "/" (file-name-nondirectory path) ".tex")))

(defun aking/latex-upsync (filename)
  (interactive "sEnter filename: ")
  (let ((file
         (if (string= "" filename)
             (file-name-nondirectory (current-file-name))
           filename)))
    (aking/save-all nil)
    (shell-command
     (concat
      "yes | "
      "cp "
      (current-file-name)
      " "
      dot-path
      "latex/styles/"
      file))))

(defun aking/latex-upsync-default ()
  (interactive)
  (aking/latex-upsync ""))

(setq LaTeX-math-abbrev-prefix "/")
(setq preview-auto-cache-preamble t)
(setq preview-default-option-list
      '("displaymath" "textmath" "sections"))
;; (add-to-list 'LaTeX-math-list (?8 "infty" "Misc Symbol" 8734))

(defun my-LaTeX-math-mathbb (char dollar)
  "Insert {\Bbb CHAR} or \mathbb{CHAR} if latex2e is in TeX-style-list.  If DOLLAR is non-nil, put $'s around it."
  (interactive "*c\nP")
  (if dollar (insert "$"))
  (if (member "latex2e" (TeX-style-list))
      (insert "\\mathbb{" (char-to-string char) "}")
    (insert "{\\Bbb " (char-to-string char) "}"))
  (if dollar (insert "$")))

;; (setq LaTeX-math-list
;;       '(("8" 'my-LaTeX-math-mathbb "Misc Symbol" 8734)
;;         ("/" "abchdh/" "Misc Symbol" 8734)
;;         (?I "int" "Var Symbol" 8747)))

(setq LaTeX-math-list ())
(add-to-list 'LaTeX-math-list '("=" my-LaTeX-math-mathbb "" nil))
(add-to-list 'LaTeX-math-list '("/" (lambda () (interactive) (self-insert-command 1)) "" nil))

(setq LaTeX-verbatim-environments-local '("Verbatim" "cppL" "textL" "pycode" "pyc"))

(add-hook 'LaTeX-mode-hook 'add-my-latex-environments)
(defun add-my-latex-environments ()
  ;; (texmathp-compile)
  ;; (add-to-list 'font-latex-math-environments (quote ("xcases")))
  (LaTeX-add-environments
   '("xcases" LaTeX-env-label)
   '("syseq" LaTeX-env-label)))

(custom-set-variables '(texmathp-tex-commands (append texmathp-tex-commands-default '(("xcases" env-on)
                                                                                      ("syseq" env-on)))))
(custom-set-variables
 '(font-latex-math-environments (quote
                                 ("display" "displaymath" "equation" "eqnarray" "gather" "multline"
                                  "align" "alignat" "xalignat" "dmath" "xcases" "syseq")))
 '(TeX-insert-braces nil)) ;;Stops putting {} on argumentless commands to "save" whitespace


;; (add-to-list 'LaTeX-math-list '("=" "infty" "" nil))
;;;; test inner {{{
(put 'TeX-command-extra-options 'safe-local-variable 'stringp)
;; (define-key global-map (kbd "M-r") 'latex-build)
;; }}}


(put 'helm-make-build-dir 'safe-local-variable 'stringp)
;; }}}

;;;; ESS {{{
;; (add-hook 'ess-mode-hook
;;           (lambda ()
;;             (ess-toggle-underscore nil)))
;; }}}

;;;; helm-swoop {{{
;; (helm-autoresize-mode 1)
;; (setq helm-swoop-pre-input-function
;;       (lambda () (if (boundp 'helm-swoop-pattern)
;;                      helm-swoop-pattern "")))
;; (setq helm-split-window-default-side 'above)
;; ;; (helm-autoresize-min-height 10)
;; (helm-autoresize-max-height 30)
;; }}}

;;;; build-run {{{
(defun lisp-run ()
  ;; (message "lisp run!")
  ;; (ignore-errors (evil-window-right 10))
  ;; (term "/usr/local/bin/bash")
  ;; (kill-new (concat "make -C " projectile-main-project " run\n"))
  ;; ;; (evil-insert-state)
  ;; (term-send-raw-string (concat "a" "\M-t" "\C-u"))
  ;; ;; (evil-normal-state)
  ;; (term-paste)
  ;; (ignore-errors (evil-window-left 10))

  (slime-compile-and-load-file)
  ;; (slime-load-file buffer-file-name)
  )

(defun run-on-success-cmd (cmd)
  (concat "if [ $? -eq 0 ]; then " cmd "; else return 1; fi;"))

(defun check-string-in-output (cmd str)
  (concat cmd " | tee /dev/tty | grep '" str "' &> /dev/null"))

(defun latex-success-build ()
  (check-string-in-output (latex-build-cmd) "Output written"))

(defun ak/term-run ()
  (let* ((cd-cmd (concat "cd " (current-file-dir) "\n"))
         (latex-build-cmd (concat (latex-success-build) "\n"))
         (pythontex-build-cmd (concat (run-on-success-cmd (pythontex-build-cmd)) "\n"))
         (biber-cmd (concat "biber quat-report\n"))
         (latex-build-2-cmd (concat (run-on-success-cmd (latex-success-build)) "\n")))
    (ignore-errors (evil-window-right 10))
    (term "/usr/local/bin/bash")
    ;; (evil-insert-state)
    (term-send-raw-string (concat "\C-l" "a" "\M-t" "\C-u"))
    ;; (evil-normal-state)
    (kill-new cd-cmd) (term-paste)
    (kill-new latex-build-cmd) (term-paste)
    ;; (kill-new pythontex-build-cmd) (term-paste)
    (kill-new biber-cmd) (term-paste)
    (kill-new latex-build-2-cmd) (term-paste)
    (ignore-errors (evil-window-left 10)))

  ;; (slime-compile-and-load-file)
  ;; (slime-load-file buffer-file-name)
  )

(defun ak/term ()
  (interactive)
  (term "/usr/local/bin/bash"))

(evil-define-command ak/generate-makefile ()
  (let* ((fnm (file-name-nondirectory (file-name-sans-extension (current-file-name))))
        (make-command (concat "newmake " fnm "\n")))
    (evil-write-all nil)
    (ak/term-cd)
    (kill-new make-command) (term-paste)))

(defun ak/run-cmd-in-term (cmd)
  (interactive)
  (kill-new cmd) (term-paste))

(evil-define-command ak/make ()
  (if (derived-mode-p 'latex-mode)
      (preview-buffer))
  (save-selected-window
    (evil-write-all nil)
    (ignore-errors (evil-window-right 10))
    (ak/term)
    (ak/run-cmd-in-term "gmake\n")))

(evil-define-command ak/compile ()
  (evil-write-all nil)
  (ignore-errors
    (if (derived-mode-p 'latex-mode)
        (preview-buffer)))
  (let ((cmd "export max_print_line=1000\ngmake\n"))
    (compile cmd)))

(defun ak/term-cd ()
  (interactive)
  (let* ((cd-cmd (concat "cd " (current-file-dir) "\n")))
    (ignore-errors (evil-window-right 10))
    (term "/usr/local/bin/bash")
    (term-send-raw-string (concat "\C-l" "a" "\M-t" "\C-u"))
    (kill-new cd-cmd) (term-paste)))

(defun ak/view-pdf ()
  (interactive)
  (let* ((filename-base (file-name-sans-extension (current-file-name)))
         (filename (concat filename-base ".pdf")))
    (ignore-errors (evil-window-right 10))
    (find-file filename)))

(evil-define-command aking/compile-project ()
  (evil-write-all nil)
  (if (string= evil-state "insert") (evil-normal-state))
  (cond ((or (string= (message "%s" major-mode) "wolfram-mode"))
         (mathematica-run))
        ((or (string= (message "%s" major-mode) "modelica-mode"))
         (evil-write-all nil)
         (kill-new (concat default-directory "simulate.m"))
         (compile compile-command))
        ((or (derived-mode-p 'latex-mode))
         ;; (aking/latex-build-and-preview)
         (ak/term-run))
        ((string= (message "%s" major-mode) "lisp-mode")
         (evil-write-all nil)
         (lisp-run))
        (t
         (progn
           (evil-write-all nil)
           ;; (if (string= evil-state "insert") (evil-normal-state))
           (setq compile-command (concat "make -C " projectile-main-project))
           (compile compile-command)))))

(evil-define-command mathematica-run ()
  (evil-write-all nil)
  (kill-new (buffer-file-name))
  (shell-command "osascript /Users/Aleksey/Dropbox/Settings/AppleScript/Mathematica\\ evaluate.scpt"))

(evil-ex-define-cmd "me" 'mathematica-run)
;; }}}

;;;; filetype specific {{{
;; (setq compilation-finish-function
;;       (lambda (buf str)
;;         (if (null (string-match ".*exited abnormally.*" str))
;;             ;;no errors, make the compilation window go away in a few seconds
;;             (progn
;;               (run-at-time
;;                "0.5 sec" nil 'delete-windows-on
;;                (get-buffer-create "*compilation*"))
;;               (message "No Compilation Errors!")))))


(add-hook 'c++-mode-hook
          (lambda () (setq compilation-finish-functions
                           (lambda (buf str)
                             (if (null (string-match ".*exited abnormally.*" str))
                                 ;;no errors, make the compilation window go away in a few seconds
                                 (progn
                                   (run-at-time
                                    "0.5 sec" nil 'delete-windows-on
                                    (get-buffer-create "*compilation*"))
                                   (message "No Compilation Errors! lets run!")
                                   ;; (ignore-errors (evil-window-right 10))
                                   ;; (term "/usr/local/bin/bash")
                                   ;; (evil-insert-state)
                                   ;; (term-send-raw-string (concat "\C-u" "make -C " projectile-main-project " run\n"))))
                                   (shell-command (concat "make -C " projectile-main-project " run\n"))))
                             )))
          )

(defun ak/term-map ()
  (define-key term-raw-map (kbd "C-h") nil)
  (define-key term-raw-map (kbd "C-x") nil)
            (define-key term-raw-map (kbd "C-h k") 'describe-key)
            (define-key term-raw-map (kbd "C-h v") 'describe-variable)
  )

(defun ak/lispy-mode-hook ()
  (define-key lispy-mode-map "\M-m" nil))

(add-hook 'lispy-mode-hook 'ak/lispy-mode-hook)
(add-hook 'term-mode-hook 'ak/term-map)

(add-hook 'modelica-mode-hook
          (lambda ()
            (hs-minor-mode)
            (outline-minor-mode)
            (set (make-local-variable 'compile-command)
                 (concat "osascript /Users/Aleksey/Dropbox/Settings/AppleScript/simulate.scpt"))
            (setq compilation-finish-function
                  (lambda (buf str)
                    (if (null (string-match ".*exited abnormally.*" str))
                        (progn
                          (run-at-time
                           "0.5 sec" nil 'delete-windows-on
                           (get-buffer-create "*compilation*"))))))))
(add-hook 'modelica-mode-hook
          (lambda ()
            (hs-minor-mode)
            (outline-minor-mode)
            (set (make-local-variable 'compile-command)
                 (concat "osascript /Users/Aleksey/Dropbox/Settings/AppleScript/simulate.scpt"))
            (setq compilation-finish-function (lambda (buf str) (if (null (string-match ".*exited abnormally.*" str))
                                                                    (progn
                                                                      (run-at-time
                                                                       "0.5 sec" nil 'delete-windows-on
                                                                       (get-buffer-create "*compilation*"))))))))

;;}}}

;;;; dired {{{
(require 'dired-x)
(setq-default dired-omit-files-p t) ; this is buffer-local variable
(setq dired-omit-files "^\\.pdf$\\|\\.git$\\|\\.DS_Store$")
(add-hook 'dired-mode-hook (lambda () (dired-omit-mode 1)
                             (dired-hide-details-mode 1)))
;; (use-package dired-x
;;   :config
;;   (progn
;;     (setq dired-omit-verbose nil)
;;     ;; toggle `dired-omit-mode' with C-x M-o
;;     (add-hook 'dired-mode-hook #'dired-omit-mode)
;;     (setq dired-omit-files
;;           (concat dired-omit-files "\\|^.DS_Store$"))))
;; }}}

;;;; c-styles {{{
(use-package cc-styles
  :defer t
  :config
  (progn
    (c-add-style "bb"
                 '((indent-tabs-mode . nil)
                   (c-basic-offset . 4)
                   (c-offsets-alist
                    (substatement-open . 0)
                    (inline-open . 0)
                    (statement-cont . c-lineup-assignments)
                    (inextern-lang . 0)
                    (innamespace . 0))))
    (c-add-style "myC"
                 '((indent-tabs-mode . nil)
                   (c-basic-offset . 2)
                   (c-offsets-alist
                    (substatement-open . 0)
                    (inline-open . 0)
                    (statement-cont . c-lineup-assignments)
                    (inextern-lang . 0)
                    (innamespace . +)
                    (arglist-intro . 6)
                    (member-init-intro . ++))))))


(defun my-indent-setup ()
  (interactive)
  (c-set-offset 'arglist-intro (* 3 c-basic-offset))
  (c-set-offset 'arglist-cont 13))

;; }}}

;;;; major modes {{{
(add-to-list 'auto-mode-alist
             '("\\.scpt\\'" . (lambda () (apples-mode))))

(add-to-list 'auto-mode-alist
             '("\\.mo\\'" . (lambda () (modelica-mode))))

(add-to-list 'auto-mode-alist
             '("\\.xml\\'" . (lambda () (sgml-mode) (nxml-mode) (hs-minor-mode))))

(add-to-list 'auto-mode-alist
             '("\\.m\\'" . (lambda () (wolfram-mode))))

(use-package qt-pro :config
  (add-to-list 'auto-mode-alist '("\\.pr[io]$" . qt-pro-mode)))
;; }}}

;;;; evil-snipe {{{
;; (evil-snipe-override-mode 1)
;; (push '(?\[ "[[{(]") evil-snipe-aliases)
;; (push '(?\] "[]})]") evil-snipe-aliases)
;; }}}

;;;; misc {{{
;; selection to litte finger
(add-hook 'helm-mode-hook (lambda ()
                            (define-key helm-buffer-map (kbd "C-M-SPC") 'helm-toggle-visible-mark)
                            (define-key helm-buffer-map (kbd "C-H") 'describe-key)))


;; snippet inside snippet bug workaround
(add-hook 'yas-before-expand-snippet-hook (lambda ()
                                            (ignore-errors (insert "a") (delete-char -1 nil))))

;; latex preview size
(set-default 'preview-scale-function 1.4)
;; }}}

(setq debug-on-error t)
(setq compilation-skip-threshold 2)
;;;; org {{{
;; (org-babel-load-file (expand-file-name "~/Dropbox/Settings/Emacs/myinit.org"))
;; }}}

;;;; ex-commands binding {{{
(evil-ex-define-cmd "te" 'switch-term)
(evil-ex-define-cmd "wu" 'save-reload-init)
(evil-ex-define-cmd "wur" 'save-restart-resume)
(evil-ex-define-cmd "wuu" 'save-restart)
(evil-ex-define-cmd "ec" 'edit-config)
(evil-ex-define-cmd "ecc" 'spacemacs/find-dotfile)
(evil-ex-define-cmd "nu" 'spacemacs/toggle-line-numbers)
(evil-ex-define-cmd "rnu" 'spacemacs/linum-relative-toggle)
(evil-ex-define-cmd "mes" 'view-echo-area-messages)
;; }}}

;;;; python {{{
;; (add-hook 'python-mode-hook 'jedi:ac-setup)
;; (setq jedi:complete-on-dot t)
;; }}}


(quail-define-package
 "aking/ru-layout" "Aking/ru-layout" "RUS" nil
 ""
 nil t t nil t nil nil nil nil nil t)

(load "/Users/Aleksey/Dropbox/Settings/spacemacs/quail-map.el")

(setenv "LANG" "en_US.UTF-8")
