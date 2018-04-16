;;;; definitions {{{

(setq hyper "C-x C-x C-x ")
(setq pref "C-x C-x C-x C-c ")

(use-package general :ensure t
  :config
  (general-evil-setup t)
  (general-create-definer bmap)
  (general-create-definer gmap :keymaps 'my-mode-map))

(defun not-dired ()
  (and (not (string= (message "%s" major-mode) "image-dired-thumbnail-mode"))
       (not (string= (message "%s" major-mode) "sx-question-list-mode"))
       (not (string= (message "%s" major-mode) "sx-inbox-mode"))
       (not (string= (message "%s" major-mode) "dired-mode"))))

(defalias 'gkd 'general-key-dispatch)
(defalias 'gsk 'general-simulate-keys)

(defalias 'helm-M-x-2 'helm-M-x)

(defalias 'self-insert-command-2 'self-insert-command)
(defalias 'self-insert-command-3 'self-insert-command)
(defalias 'self-insert-command-4 'self-insert-command)
(defalias 'russian-input-method-2 'russian-input-method)


;; }}}

;;;; SPECIFIC modes {{{


(gmap
 :keymaps 'doc-view-mode-map
 :states '(normal visual motion operator insert emacs)
 "m" 'doc-view-next-line-or-next-page
 "t" 'doc-view-previous-line-or-previous-page
 "a" 'doc-view-next-page
 "p" 'doc-view-previous-page)

(bmap  :keymaps 'terminal-mode-map
       :state 'insert
       "C-r" (lambda () (interactive) (term-send-raw-string "\C-r"))
       "M-t" (lambda () (interactive) (term-send-raw-string "\M-t"))
       "C-M-t" (lambda () (interactive) (term-send-raw-string "\M-t"))
       "C-c C-c" (lambda () (interactive) (term-send-raw-string "\C-c")))

(gmap :keymaps 'latex-mode-map
      "q" 'aking/project-sq)

(bmap :keymaps 'helm-color-map
      "RET" 'helm-color-run-insert-rgb
      "C-c C-r" 'helm-color-run-insert-rgb)

(gmap :keymaps 'isearch-mode-map
      "C-%" 'aking/isearch-cancel
      "<escape>" 'aking/isearch-cancel)

;; }}}

;;;; normal visual motion operator insert emacs {{{

(gmap :states '(normal visual motion operator insert emacs)
      "M-^" 'aking/reset-input-method
      "M-%" 'save-reload-init

      "s-r" 'aking/compile-project

      "C-w <right>" 'evil-window-right
      "C-w <left>" 'evil-window-left
      "C-w <up>" 'evil-window-up
      "C-w <down>" 'evil-window-down

      ;; "C-c C-i" 'toggle-input-method
      "C-c C-i" 'aking/toggle-input-method
      "M-c" 'self-insert-command
      "C-c $" 'aking/TeX-insert-dollar
      "C-w C-d" 'kill-this-buffer
      "C-w q" 'evil-window-delete
      ;; "C-M-s" 'aking/isearch-forward-ru
      ;; "C-M-t" 'aking/isearch-backward-ru
      ;; "C-r" 'aking/shell-command
      "M-s" 'cpp-terminate-line
      "M-b" 'backward-word
      ;; "M-n" 'forward-word
      "C-M-b" 'backward-char
      "C-M-n" 'forward-char
      "M-t" 'evil-delete-backward-word  ; C-M-Del
      "C-M-t" 'backward-delete-char     ; C-M-Del
      "C-M-h" 'describe-key
      "M-<right>" 'forward-word
      "M-<left>" 'evil-backward-word-begin
      "C-c C-d" 'LaTeX-delete-environment
      "C-c C-o C-p" 'preview-buffer)

;; }}}

;;;; normal visual motion operator insert       {{{
(gmap :states '(normal visual motion operator insert)
      "s-<right>" 'move-end-of-line
      "s-<left>" 'back-to-indentation
      )

;; }}}

;;;; normal visual motion                 emacs {{{

(gmap :states '(motion normal visual emacs)
      ;; :keymaps 'doc-view-mode-map
      "SPC"
      (gkd 'helm-projectile-switch-project :timeout 0.3
           "m" 'aking/latex-convert-to-big
           "p"
           (gkd 'current-file-name :timeout 0.5
                "p" 'current-file-dir
                ;; "m" 'current-mode
                )
           "c"
           (gkd 'edit-config-keymap :timeout 0.5
                "k" 'aking/conf-karabiner
                "h" 'aking/conf-hammerspoon
                "q" 'aking/conf-spacemacs-quail
                "c"
                (gkd 'edit-config :timeout 0.5
                     "c" 'spacemacs/find-dotfile))
           "s"
           (gkd 'aking/save :timeout 0.5
                "a" 'aking/save-all
                "/" 'evil-save-and-quit)
           "i" 'save-reload-init
           "r" 'aking/compile-project
           "w w" 'preview-environment
           "v" 'aking/view-pdf
           "b" 'aking/latex-build
           "w r" 'save-restart-resume
           "w R" 'save-restart
           "w u" 'save-reload-init
           "h" 'avy-goto-word-1
           "n" 'avy-goto-line
           "o" 'helm-projectile-switch-project
           "o"
           (gkd 'projectile-dired :timeout 0.5
                "m" 'aking/dired-math
                "c" 'aking/dired-cs
                "d" 'aking/dired-dot)
           "t"
           (gkd 'aking/tex-new :timeout 0.5
                "d" 'aking/test
                "t" 'aking/tex-template)
           "l"
           (gkd 'aking/tex-new :timeout 0.5
                "c" (gsk "; u C-c C-e")
                "l" (gsk "C-c C-l"))
           "y"
           (gkd 'helm-yas-visit-snippet-file :timeout 0.5
                "n" 'yas-new-snippet
                "r" 'aking/yas-reload
                "l" 'aking/yas-latex
                "t" (gkd 'aking/yas-latex :timeout 0.5
                         "s" 'aking/yas-latex-script))))

;; }}}

;;;; normal visual motion operator              {{{

(defalias 'helm-projectile-find-file-2 'helm-projectile-find-file)

(gmap :states '(normal visual motion operator)
      "s" 'evil-forward-char
      "m" 'evil-next-line
      "t" 'evil-previous-line
      ;; "C-a" 'evil-first-non-blank
      ;; "C-e" 'evil-end-of-line

      "l" 'evil-yank

      "/" 'evil-ex-search-forward
      "?" 'evil-ex-search-backward

      "RET" 'aking/return
      "TAB" 'mode-line-other-buffer

      "u"
      (gkd 'helm-projectile-find-file :timeout 0.3
           ;; "h" 'undo-tree-undo
           "c" 'evil-substitute
           "s" 'aking/evil-end-of-line
           "r" 'evil-first-non-blank
           "o" 'evil-open-above
           "t" 'evil-goto-first-line
           "m" 'evil-goto-line
           "e" 'evil-forward-WORD-end)

      "h"
      (gkd 'helm-projectile-find-file-2 :timeout 0.3
           "c" 'evil-substitute
           "s" 'aking/evil-end-of-line
           "r" 'evil-first-non-blank
           "o" 'evil-open-above
           "p" 'aking/paste0))

;; }}}
;;;; normal visual motion                       {{{

(gmap :states '('normal visual motion)
      "x" (gsk "z")
      ;; "|" 'aking/evil-insert-ru
      ;; "i" 'aking/evil-insert-en
      ;; ;; "." 'aking/evil-append-ru
      ;; "a" 'aking/evil-append-en
      ;; "o" 'aking/evil-open-below-en
      ;; "O" 'aking/evil-open-above-en

      "v" 'evil-visual-line
      "V" 'evil-visual-char
      "j" 'evil-snipe-F
      "r" 'evil-snipe-f
      "y" 'evil-snipe-f

      "C-/" 'helm-swoop

      "M" 'evil-scroll-down
      "T" 'evil-scroll-up

      ;; yank to t

      "n" 'evil-forward-word-begin
      "N" 'evil-forward-WORD-begin
      "w" 'evil-ex-search-next
      "W" 'evil-ex-search-previous
      "-" 'helm-buffers-list
      "C-c p" 'helm-projectile-find-file
      "C-c C-p" 'helm-projectile-switch-project
      "C-c b" 'helm-buffers-list
      "r" 'evil-backward-char
      "j" 'evil-join
      "J" (gsk "a <return>"))


;; }}}
;;;; normal visual                              {{{
(gmap :states '('normal 'visual)
      "X" 'evil-shift-right
      "k" 'evil-delete-char
      "K" 'evil-delete-backward-char)

;; }}}
;;;; normal                                     {{{
(gmap :states 'normal
      "+" (gsk ":-,-t. <left><left><left><left>")
      "-" (gsk ":+,+t. <left><left><left><left>")
      ;; dot >>>>
      ;; "x" 'evil-repeat
      "X" 'evil-shift-right

      ;; undo
      "`" 'undo-tree-undo
      "~" 'undo-tree-redo

      "z m" 'fold-reduce
      "z a" 'fold-toggle
      "z o" 'fold-open
      "z u" 'fold-hide-except
      "z r" 'fold-show-all
      "z x" 'evil-scroll-line-to-center
      "z e" 'evil-scroll-line-to-center
      "C-a" 'evil-numbers/inc-at-pt
      "C-x" 'evil-numbers/dec-at-pt

      ;; "M-i" 'indent-buffer
      )

;; }}}

;;;;                               insert       {{{

(gmap :states 'insert
      "л"
      (gkd 'self-insert-command-4
        :timeout 0.25
        "s" 'reset-input-method)
      ;; "e"
      ;; (gkd 'self-insert-command-2
      ;;   :timeout 0.25
      ;;   "a" 'russian-input-method-2)
      ;; "h"
      ;; (gkd 'self-insert-command-3
      ;;   :timeout 0.5
      ;;   "l" 'evil-normal-state)
      ;; "u"
      ;; (gkd 'self-insert-command
      ;;   :timeout 0.25
      ;;   "h" '(lambda () (interactive) (yas-expand-snippet (yas-lookup-snippet "un"))))
      ;; "к"
      ;; (gkd 'self-insert-command-2
      ;;   :timeout 0.5
      ;;   "l" 'evil-normal-state)
      )

;; (key-chord-define evil-insert-state-map "hl" 'evil-normal-state)
;; (key-chord-define evil-insert-state-map "eu" 'russian-input-method)

(gmap :states 'insert
      :predicate '(not (string= (buffer-name) "*terminal*"))
      "SPC" 'aking/yas-expand-or-self-insert
      "C-c C-h" '(lambda () (interactive) (yas-expand-snippet (yas-lookup-snippet "un")))

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
      "n" 'aking/self-insert-or-expand)

;; }}}

;;;;                      operator              {{{
(gmap  :states 'operator
       "s" 'evil-end-of-line
       "r" 'evil-first-non-blank
       "n" 'evil-snipe-t
       "h" 'evil-snipe-T
       "o" 'evil-forward-WORD-end)

;; }}}

;;;; PREFIX MAP {{{


;; (gmap :states '(normal)
;;       "u"
;;       (gkd 'evil-forward-word-end :timeout 0.3
;;            "c"
;;            (gkd 'current-file-name :timeout 0.5
;;                 "s" (gsk "c f")
;;                 "h" (gsk "c F"))
;;            ))

(gmap :states '(motion normal visual insert)
      "C-M-c"
      (gkd (gsk "C-c C-e") :timeout 0.3
           "b" (gsk "C-c C-f C-b")
           ;; "m" (gsk "C-c C-f C-t")
           "t" (gsk "C-c C-f C-i")
           ))


;; (gmap :states '(insert)
;;       "u"
;;       (gkd 'self-insert-command :timeout 0.5
;;         "h" 'aking/normal-and-undo))

;;;; }}}

;; (bmap :keymaps 'my-mode-map
;;       :states '(normal operator motion visual)
;;       "s" 'evil-forward-char
;;       "/" 'evil-ex-search-forward
;;       )

