;; -*- mode: emacs-lisp -*-

(defun dotspacemacs/layers ()
  ;; conf {{{
  "Configuration Layers declaration.
You should not put any user code in this function besides modifying the variable
values."
  (setq-default
   ;; Base distribution to use. This is a layer contained in the directory
   ;; `+distribution'. For now available distributions are `spacemacs-base'
   ;; or `spacemacs'. (default 'spacemacs)
   dotspacemacs-distribution 'spacemacs
   ;; Lazy installation of layers (i.e. layers are installed only when a file
   ;; with a supported type is opened). Possible values are `all', `unused'
   ;; and `nil'. `unused' will lazy install only unused layers (i.e. layers
   ;; not listed in variable `dotspacemacs-configuration-layers'), `all' will
   ;; lazy install any layer that support lazy installation even the layers
   ;; listed in `dotspacemacs-configuration-lnilayers'. `nil' disable the lazy
   ;; installation feature and you have to explicitly list a layer in the
   ;; variable `dotspacemacs-configuration-layers' to install it.
   ;; (default 'unused)
   dotspacemacs-enable-lazy-installation 'unused
   ;; If non-nil then Spacemacs will ask for confirmation before installing
   ;; a layer lazily. (default t)
   dotspacemacs-ask-for-lazy-installation t
   ;; If non-nil layers with lazy install support are lazy installed.
   ;; List of additional paths where to look for configuration layers.
   ;; Paths must have a trailing slash (i.e. `~/.mycontribs/')
   dotspacemacs-configuration-layer-path '()
   ;; }}}

   ;; layers {{{
   dotspacemacs-configuration-layers
   '(
     markdown
     vimscript
     (colors :variables
             colors-enable-nyan-cat-progress-bar nil)
     ;; colors-colorize-identifiers 'all
     (shell :variables
            ;; shell-default-height 30
            shell-default-position 'right)
     (evil-snipe  :variables
                  evil-snipe-enable-alternate-f-and-t-behaviors t)
     (c-c++ :variables
            c-c++-default-mode-for-headers 'c++-mode
            c-c++-enable-clang-support t)
     (syntax-checking :variables syntax-checking-enable-by-default nil)
     ;; semantic
     ;; cscope
     evil-commentary
     org
     common-lisp
     latex
     (latex :variables
            latex-enable-auto-fill t
            latex-enable-folding t
            ;; latex-build-command "latex"
            ;; Tex-master nil
            )
     evil-snipe
     auto-completion
     ranger
     ess
     )
   ;; }}}

   ;; additional-packages {{{
   dotspacemacs-additional-packages
   '(
     general
     qml-mode
     ;; (qml-mode :location (recipe :fetcher github :repo "emacsmirror/emacswiki.org/qml-mode.el"))
     (sxel :location (recipe :fetcher github :repo "vermiculus/sx.el"))
     (qt-pro :location (recipe :fetcher github :repo "chriskonstad/emacs/elisp/qt-pro"))
     (colorpicker :location (recipe :fetcher github :repo "syohex/emacs-colorpicker"))
     (mypackage :location (recipe :fetcher github :repo "kawabata/wolfram-mode"))
     (mypackage :location (recipe :fetcher github :repo "tequilasunset/apples-mode"))
     apples-mode
     wolfram-mode
     swiper
     delight
     key-chord
     key-seq
     fix-input
     ;; vimish-fold
     ;; vertigo
     ;; ivy
     ;; evil-smartparens
     (mypackage :location (recipe :fetcher github :repo "modelica-tools/modelica-mode"))
     (mypackage :location (recipe :fetcher github :repo "zenozeng/yafolding.el"))
     ;; (mypackage :location (recipe :fetcher github :repo "gregsexton/origami.el"))
     )
   ;; List of configuration layers lls onlnily thnile used packages but won't uninstall
   ;; them if they become unused. `all' installs *all* packages supported by
   ;; Spacemacs and never uninstall them. (default is `used-only')
   dotspacemacs-install-packages 'used-only)
  ;; }}}
  )

;; dotspacemacs/init {{{
(defun dotspacemacs/init ()
  "Initialization function.
This function is called at the very startup of Spacemacs initialization
before layers configuration.
You should not put any user code in there besides modifying the variable
values."
  ;; This setq-default sexp is an exhaustive list of all the supported
  ;; spacemacs settings.
  (setq-default
   ;; If non nil ELPA repositories are contacted via HTTPS whenever it's
   ;; possible. Set it to nil if you have no way to use HTTPS in your
   ;; environment, otherwise it is strongly recommended to let it set to t.
   ;; This variable has no effect if Emacs is launched with the parameter
   ;; `--insecure' which forces the value of this variable to nil.
   ;; (default t)
   dotspacemacs-elpa-https t
   ;; Maximum allowed time in seconds to contact an ELPA repository.
   dotspacemacs-elpa-timeout 5
   ;; If non nil then spacemacs will check for updates at startup
   ;; when the current branch is not `develop'. Note that checking for
   ;; new versions works via git commands, thus it calls GitHub services
   ;; whenever you start Emacs. (default nil)
   dotspacemacs-check-for-update nil
   ;; If non-nil, a form that evaluates to a package directory. For example, to
   ;; use different package directories for different Emacs versions, set this
   ;; to `emacs-version'.
   dotspacemacs-elpa-subdirectory nil
   ;; One of `vim', `emacs' or `hybrid'.
   ;; `hybrid' is like `vim' except that `insert state' is replaced by the
   ;; `hybrid state' with `emacs' key bindings. The value can also be a list
   ;; with `:variables' keyword (similar to layers). Check the editing styles
   ;; section of the documentation for details on available variables.
   ;; (default 'vim)
   dotspacemacs-editing-style 'vim
   ;; If non nil output loading progress in `*Messages*' buffer. (default nil)
   dotspacemacs-verbose-loading nil
   ;; Specify the startup banner. Default value is `official', it displays
   ;; the official spacemacs logo. An integer value is the index of text
   ;; banner, `random' chooses a random text banner in `core/banners'
   ;; directory. A string value must be a path to an image format supported
   ;; by your Emacs build.
   ;; If the value is nil then no banner is displayed. (default 'official)
   dotspacemacs-startup-banner 'official
   ;; List of items to show in startup buffer or an association list of
   ;; the form `(list-type . list-size)`. If nil then it is disabled.
   ;; Possible values for list-type are:
   ;; `recents' `bookmarks' `projects' `agenda' `todos'."
   ;; List sizes may be nil, in which case
   ;; `spacemacs-buffer-startup-lists-length' takes effect.
   dotspacemacs-startup-lists '((recents . 5)
                                (projects . 7))
   ;; True if the home buffer should respond to resize events.
   dotspacemacs-startup-buffer-responsive t
   ;; Default major mode of the scratch buffer (default `text-mode')
   dotspacemacs-scratch-mode 'text-mode
   ;; List of themes, the first of the list is loaded when spacemacs starts.
   ;; Press <SPC> T n to cycle to the next theme in the list (works great
   ;; with 2 themes variants, one dark and one light)
   dotspacemacs-themes '(spacemacs-dark
                         spacemacs-light)
   ;; If non nil the cursor color matches the state color in GUI Emacs.
   dotspacemacs-colorize-cursor-according-to-state t
   ;; Default font, or prioritized list of fonts. `powerline-scale' allows to
   ;; quickly tweak the mode-line size to make separators look not too crappy.
   dotspacemacs-default-font '("Source Code Pro"
                               :size 13
                               :weight normal
                               :width normal
                               :powerline-scale 1.1)
   ;; The leader key
   dotspacemacs-leader-key ","
   ;; The key used for Emacs commands (M-x) (after pressing on the leader key).
   ;; (default "SPC")
   dotspacemacs-emacs-command-key ","
   ;; The key used for Vim Ex commands (default ":")
   dotspacemacs-ex-command-key ":"
   ;; The leader key accessible in `emacs state' and `insert state'
   ;; (default "M-m")
   dotspacemacs-emacs-leader-key "M-m"
   ;; Major mode leader key is a shortcut key which is the equivalent of
   ;; pressing `<leader> m`. Set it to `nil` to disable it. (default ",")
   dotspacemacs-major-mode-leader-key "`'"
   ;; Major mode leader key accessible in `emacs state' and `insert state'.
   ;; (default "C-M-m")
   dotspacemacs-major-mode-emacs-leader-key "C-M-m"
   ;; These variables control whether separate commands are bound in the GUI to
   ;; the key pairs C-i, TAB and C-m, RET.
   ;; Setting it to a non-nil value, allows for separate commands under <C-i>
   ;; and TAB or <C-m> and RET.
   ;; In the terminal, these pairs are generally indistinguishable, so this only
   ;; works in the GUI. (default nil)
   dotspacemacs-distinguish-gui-tab nil
   ;; If non nil `Y' is remapped to `y$' in Evil states. (default nil)
   dotspacemacs-remap-Y-to-y$ nil
   ;; If non-nil, the shift mappings `<' and `>' retain visual state if used
   ;; there. (default t)
   dotspacemacs-retain-visual-state-on-shift t
   ;; If non-nil, J and K move lines up and down when in visual mode.
   ;; (default nil)
   dotspacemacs-visual-line-move-text nil
   ;; If non nil, inverse the meaning of `g' in `:substitute' Evil ex-command.
   ;; (default nil)
   dotspacemacs-ex-substitute-global nil
   ;; Name of the default layout (default "Default")
   dotspacemacs-default-layout-name "Default"
   ;; If non nil the default layout name is displayed in the mode-line.
   ;; (default nil)
   dotspacemacs-display-default-layout nil
   ;; If non nil then the last auto saved layouts are resume automatically upon
   ;; start. (default nil)
   dotspacemacs-auto-resume-layouts nil
   ;; Size (in MB) above which spacemacs will prompt to open the large file
   ;; literally to avoid performance issues. Opening a file literally means that
   ;; no major mode or minor modes are active. (default is 1)
   dotspacemacs-large-file-size 1
   ;; Location where to auto-save files. Possible values are `original' to
   ;; auto-save the file in-place, `cache' to auto-save the file to another
   ;; file stored in the cache directory and `nil' to disable auto-saving.
   ;; (default 'cache)
   dotspacemacs-auto-save-file-location 'cache
   ;; Maximum number of rollback slots to keep in the cache. (default 5)
   dotspacemacs-max-rollback-slots 5
   ;; If non nil, `helm' will try to minimize the space it uses. (default nil)
   dotspacemacs-helm-resize nil
   ;; if non nil, the helm header is hidden when there is only one source.
   ;; (default nil)
   dotspacemacs-helm-no-header nil
   ;; define the position to display `helm', options are `bottom', `top',
   ;; `left', or `right'. (default 'bottom)
   dotspacemacs-helm-position 'bottom
   ;; Controls fuzzy matching in helm. If set to `always', force fuzzy matching
   ;; in all non-asynchronous sources. If set to `source', preserve individual
   ;; source settings. Else, disable fuzzy matching in all sources.
   ;; (default 'always)
   dotspacemacs-helm-use-fuzzy 'always
   ;; If non nil the paste micro-state is enabled. When enabled pressing `p`
   ;; several times cycle between the kill ring content. (default nil)
   dotspacemacs-enable-paste-transient-state nil
   ;; Which-key delay in seconds. The which-key buffer is the popup listing
   ;; the commands bound to the current keystroke sequence. (default 0.4)
   dotspacemacs-which-key-delay 0.4
   ;; Which-key frame position. Possible values are `right', `bottom' and
   ;; `right-then-bottom'. right-then-bottom tries to display the frame to the
   ;; right; if there is insufficient space it displays it at the bottom.
   ;; (default 'bottom)
   dotspacemacs-which-key-position 'bottom
   ;; If non nil a progress bar is displayed when spacemacs is loading. This
   ;; may increase the boot time on some systems and emacs builds, set it to
   ;; nil to boost the loading time. (default t)
   dotspacemacs-loading-progress-bar t
   ;; If non nil the frame is fullscreen when Emacs starts up. (default nil)
   ;; (Emacs 24.4+ only)
   dotspacemacs-fullscreen-at-startup nil
   ;; If non nil `spacemacs/toggle-fullscreen' will not use native fullscreen.
   ;; Use to disable fullscreen animations in OSX. (default nil)
   dotspacemacs-fullscreen-use-non-native nil
   ;; If non nil the frame is maximized when Emacs starts up.
   ;; Takes effect only if `dotspacemacs-fullscreen-at-startup' is nil.
   ;; (default nil) (Emacs 24.4+ only)
   dotspacemacs-maximized-at-startup t
   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's active or selected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-active-transparency 90
   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's inactive or deselected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-inactive-transparency 90
   ;; If non nil show the titles of transient states. (default t)
   dotspacemacs-show-transient-state-title t
   ;; If non nil show the color guide hint for transient state keys. (default t)
   dotspacemacs-show-transient-state-color-guide t
   ;; If non nil unicode symbols are displayed in the mode line. (default t)
   dotspacemacs-mode-line-unicode-symbols t
   ;; If non nil smooth scrolling (native-scrolling) is enabled. Smooth
   ;; scrolling overrides the default behavior of Emacs which recenters point
   ;; when it reaches the top or bottom of the screen. (default t)
   dotspacemacs-smooth-scrolling t
   ;; If non nil line numbers are turned on in all `prog-mode' and `text-mode'
   ;; derivatives. If set to `relative', also turns on relative line numbers.
   ;; (default nil)
   dotspacemacs-line-numbers nil
   ;; Code folding method. Possible values are `evil' and `origami'.
   ;; (default 'evil)
   dotspacemacs-folding-method 'origami
   ;; If non-nil smartparens-strict-mode will be enabled in programming modes.
   ;; (default nil)
   dotspacemacs-smartparens-strict-mode nil
   ;; If non-nil pressing the closing parenthesis `)' key in insert mode passes
   ;; over any automatically added closing parenthesis, bracket, quote, etc…
   ;; This can be temporary disabled by pressing `C-q' before `)'. (default nil)
   dotspacemacs-smart-closing-parenthesis nil
   ;; Select a scope to highlight delimiters. Possible values are `any',
   ;; `current', `all' or `nil'. Default is `all' (highlight any scope and
   ;; emphasis the current one). (default 'all)
   dotspacemacs-highlight-delimiters 'all
   ;; If non nil, advise quit functions to keep server open when quitting.
   ;; (default nil)
   ;; 'all nil
   dotspacemacs-persistent-server nil
   ;; List of search tool executable names. Spacemacs uses the first installed
   ;; tool of the list. Supported tools are `ag', `pt', `ack' and `grep'.
   ;; (default '("ag" "pt" "ack" "grep"))
   dotspacemacs-search-tools '("ag" "pt" "ack" "grep")
   ;; The default package repository used if no explicit repository has been
   ;; specified with an installed package.
   ;; Not used for now. (default nil)
   dotspacemacs-default-package-repository nil
   ;; Delete whitespace while saving buffer. Possible values are `all'
   ;; to aggressively delete empty line and long sequences of whitespace,
   ;; `trailing' to delete only the whitespace at end of lines, `changed'to
   ;; delete only whitespace for changed lines or `nil' to disable cleanup.
   ;; (default nil)
   dotspacemacs-whitespace-cleanup nil
   ))
;; }}}

;; dotspacemacs/user-init {{{
(defun dotspacemacs/user-init ()
  ;; (setq initial-frame-alist '((top . 30) (left . 700) (width . 212) (height . 81)))
  ;; (setq dotspacemacs-delete-orphan-packages nil)
  "Initialization function for user code.
It is called immediately after `dotspacemacs/init', before layer configuration
executes.
 This function is mostly useful for variables that need to be set
before packages are loaded. If you are unsure, you should try in setting them in
`dotspacemacs/user-config' first."
  )
;; }}}

(defun dotspacemacs/user-config ()
  ;; global vars {{{
  ;; (defvar projectile-main-project) (setq projectile-main-project nil)
  ;; }}}

  ;; borderless {{{
  (setq frame-resize-pixelwise t)
  ;; (setq ns-auto-hide-menu-bar t)
  ;; (tool-bar-mode 0)
  (setq ns-use-title-bar nil) ;; brew reinstall emacs-plus --with-no-title-bars
  ;; }}}

  ;; input sources {{{
  (fix-input "english-dvorak"   ;; matches alternative layout
             "russian-computer" ;; works with QWERTY
             "dvorak-russian")  ;; name of new input method that preserves
  ;; }}}

  ;; key-chord {{{
  (use-package key-chord :ensure t
    :defer 1 ; do not load right at startup
    :config
    (setq key-chord-two-keys-delay 0.2)
    (key-chord-mode 1)
    (use-package key-seq :ensure t
      :config
      (key-seq-define my-mode-map "mv" #'helm-projectile-find-file)
      ;; (key-seq-define my-mode-map "mw" 'helm-buffers-list)
      (key-seq-define my-mode-map "mw" 'helm-semantic-or-imenu)))

  ;; }}}

  ;; modes {{{
  ;; My-Mode {{{
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

  ;; (delight 'my-mode nil my-mode) ; do not display mode name in mode line

  ;; (evil-make-overriding-map my-mode-map 'no
  (add-to-list 'emulation-mode-map-alists `((my-mode . ,my-mode-map)))
  ;; }}}

  ;; term-Mode {{{
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

  ;; non-term-mode {{{
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

  ;; (delight 'non-term-mode nil non-term-mode) ; do not display mode name in mode line

  (add-to-list 'emulation-mode-map-alists `((non-term-mode . ,non-term-mode-map)))
  ;; }}}
  ;; }}}

  ;; folding {{{
  (add-hook 'emacs-lisp-mode-hook
            (lambda ()
              (setq-local origami-fold-style 'triple-braces)))

  ;; different fold engines for different modes
  (defun fold-show-all ()
    (interactive)
    (cond ((or (string= (message "%s" major-mode) "nxml-mode"))
           (hs-show-all))
          ((string= (message "%s" major-mode) "modelica-mode")
           (outline-show-subtree))
          (t (origami-open-all-nodes (current-buffer)))))

  (defun fold-toggle ()
    (interactive)
    (cond ((or (string= (message "%s" major-mode) "nxml-mode"))
           (hs-toggle-hiding))
          ((string= (message "%s" major-mode) "modelica-mode")
           (outline-show-subtree))
          (t (origami-forward-toggle-node (current-buffer) (point)))))

  (defun fold-open ()
    (interactive)
    (cond ((or (string= (message "%s" major-mode) "nxml-mode"))
           (progn (save-excursion
                    (hs-show-block))))
          ((string= (message "%s" major-mode) "modelica-mode")
           (outline-hide-other))
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
          (t (origami-close-all-nodes (current-buffer)))))


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

  (defun fold-hide-except ()
    (interactive)
    (fold-reduce)
    (fold-open))

  (advice-add #'helm-swoop :before #'fold-show-all)
  (advice-add #'helm-swoop :after #'fold-hide-except)

  ;; nXML folding using hide-show
  (add-to-list 'hs-special-modes-alist
               '(nxml-mode
                 "<!--\\|<[^/>]*[^/]>"
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

  ;; ex-commands {{{
  (evil-define-command indent-buffer ()
    (c-set-style "myC")
    (spacemacs/indent-region-or-buffer))

  (evil-define-command current-file-name ()
    "Copy the current buffer file name to the clipboard."
    (let ((filename (if (equal major-mode 'dired-mode)
                        default-directory
                      (buffer-file-name))))
      (when filename
        (kill-new filename)
        (message "Copied buffer file name '%s' to the clipboard." filename))))

  (evil-define-command current-file-dir ()
    "Copy the current buffer file name to the clipboard."
    (let ((filename (if (equal major-mode 'dired-mode)
                        default-directory
                      (buffer-file-name))))
      (when filename
        (kill-new (file-name-directory filename))
        (message "Copied buffer file name '%s' to the clipboard." (file-name-directory filename)))))

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


  (evil-define-command reset-input-method ()
    (if (or (evil-normal-state-p) (string= current-input-method "dvorak-russian"))
        (toggle-input-method)
      (setq unread-command-events (listify-key-sequence "ts"))))

  (evil-define-command russian-input-method ()
    (message current-input-method)
    (if (string= current-input-method "dvorak-russian")
        (if (string= evil-state "insert")(insert "ва"))
      (set-input-method 'dvorak-russian)))

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
    (find-file (expand-file-name "~/Dropbox/Settings/Emacs/myinit.org")))
  (evil-define-command latex-build ()
    (evil-write-all nil)
    (latex/build))
  (evil-define-command latex-preview ()
    (evil-write-all nil)
    (preview-document))

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
      (open-line 1)
      (next-line 1)
      (yank))
     ((string= evil-state "visual")
      (setq size (- (region-end) (region-beginning)))
      (evil-delete (region-beginning) (region-end))
      (yank)
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

  (evil-ex-define-cmd "te" 'switch-term)
  (evil-ex-define-cmd "wu" 'save-reload-init)
  (evil-ex-define-cmd "wur" 'save-restart-resume)
  (evil-ex-define-cmd "wuu" 'save-restart)
  (evil-ex-define-cmd "ec" 'edit-config)
  (evil-ex-define-cmd "ecc" 'spacemacs/find-dotfile)
  (evil-ex-define-cmd "ecc" 'spacemacs/find-dotfile)
  ;; }}}

  ;; REMAP {{{

  (setq karab-pref "C-x C-x C-x ")
  (setq pref "C-x C-x C-x C-c ")

  (use-package general :ensure t
    :config
    (general-evil-setup t)
    (general-create-definer gen-map)
    (general-create-definer gmap)
    (general-create-definer globmap :keymaps 'my-mode-map))


  (defun not-dired ()
    (and (not (string= (message "%s" major-mode) "image-dired-thumbnail-mode"))
         (not (string= (message "%s" major-mode) "sx-question-list-mode"))
         (not (string= (message "%s" major-mode) "sx-inbox-mode"))
         (not (string= (message "%s" major-mode) "dired-mode"))))

  ;; =============================================
  ;; dired mode
  (gen-map :keymaps 'my-mode-map
           :states '(normal motion visual)
           "s" 'evil-snipe-s
           "r" 'evil-snipe-S)

  ;; =============================================
  ;; global map (my-mode) ALL STATES
  (globmap  "M-r" 'compile-project
            "M-s" 'cpp-terminate-line
            "M-b" 'backward-word
            "M-n" 'forward-word
            "C-M-b" 'backward-char
            "C-M-n" 'forward-char
            "M-t" 'evil-delete-backward-word ; C-M-Del
            "C-M-t" 'backward-delete-char ; C-M-Del
            "C-w C-q" 'spacemacs/delete-window
            "C-M-h" 'vescribe-key)

  (globmap  :prefix karab-pref
            "C-M-d" 'kill-word ; C-M-Del
            "C-d" 'backward-kill-line ; C-Del
            "C-x C-d" 'kill-line) ; H-Del


  (globmap :prefix karab-pref
           "o" 'helm-projectile-switch-project
           "n" 'evil-window-right
           "t" 'evil-window-left
           "r" 'evil-window-up
           "s" 'evil-window-down
           "-" 'spacemacs/delete-window
           "\\" 'spacemacs/kill-this-buffer
           "C-c -" 'spacemacs/kill-this-buffer
           "d" 'duplicate-line
           "C-s" 'reset-input-method
           "C-r" 'russian-input-method)

  (globmap :prefix pref
           "b d" 'spacemacs/kill-this-buffer
           "p" 'helm-projectile-switch-project
           "o" 'helm-projectile-switch-project
           "d" 'project-dired
           "n b" 'previous-buffer
           "b n" 'next-buffer
           "c c" 'spacemacs/find-dotfile
           "w u" 'save-reload-init
           "w q a" 'evil-save-and-quit
           "w a" 'evil-save-and-quit
           "t e" 'switch-term
           "r" 'save-restart-resume
           "i" '(lambda () (interactive) (deactivate-input-method)))

  ;; =============================================
  ;; NORMAL STATE map (сначала normal, потом motion)
  (globmap :states 'normal
           "Y" 'yank-till-line-end
           "V" 'select-till-line-end
           "z m" 'fold-reduce
           "z a" 'fold-toggle
           "z u" 'fold-hide-except
           "z r" 'fold-show-all
           "?" 'evil-surround-change
           "L" 'evil-replace-state
           "U" 'undo-tree-redo
           "C-r" 'latex-preview
           "M-i" 'indent-buffer
           )

  (globmap :states 'normal
           :predicate '(not-dired)
           "m" 'evil-replace)

  ;; NEW REMAP
  ;; j - evil-next-line
  ;; k - evil-previous-line
  ;; . - evil-repeat
  ;; > - evil-shift-right
  ;; u - undo-tree-undo
  ;; y - evil-yank
  ;; Y - yank-till-line-end
  ;; J - evil-join
  (globmap :states 'normal
           ;; up/down
           "." 'evil-next-line
           ">" 'evil-scroll-down
           "u" 'evil-previous-line
           "U" 'evil-scroll-up

           ;; yank/paste
           "j" 'evil-paste-after
           "J" 'evil-paste-before
           "k" 'evil-yank
           "K" 'evil-join

           ;; undo
           "y" 'undo-tree-undo
           "Y" 'undo-tree-redo

           ;; dot >>>>
           "p" 'evil-repeat
           "P" 'evil-shift-right
           )

  ;; =============================================
  ;; INSERT STATE map (сначала normal, потом motion)

  (globmap :states 'insert
           "C-t" 'yas-expand
           "C-c C-l" 'helm-colors)

  (gen-map :keymaps 'helm-color-map
           "RET" 'helm-color-run-insert-rgb
           "C-c C-r" 'helm-color-run-insert-rgb)

  ;; (helm-add-action-to-source "my-new-insert-rgb"
  ;;                            'helm-color-run-insert-rgb
  ;;                            helm-source-colors
  ;;                            0)

  ;; =============================================
  ;; VISUAL STATE map
  (globmap  :states 'visual
            "w" 'evil-change
            ;; "?" 'evil-surround-edit
            "V" 'select-till-line-end
            ;; "/" 'evil-surround-edit
            "P" 'evil-Surround-region
            "p" 'evil-surround-region
            "M-i" 'indent-buffer
            )

  (globmap  :states 'visual
            :prefix karab-pref
            "o" 'exchange-point-and-mark)

  ;; =============================================
  ;; OPERATOR STATE
  (globmap  :states 'operator
            "s" 'evil-snipe-s
            "p" 'evil-surround-edit)


  ;; =============================================
  ;; MOTION STATE map


  (mmap
   ;; "C-s" 'yas-next-field
   ;; "C--" 'yas-prev-field
   "/" 'helm-swoop
   "n" 'evil-forward-word-begin
   "N" 'evil-forward-WORD-begin
   "w" 'evil-search-next
   "W" 'evil-search-previous
   "C-a" 'evil-jump-forward)

  (mmap     :prefix karab-pref
            "k" 'move-text-line-up
            "j" 'move-text-line-down)

  (gmap     :states 'motion
            :prefix "SPC"
            "SPC" nil
            "c c" 'spacemacs/find-dotfile
            ;; "n b" 'previous-buffer
            ;; "b n" 'next-buffer
            ;; "e b c" 'edit-config
            "w q a" 'evil-save-and-quit
            "w r" 'save-restart-resume
            "w R" 'save-restart
            "w u" 'save-reload-init
            "d" 'projectile-dired
            "h" 'avy-goto-word-1
            "n" 'avy-goto-line

            "c n" 'current-file-name
            "c p" 'current-file-dir
            "c m" 'current-mode)

  ;; specific modes
  (gmap :states 'motion
        :keymaps '(ranger-mode-map)
        "C-t" 'ranger-prev-tab
        "C-n" 'ranger-next-tab
        "+" 'dired-create-directory)


  (gmap :states 'motion
        :keymaps '(evil-snipe-mode-map)
        ";" nil
        "," nil)

  (gmap     :states 'motion
            :keymaps '(lisp-mode-map emacs-lisp-mode-map)
            :prefix "SPC"
            "e" (general-simulate-keys ", k"))


  (mmap     :predicate '(not-dired)
            "RET" 'evil-visual-line)

  (mmap     :keymaps 'dired-mode-map
            "RET" 'dired-find-file)

  (define-key evil-insert-state-map (kbd "C-n") nil) ; terminal next-char

  ;; =============================================
  ;; terminal map
  (gen-map  :keymaps 'terminal-mode-map
            :state 'insert
            "C-r" (lambda () (interactive) (term-send-raw-string "\C-r"))
            "M-t" (lambda () (interactive) (term-send-raw-string "\M-t"))
            "C-M-t" (lambda () (interactive) (term-send-raw-string "\M-t"))
            "C-c C-c" (lambda () (interactive) (term-send-raw-string "\C-c")))

  ;; (gen-map  :keymaps 'term-mode-map
  ;;           :prefix karab-pref
  ;;           "M-d" (lambda () (interactive) (term-send-raw-string "\C-w"))
  ;;           "C-d" (lambda () (interactive) (term-send-raw-string "\C-u"))
  ;;           "C-M-d" (lambda () (interactive) (term-send-raw-string "\C-k"))
  ;;           "C-x C-d" (lambda () (interactive) (term-send-raw-string "\C-k")))
  ;; }}}

  ;; vertigo {{{
  (setq vertigo-home-row '(?a ?o ?e ?u ?i ?d ?h ?t ?s ?n))
  ;; }}}

  ;; main-project permanent {{{
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

  ;; }}}

  ;; some stuff {{{
  (setq avy-keys '(?a ?o ?e ?u ?h ?t ?n ?s))
  ;;}}}

  ;; LaTex {{{
  (setq LaTeX-math-abbrev-prefix ",")

  ;; test inner {{{
  (put 'TeX-command-extra-options 'safe-local-variable 'stringp)
  ;; (define-key global-map (kbd "M-r") 'latex-build)
  ;; }}}


  (put 'helm-make-build-dir 'safe-local-variable 'stringp)
  ;; }}}

  ;; ESS {{{
  ;; (add-hook 'ess-mode-hook
  ;;           (lambda ()
  ;;             (ess-toggle-underscore nil)))
  ;; }}}

  ;; helm-swoop {{{
  ;; (helm-autoresize-mode 1)
  ;; (setq helm-swoop-pre-input-function
  ;;       (lambda () (if (boundp 'helm-swoop-pattern)
  ;;                      helm-swoop-pattern "")))
  ;; (setq helm-split-window-default-side 'above)
  ;; ;; (helm-autoresize-min-height 10)
  ;; (helm-autoresize-max-height 30)
  ;; }}}

  ;; build-run {{{
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

  (evil-define-command compile-project ()
    (if (string= evil-state "insert") (evil-normal-state))
    (cond ((or (string= (message "%s" major-mode) "wolfram-mode"))
           (mathematica-run))
          ((or (string= (message "%s" major-mode) "modelica-mode"))
           (evil-write-all nil)
           (kill-new (concat default-directory "simulate.m"))
           (compile compile-command))
          ((or (string= (message "%s" major-mode) "latex-mode"))
           (latex-build))
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

  (evil-ex-define-cmd "cp" 'compile-project)
  (evil-ex-define-cmd "me" 'mathematica-run)
  ;; }}}

  ;; filetype specific {{{
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

  (add-hook 'term-mode-hook
            (lambda ()
              ;; (define-key my-mode-map (kbd "M-n") nil)
              (non-term-mode 0)
              (terminal-mode 1)
              ;; (define-key evil-insert-state-map (kbd "M-n") nil)
              ;; (define-key my-mode-map (kbd "M-DEL") '(lambda () (interactive) (term-send-raw-string "\C-w")))
              ;; (define-key my-mode-map (kbd "C-DEL") '(lambda () (interactive) (term-send-raw-string "\C-u")))
              ;; (global-set-key [C-M-backspace] '(lambda () (interactive) (term-send-raw-string "\C-u")))
              ;; (global-set-key [C-backspace] '(lambda () (interactive) (term-send-raw-string "\C-u")))
              (define-key term-raw-map (kbd "C-r") '(lambda () (interactive) (term-send-raw-string "\C-r")))
              (define-key term-raw-map (kbd "C-h") 'describe-key)))

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

  ;; dired {{{
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

  ;; c-styles {{{
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
                      (member-init-intro . ++))))
      ))

  (defun my-indent-setup ()
    (interactive)
    (c-set-offset 'arglist-intro (* 3 c-basic-offset))
    (c-set-offset 'arglist-cont 13))

  ;; }}}

  ;; major modes {{{
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

  ;; evil-snipe {{{
  (evil-snipe-override-mode 1)
  (push '(?\[ "[[{(]") evil-snipe-aliases)
  (push '(?\] "[]})]") evil-snipe-aliases)
  ;; }}}

  ;; (setq image-dired-thumb-width 100)

  ;; (setq ranger-show-hidden nil)
  ;; (setq dired-omit-mode t)

  ;; misc {{{
  ;; selection to litte finger
  (add-hook 'helm-mode-hook (lambda ()
                              (define-key helm-buffer-map (kbd "C-M-SPC") 'helm-toggle-visible-mark)
                              (define-key helm-buffer-map (kbd "C-H") 'describe-key)))


  ;; snippet inside snippet bug workaround
  (add-hook 'yas-before-expand-snippet-hook (lambda ()
                                              (ignore-errors (insert "a") (delete-char -1 nil))))

  ;; latex preview size
  (set-default 'preview-scale-function 1.2)
  ;; }}}

  (setq debug-on-error t)
  (setq compilation-skip-threshold 2)
  ;; org {{{
  ;; (org-babel-load-file (expand-file-name "~/Dropbox/Settings/Emacs/myinit.org"))
  ;; }}}

  ;; old ugly stuff {{{
  ;; (custom-set-variables
  ;;  ;; custom-set-variables was added by Custom.
  ;;  ;; If you edit it by hand, you could mess it up, so be careful.
  ;;  ;; Your init file should contain only one such instance.
  ;;  ;; If there is more than one, they won't work right.
  ;;  '(ansi-color-names-vector
  ;;    ["black" "#d55e00" "#009e73" "#f8ec59" "#0072b2" "#cc79a7" "#56b4e9" "white"])
  ;;  '(blink-cursor-mode nil)
  ;;  '(column-number-mode nil)
  ;;  '(custom-safe-themes
  ;;    (quote
  ;;     ("bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" default)))
  ;;  '(evil-want-Y-yank-to-eol nil)
  ;;  '(package-selected-packages
  ;;    (quote
  ;;     (colorpicker rainbow-mode rainbow-identifiers color-identifiers-mode auctex-latexmk xterm-color ws-butler wolfram-mode window-numbering which-key volatile-highlights vi-tilde-fringe uuidgen use-package toc-org swiper stickyfunc-enhance srefactor spacemacs-theme spaceline slime-company shell-pop restart-emacs request rainbow-delimiters quelpa popwin persp-mode pcre2el paradox origami org-projectile org-present org-pomodoro org-plus-contrib org-download org-bullets open-junk-file neotree mypackage multi-term move-text lorem-ipsum linum-relative link-hint key-seq info+ indent-guide ido-vertical-mode hungry-delete htmlize hl-todo highlight-parentheses highlight-numbers highlight-indentation hide-comnt help-fns+ helm-themes helm-swoop helm-projectile helm-mode-manager helm-make helm-flx helm-descbinds helm-cscope helm-company helm-c-yasnippet helm-ag google-translate golden-ratio gnuplot general flx-ido fix-input fill-column-indicator fancy-battery eyebrowse expand-region exec-path-from-shell evil-visualstar evil-visual-mark-mode evil-unimpaired evil-tutor evil-surround evil-snipe evil-search-highlight-persist evil-numbers evil-mc evil-matchit evil-lisp-state evil-indent-plus evil-iedit-state evil-exchange evil-escape evil-ediff evil-commentary evil-args evil-anzu eval-sexp-fu eshell-z eshell-prompt-extras esh-help dumb-jump disaster delight define-word company-statistics company-c-headers company-auctex common-lisp-snippets column-enforce-mode cmake-mode clean-aindent-mode clang-format auto-yasnippet auto-highlight-symbol apples-mode aggressive-indent adaptive-wrap ace-window ace-link ace-jump-helm-line ac-ispell)))
  ;;  '(tool-bar-mode nil))
  ;; (custom-set-faces
  ;;  ;; custom-set-faces was added by Custom.
  ;;  ;; If you edit it by hand, you could mess it up, so be careful.
  ;;  ;; Your init file should contain only one such instance.
  ;;  ;; If there is more than one, they won't work right.
  ;;  )
  ;; }}}


  ;; Do not write anything past this comment. This is where Emacs will
  ;; auto-generate custom variable definitions.
  (custom-set-variables
   ;; custom-set-variables was added by Custom.
   ;; If you edit it by hand, you could mess it up, so be careful.
   ;; Your init file should contain only one such instance.
   ;; If there is more than one, they won't work right.
   '(ansi-color-names-vector
     ["black" "#d55e00" "#009e73" "#f8ec59" "#0072b2" "#cc79a7" "#56b4e9" "white"])
   '(blink-cursor-mode nil)
   '(column-number-mode nil)
   '(custom-safe-themes
     (quote
      ("bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" default)))
   '(evil-want-Y-yank-to-eol nil)
   '(package-selected-packages
     (quote
      (general helm-cscope xcscope stickyfunc-enhance srefactor apples-mode wolfram-mode mypackage origami clang-format evil-smartparens key-seq delight vertigo helm-company helm-c-yasnippet company-statistics company-c-headers company-auctex common-lisp-snippets auto-yasnippet yasnippet ac-ispell auto-complete evil-snipe auctex-latexmk auctex slime-company company slime org-projectile org-present org org-pomodoro alert log4e gntp org-download htmlize gnuplot fix-input evil-commentary disaster cmake-mode key-chord xterm-color shell-pop multi-term helm-themes helm-swoop helm-projectile helm-mode-manager helm-flx helm-descbinds helm-ag eshell-z eshell-prompt-extras esh-help ace-jump-helm-line ws-butler window-numbering which-key wgrep volatile-highlights vi-tilde-fringe uuidgen use-package toc-org spaceline powerline smex restart-emacs request rainbow-delimiters popwin persp-mode pcre2el paradox spinner org-plus-contrib org-bullets open-junk-file neotree move-text macrostep lorem-ipsum linum-relative link-hint ivy-hydra info+ indent-guide ido-vertical-mode hydra hungry-delete hl-todo highlight-parentheses highlight-numbers parent-mode highlight-indentation hide-comnt help-fns+ helm-make helm helm-core google-translate golden-ratio flx-ido flx fill-column-indicator fancy-battery eyebrowse expand-region exec-path-from-shell evil-visualstar evil-visual-mark-mode evil-unimpaired evil-tutor evil-surround evil-search-highlight-persist evil-numbers evil-nerd-commenter evil-mc evil-matchit evil-lisp-state smartparens evil-indent-plus evil-iedit-state iedit evil-exchange evil-escape evil-ediff evil-args evil-anzu anzu evil goto-chg undo-tree eval-sexp-fu highlight elisp-slime-nav dumb-jump popup f s diminish define-word counsel-projectile projectile pkg-info epl counsel swiper ivy column-enforce-mode clean-aindent-mode bind-map bind-key auto-highlight-symbol auto-compile packed dash async aggressive-indent adaptive-wrap ace-window ace-link avy quelpa package-build spacemacs-theme)))
   '(tool-bar-mode nil))
  (custom-set-faces
   ;; custom-set-faces was added by Custom.
   ;; If you edit it by hand, you could mess it up, so be careful.
   ;; Your init file should contain only one such instance.
   ;; If there is more than one, they won't work right.
   ))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["black" "#d55e00" "#009e73" "#f8ec59" "#0072b2" "#cc79a7" "#56b4e9" "white"])
 '(blink-cursor-mode nil)
 '(column-number-mode nil)
 '(custom-safe-themes
   (quote
    ("bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" default)))
 '(evil-want-Y-yank-to-eol nil)
 '(package-selected-packages
   (quote
    (rainbow-mode rainbow-identifiers colorpicker color-identifiers-mode sxel ranger ess-smart-equals ess-R-object-popup ess-R-data-view ctable ess julia-mode qml-mode mmm-mode markdown-toc markdown-mode gh-md vimrc-mode dactyl-mode flycheck-pos-tip pos-tip flycheck general helm-cscope xcscope stickyfunc-enhance srefactor apples-mode wolfram-mode mypackage origami clang-format evil-smartparens key-seq delight vertigo helm-company helm-c-yasnippet company-statistics company-c-headers company-auctex common-lisp-snippets auto-yasnippet yasnippet ac-ispell auto-complete evil-snipe auctex-latexmk auctex slime-company company slime org-projectile org-present org org-pomodoro alert log4e gntp org-download htmlize gnuplot fix-input evil-commentary disaster cmake-mode key-chord xterm-color shell-pop multi-term helm-themes helm-swoop helm-projectile helm-mode-manager helm-flx helm-descbinds helm-ag eshell-z eshell-prompt-extras esh-help ace-jump-helm-line ws-butler window-numbering which-key wgrep volatile-highlights vi-tilde-fringe uuidgen use-package toc-org spaceline powerline smex restart-emacs request rainbow-delimiters popwin persp-mode pcre2el paradox spinner org-plus-contrib org-bullets open-junk-file neotree move-text macrostep lorem-ipsum linum-relative link-hint ivy-hydra info+ indent-guide ido-vertical-mode hydra hungry-delete hl-todo highlight-parentheses highlight-numbers parent-mode highlight-indentation hide-comnt help-fns+ helm-make helm helm-core google-translate golden-ratio flx-ido flx fill-column-indicator fancy-battery eyebrowse expand-region exec-path-from-shell evil-visualstar evil-visual-mark-mode evil-unimpaired evil-tutor evil-surround evil-search-highlight-persist evil-numbers evil-nerd-commenter evil-mc evil-matchit evil-lisp-state smartparens evil-indent-plus evil-iedit-state iedit evil-exchange evil-escape evil-ediff evil-args evil-anzu anzu evil goto-chg undo-tree eval-sexp-fu highlight elisp-slime-nav dumb-jump popup f s diminish define-word counsel-projectile projectile pkg-info epl counsel swiper ivy column-enforce-mode clean-aindent-mode bind-map bind-key auto-highlight-symbol auto-compile packed dash async aggressive-indent adaptive-wrap ace-window ace-link avy quelpa package-build spacemacs-theme)))
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
