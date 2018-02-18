;;;; lupan's GNU Emacs 21/20 init file (`~/.emacs')

;; Time-stamp: <2004-08-06 13:51:52 lupan>

;;;;
;;
;; Copyright (C) 2000-2002: Lukasz Pankowski <lupan@zamek.gda.pl>
;; Author: Lukasz Pankowski <lupan@zamek.gda.pl>
;; HomePage: http://zamek.gda.pl/~lupan/lupan-emacs.el
;; Modified by: <nobody>
;;
;; License: You are FREE to redistribute and/or modify this file and use
;;   portions of it for whatever you want. In case you REDISTRIBUTE
;;   MODIFIED COPIES of my init file you have to fill in "Modified by"
;;   field above or in other noticeable way mark that it is a derived
;;   work based on this file. Use your freedom with responsibility.
;;
;; Created: ~ 2000 (<< 2001-08-02)
;;



;;;; Installation
;;
;; You may put it as your emacs init file (ie. ~/.emacs), or maintain your
;; own init file and load mine from it with a command like:
;;
;; (load "~/elisp/lupan-emacs.el")
;; 
;; After it you may overwrite some settings with your own preferences
;;



;;;; A bit of wisdom
;;
;; For help on a given function point its name with the cursor (in Emacs
;; called point) and type C-h f RET (`describe-function').  For help on
;; variable type C-h v RET (`describe-variable'). Global variables are set
;; with `setq' function.  For those that are local for every buffer you may
;; set the default value using... `set-default'.
;;
;; add also the following lines to your `~/.Xdefaults' or `~/.Xresources'
;; (for Emacs <21):
;;
;;      emacs.font: -misc-fixed-medium-r-*-*-15-*-*-*-*-*-iso8859-2
;;      emacs*background: #efefef
;;
;; if you want latin2 letters in menu bar (I do not now how to set it in init file):
;;      emacs.pane.menubar.font:-*-helvetica-medium-r-*-*-14-*-*-*-*-*-iso8859-2
;;
;; suggested geometry for 1024x786, no title and WindowMaker's dockapp on
;; right:
;;
;;      emacs*geometry:         102x46+0+0



;;;; Table of contents:
;;
;; 0. Initialization (Debug helper, etc)
;; 1. Personal data
;; 2. Language environment and coding systems
;; 3. Personal taste (stuff you may not like)
;; 4. Convenience (stuff you should like)
;; 5. User keys definitions
;; 6. Multiple Major Modes
;; 7. My DEFintions of FUNctions (defuns)
;; 7.1 Wrappers around shell commands
;; 8. External packages
;; *. Disorder
;; *. Read desktop
;; *. Turn off debugging
;;



;;;; 0. Initialization (Debug helper, etc)

;;(toggle-debug-on-error)
;;(setq debug-on-error t)

(if (not (boundp 'emacs-major-version))
  (setq emacs-major-version 0))


(eval-when-compile
  (when (boundp 'byte-compile-current-file)
    (mapcar
     'require
     '(cc-vars dired ispell time tex ogonek))))



;;;; 1. Personal data

;; (setq user-mail-address "lupan@zamek.gda.pl"
;;       user-full-name "Lukasz Pankowski")



;;;; 2. Language environment and coding systems

(set-language-environment "Latin-2")    ; environment for Poland
(codepage-setup '1250)                  ; enables IBM codepage cp1250
(prefer-coding-system 'cp1250)          ; priority 3
(if (coding-system-p 'utf-8)
    (prefer-coding-system 'utf-8))      ; priority 2
(prefer-coding-system 'iso-latin-2)     ; this will be default (priority 1)


(if (not (eq window-system 'w32))
    (set-keyboard-coding-system 'iso-latin-2) ; how Emacs understands the
                                        ; keyboard

  ;; w32 (lupan, 2002-01-03 15:01:54+0100)
  (if (not (boundp 'lupan-no-mouse-set-font-p))
      (set-default-font
       "-*-Courier New-normal-r-*-*-16-120-96-96-c-*-iso8859-2"))
  ;;(prefer-coding-system 'cp1250)      ; [!] default for opened files
  (set-keyboard-coding-system 'cp1250)
  (set-clipboard-coding-system 'cp1250))

;;(if (eq window-system 'x)
;;    (set-default-font "-misc-fixed-medium-r-*-*-15-*-*-*-*-*-iso8859-2"))

;;(setq ispell-dictionary "polish")       ; current dictionary (a global
;;                                        ; variable)



;;;; 3. Personal taste

(setq my-bg-color "#ffffff")
(when window-system
  (set-background-color my-bg-color)    ; others: "ivory3" "seashell3",
                                        ; "light steel blue"
  (set-cursor-color "cornflower blue")
  (if (functionp 'blink-cursor-mode)
      (blink-cursor-mode nil))          ; turn it off
  (if (< emacs-major-version 21)
      (custom-set-faces '(modeline ((t (:bold t :inverse-video t :foreground
                                              "blue4" :background "grey80")))))
    (custom-set-faces
     `(modeline ((t (:bold t :background "blue4" :foreground ,my-bg-color
                           :box (:line-width -1 :style released-button)))))
     `(scroll-bar ((t (:background ,my-bg-color))))
     `(fringe ((((class color) (background light)) (:background ,my-bg-color))))
     `(tool-bar ((t (:background ,my-bg-color
                                 :box (:line-width -1 :style released-button)))))
     `(menu ((t (:background ,my-bg-color :family "helv"
                             :box (:line-width -1 :style released-button))))))))



(column-number-mode t)                  ; display in the mode line
(setq european-calendar-style t)
(setq mail-user-agent 'message-user-agent) ; the one from Gnus

(setq inhibit-startup-message t)        ; I have seen this enough times. Do
                                        ; not disable it in system
                                        ; defaults.
(setq c-hanging-comment-ender-p nil)    ; fill-paragraph allow alone '*/'
                                        ; in C comments
(resize-minibuffer-mode t)              ; resize if text do not fit (for emacs20)



; use secure ftp (for `M-x ftp') (needs ssh access to shell account)
(setq ftp-program "sftp")

;; allow using of `emacsclient'
;; for convenience add this to your `~/.inputrc' file:
;;       $if Bash
;;              "\C-x\C-f": "\C-aemacsclient "
;;       $endif
(when (eq system-type 'gnu/linux)
  (setq file-name-coding-system 'utf-8) ; this is future (GNOME already use it)
  (server-start))



;; [!] do NOT use unless you are ADDICTED
;;(pc-selection-mode)                   ; emulate Motif, MAC or MS-Windows
                                        ; cut and paste style.

(defun my-protect-buffer (name)
  (if (and (functionp 'protect-buffer-from-kill-mode) (get-buffer name))
      ;; I sometimes killed it by accident
      (protect-buffer-from-kill-mode 1 (get-buffer name))))

(my-protect-buffer "*scratch*")



(if (eq window-system 'x)
  (setq browse-url-browser-function 'browse-url-generic
        browse-url-generic-program "mozilla-new-tab"))

;;   (setq browse-url-browser-function 'browse-url-galeon
;;      browse-url-galeon-arguments '("--new-tab"))
;;   (setq browse-url-generic-program "epiphany"
;;      browse-url-generic-args '("-n")))

;; (setq browse-url-browser-function 'w3m-browse-url)
;; (setq browse-url-new-window-flag t)

(add-hook 'w3m-mode-hook
          (lambda ()
            (local-set-key [M-left] 'w3m-previous-buffer)
            (local-set-key [M-right] 'w3m-next-buffer)))



;; make find-file more sensitive (prefix with C-u to get default behaviour)
;; recognizes URL at point
(global-set-key "\C-x\C-f" 'ffap)
(global-set-key "\C-x4f" 'ffap-other-window)



;;;; 4. Convenience


;;; 4.1 Slow ones

(if (eq window-system 'w32)
    ;; the following require sets to many variables
    (setq max-specpdl-size 1000))
(require 'generic-x nil t)              ; additional modes ex. for apache
                                        ; httpd.conf (lupan, 2002-01-10)


;;; 4.2 Others

(setq ispell-program-name "aspell")

(global-set-key [delete] 'delete-char)  ; let delete differ from backspace

(setq display-time-24hr-format t)
(display-time)                          ; ... and mail notify in the mode
                                        ; line

(setq tex-default-mode 'latex-mode)     ; for new created `*.tex' files


(when (file-exists-p abbrev-file-name)
  (read-abbrev-file)                    ; read definitions of abbreviations
                                        ; (`~/.abbrev_defs' by default)
  (set-default 'abbrev-mode t))         ; turn on abbreviation expansion
                                        ; by default

(auto-compression-mode t)               ; automatic file compression and
                                        ; decompression

(show-paren-mode t)                     ; highlight matching parentheses


;; recognize image files and display them on finding
;; (if (and window-system (functionp 'auto-image-file-mode))
;;     (auto-image-file-mode t))
                                        ; find-file

(setq view-read-only t                  ; less alike navigation in read
                                        ; only buffers
      visible-bell t                    ; flash screen instead of making
                                        ; noise
      font-lock-support-mode 'lazy-lock-mode)
                                        ; fontifies blocks (ex. comments)
                                        ; at once (but slow :), not during
                                        ; next edition
                                        ; added (lupan, 2001-08-02 01:41:59+0200)


(if (and (eq window-system 'x) (functionp 'mouse-wheel-mode))
    (mouse-wheel-mode t))

;; buffer Makefile<1> will now be Makefile<dir> or Makefile<dir/subdir>
(if (require 'uniquify nil t)
    (setq uniquify-buffer-name-style 'post-forward-angle-brackets))

(when (or window-system (>= emacs-major-version 21))
  (global-font-lock-mode 1)             ; turn on syntax highlighting
  (transient-mark-mode t))              ; highlight marked region

(if (eq window-system nil)
    (menu-bar-mode 0)                   ; disable displaying menu bar
                                        ; if no X
  ;; Display file name or buffer name in the title bar
  ;; (lupan, 2002-04-26 21:06:47+0200)
  (setq frame-title-format
        (if (>= emacs-major-version 21)
            (list user-login-name "@" system-name ": " 
                  '(:eval (or buffer-file-name (buffer-name))))
          (list user-login-name "@" system-name ": %f"))))
  

(add-hook 'ps-mode-hook '(lambda () (setq comment-start "%")))

(add-hook 'view-mode-hook
          '(lambda ()
             ;; add to a minor mode key map `less' behaviour
             (define-key view-mode-map "b" 'View-scroll-page-backward)))

(add-hook 'eshell-mode-hook
          '(lambda ()
             ;; usual bash (and emacs) completion style
             (setq pcomplete-cycle-completions nil)))

(add-hook 'lisp-mode-hook
          '(lambda () (local-set-key "\C-cz" 'run-lisp)))

(add-hook 'Info-mode-hook
          '(lambda () (local-set-key [S-iso-lefttab] 'Info-prev-reference)))
          

;; {lookup} added (lupan, 2002-01-22 15:21:55+0100)
;; keys: q: quit, n/p: next/previous dictionary, o: full screen;
;;       SPC/BS: scroll, s: search
;; Debian Packages: lookup, dictd
(setq lookup-search-agents '((ndict "localhost"))
      lookup-enable-splash nil)
(autoload 'lookup-word "lookup" nil t)
(autoload 'lookup-pattern "lookup" nil t)

;; {ogonek} allows recoding of polish letters
;; added (lupan, 2002-02-16 11:58:05+0100)
(autoload 'ogonek-recode-buffer "ogonek" nil t)
(autoload 'ogonek-recode-region "ogonek" nil t)
(setq ogonek-from-encoding "windows-PL"
      ogonek-to-encoding "iso8859-2")


(autoload 'py-shell "python-mode" nil t)


;; based on Pymacs README
(autoload 'pymacs-load "pymacs" nil t)
(autoload 'pymacs-eval "pymacs" nil t)
(autoload 'pymacs-apply "pymacs")
(autoload 'pymacs-call "pymacs")

(defun fp-maybe-pymacs-reload ()
  (let ((pymacsdir (expand-file-name "~/elisp/python/")))
    (when (and (string-equal (file-name-directory buffer-file-name)
                             pymacsdir)
               (string-match "\\.py\\'" buffer-file-name))
      (pymacs-load (substring buffer-file-name 0 -3)))))

(add-hook 'after-save-hook 'fp-maybe-pymacs-reload)
;;


;;; svn
;; Set up autoloads for psvn (svn directory edit mode for emacs)

(autoload 'svn-status "psvn" nil t)

; Register SVN as a version control backend.  vc will lazily load the
; backend when it is needed.  Put this in /etc/emacs/site-start.d/ or
; some startup file.

(when (and (boundp 'vc-handled-backends)
           (file-exists-p "/usr/share/emacs/site-lisp/vc-svn.el"))
  (add-to-list 'vc-handled-backends 'SVN))
;;;


(defun local-set-key-if-no-binding (key command)
  (or (key-binding key)
      (local-set-key key command)))


;;; Maxima support
(add-hook 'inferior-maxima-mode-hook
          '(lambda ()
             ; They put it on M-tab, but this grabbed by almost any usable
             ; window manager and TAB is natural in a shell
             (local-set-key "\C-i" 'maxima-complete)
             (local-set-key-if-no-binding
              "\C-c\C-h" 'maxima-completion-help)))
(autoload 'maxima-mode "maxima" "Maxima mode" t)
(setq auto-mode-alist (cons '("\\.max" . maxima-mode) auto-mode-alist))



;;;; 5. User key definitions


(global-set-key "\C-c;" 'comment-region) ; not all modes sets it
(global-set-key [(shift mouse-2)] 'browse-url-at-mouse)

;; key sequences `C-c letter' are reserved for users (no modes define them)
;; (global-set-key "\C-ca" 'my-apropos)

;; some analogous to `C-x b' switch buffer
(global-set-key "\C-cbe" 'eshell)
(global-set-key "\C-cbp" 'py-shell)
(global-set-key "\C-cbm" 'maxima)
(global-set-key "\C-cby" 'yacas)
(global-set-key "\C-cbs" 'shell)
(global-set-key "\C-cbw" 'w3m)


(global-set-key "\C-cqb" 'speedbar-get-focus)
(global-set-key "\C-cqm" 'executable-set-magic)
(global-set-key "\C-ch" 'find-dired)
(global-set-key "\C-cf" 'ffap-next)
(global-set-key "\C-cg" 'goto-line)
(global-set-key "\C-ck" 'compile)
(global-set-key "\C-cql" 'locate)
(global-set-key "\C-cm" 'gnus)          ; news and mail client
(global-set-key "\C-co" 'occur)
(global-set-key "\C-cqo" 'my-grep-default-directory)
;; (global-set-key "\C-cs"
;;                 '(lambda () (interactive)
;;                    (shell-command "cdcd -d /dev/cdr status")))
(global-set-key "\C-cw" 'lookup-word)   ; see {lookup}
(global-set-key "\C-cl" 'lookup-pattern) ; see {lookup}
(global-set-key "\C-cda"
                '(lambda () (interactive)
                   (ispell-change-dictionary "american")))
(global-set-key "\C-cdb"
                '(lambda () (interactive)
                   (ispell-change-dictionary "british")))
(global-set-key "\C-cdp"
                '(lambda () (interactive)
                   (ispell-change-dictionary "polish")))
(global-set-key "\C-cqt" 'time-stamp)
(global-set-key "\C-ci" 'imenu)
(global-set-key "\C-cqi" 'ispell-buffer)
;(global-set-key [S-iso-lefttab] 'tab-to-tab-stop)

(if (functionp 'calculator)
    (global-set-key "\C-cc" 'calculator))

;; analogous to bookmark keys starting with `\C-x'
(global-set-key "\C-crl" 'w3-show-hotlist)
(global-set-key "\C-crb" 'w3-use-hotlist)

(global-set-key "\C-cqb" 'bury-buffer)
(global-set-key "\C-cqh" 'my-grep-find-headers)

(defun my-kill-buffer-other-window ()
  (interactive)
  (save-selected-window (other-window 1) (call-interactively 'kill-buffer)))
(global-set-key "\C-x4k" 'my-kill-buffer-other-window)

                                        

;;;; 6. Multiple Major Modes

;; Colorizing of php/jsp in HTML
;; to change the background of submode run `C-xC-e' after `)':
;; (customize-face 'mmm-default-submode-face)
;; to disable changing background run:
;; (setq mmm-submode-decoration-level 0)

(when (require 'mmm-mode nil t)
  (setq auto-mode-alist
        (append
         '(("\\.php[34]?\\'" . html-mode)
           ("\\.jsp\\'" . html-mode))
         auto-mode-alist))
   (setq mmm-mode-ext-classes-alist
        (append
         mmm-mode-ext-classes-alist
         '((html-mode "\\.php[34]?\\'" embedded-php)
           (html-mode "\\.jsp?\\'" embedded-jsp))))
   ;; we set "\\.php[34]?\\'" to html-mode, for php-mode not to catch
   ;; it back we set it's patterns to nil
   (setq php-file-patterns nil)         
   (mmm-add-classes
    '((embedded-php
       :submode php-mode
       :face mmm-declaration-submode-face
       :front "<\?php"
       :back "\?>")))
   (mmm-add-classes
    '((embedded-jsp
       :submode java-mode
       :face mmm-declaration-submode-face
       :front "<%"
       :back "%>")))
  (setq mmm-global-mode 'maybe))



;;;; 7. My DEFintions of FUNctions (defuns)


(defun my-color-values (name)
  (interactive "scolor name: ")
  (let* ((rgb (or (x-color-values name)
                      (error "No such color")))
         (r (car rgb))
         (g (cadr rgb))
         (b (caddr rgb)))
    (message
     (format "%0.2g %0.2g %0.2g #%02x%02x%02x"
             (/ r 65535.0) (/ g 65535.0) (/ b 65535.0)
             (/ r 256) (/ g 256) (/ b 256)))))

(defun my-hex-color-values (name insert-p)
  "Displayes a color given by NAME in hex mode (#rrggbb) with prefix inserts it
into the current buffer"
  (interactive "scolor name: \nP")
  (let* ((rgb (or (x-color-values name)
                      (error "No such color")))
         (msg (format "#%02x%02x%02x" (/ (car rgb) 256)
                      (/ (cadr rgb) 256) (/ (caddr rgb) 256))))
    (if insert-p
        (insert msg)
      (message msg))))

(defun my-apropos (str)
  "Find in my reminder notes matching a given regexp"
  (interactive "sReminder apropos: ")
  (save-excursion
    (set-buffer (find-file-noselect "~/own-doc/reminder.txt"))
    (occur str)))

(defun my-grep-find-headers (grep-regexp)
  "Finds occurrences of regexp in header files in /usr/include" 
  (interactive
   (let ((default (current-word)))
     (list (read-string
            (format "in headers: grep regexp (default %s): " default)
            nil nil default))))
  (grep-find (format "find /usr/include /usr/X11R6/include/ -type f \
| xargs grep -n -s '%s'" grep-regexp)))


(defun my-grep-default-directory (grep-regexp)
  "Finds occurrences of regexp in default directory" 
  (interactive
   (let ((default (current-word)))
     (list (read-string
            (format "default dir: grep regexp (default %s): " default)
            nil nil default))))
  (grep-find (format "find . -type f -maxdepth 1 \
| xargs grep -n -s '%s'" grep-regexp)))

;; Function to insert the current date (from gnu.emacs.help)
;; added (lupan, 2001-08-02 01:15:40+0200)
(defun insert-date-and-time ()
  "Insert the date and time into the current buffer."
  (interactive)
  (insert (format-time-string "%Y-%m-%d %H:%M:%S%z" (current-time))))

(defun me ()
  "Inserts modification information into current buffer: (lupan, DATE)"
  (interactive)
  (insert "(lupan, ")
  (insert-date-and-time)
  (insert ")"))


(defun my-average ()
  "Compute arithmetic average of all numbers in line where point (cursor)
is and display it at the bottom of the screen. All non-numeric characters
are treated as separators."
  (interactive)
  (let* ((nums (mapcar
               '(lambda (x) (float (string-to-number x)))
               (split-string (buffer-substring-no-properties
                              (line-beginning-position)
                              (line-end-position))
                             "[^-0-9eE.]+")))
         (len (length nums)))
    (message "Average: %g, (length: %d)" (/ (apply '+ nums) len) len)))


(defun my-sort-region (beg end char)
  "sorts a region as a list of strings delimited by CHAR"
  (interactive "r\ncList delimited by char: ")
  (let (list)
    (setq list (sort (split-string
                      (buffer-substring-no-properties beg end)
                      (char-to-string char)) 'string<))
    (delete-region beg end)
    (insert (mapconcat 'identity list (char-to-string char)))))

(defun my-mirror-dir (dir)
  "Makes SYMBOLIC links for all file names that exist in DIR but not in a current directory"
  (let ((files (directory-files dir)))
    (setq dir (file-name-as-directory dir))
    (while files
      (unless (file-exists-p (car files))
        (make-symbolic-link (concat dir (car files)) (car files)))
      (setq files (cdr files)) )))

(defun my-hard-mirror-dir (dir)
  "Makes HARD links for all file names that exist in DIR but not in a current directory"
  (let ((files (directory-files dir)))
    (setq dir (file-name-as-directory dir))
    (while files
      (unless (file-exists-p (car files))
        (add-name-to-file  (concat dir (car files)) (car files)))
      (setq files (cdr files)) )))


(defun my-unbreakable ()
  "Query replace one-word letters to have unbreakable space after them"
  (interactive)
  (query-replace-regexp "[ \t]+$" "")
  (query-replace " \\x" "\\x")
  (query-replace-regexp "\\( +[awizo]\\)\n? +" "\\1~"))



;;; 7.1 Wrappers around shell commands

(defun my-xlock-blank ()
  "Run xlock in a blank mode"
  (interactive)
  (shell-command "xlock -mode blank" nil))

(defun my-eject () "sh: eject" (interactive) (shell-command "eject"))

(defun my-mount-cdrom ()
  "sh: mount /cdrom" (interactive) (shell-command "mount /cdrom"))

(defun my-view-a2ps-buffer (&optional print-region)
  "Displays in gv (two pages on one) a buffer printed to a temporary file
 (or region if prefixed with an arg)"
  (interactive "P")
  (let ((temp-name (make-temp-name (expand-file-name
                                    "buffer"
                                    temporary-file-directory)))
        (buf (current-buffer)) reg-beg reg-end)
    (if print-region
        (setq reg-beg (region-beginning)
              reg-end (region-end)))
    (with-temp-file temp-name
      (if print-region
          (insert-buffer-substring buf reg-beg reg-end)
        (insert-buffer buf)))
    (start-process-shell-command
     "a2ps" "*a2ps*"
     (format
      "cat %s | a2ps --borders=no -X latin2 --stdin %s -Pdisplay && rm %s"
      (shell-quote-argument temp-name)
      (shell-quote-argument (buffer-name))
      (shell-quote-argument temp-name)))))

(defun my-view-ps-printed-buffer (&optional print-region)
  "Displays in gv (two pages on one) a buffer printed to a temporary file
 (or region if prefixed with an arg)"
  (interactive "P")
  (let ((temp-name (make-temp-name (expand-file-name
                                    "buffer"
                                    temporary-file-directory))))
    (if print-region
        (ps-print-region-with-faces (region-beginning) (region-end)
                                    temp-name)
      (ps-print-buffer-with-faces temp-name))
    (start-process-shell-command
     "gv" "*gv*" (format "gv %s && rm %s" 
                         (shell-quote-argument temp-name)
                         (shell-quote-argument temp-name)))))

(defun my-html-to-ps (file &optional wildcards)
  "Converts html file to PostScript and display it in gv"
  (interactive "fHtml file to convert: \np")
  (let ((fname (make-temp-name (expand-file-name
                                "html2ps"
                                temporary-file-directory))))
    (start-process-shell-command
     "my-html-to-ps" "*my-html-to-ps*" "/bin/sh" "-c"
     (concat
      ":; html2ps -D -n -L -2 -o "      ; `:;' is a workaround of I do not now what
      (shell-quote-argument fname) " "
      (shell-quote-argument (expand-file-name file))
      "; gv " (shell-quote-argument fname)))))

(if (eq window-system 'x)
    (progn
      (setq tex-dvi-view-command "xdvi")
      (global-set-key "\C-cp" 'my-view-ps-printed-buffer)
      (global-set-key "\C-cqp" 'my-view-a2ps-buffer)))



;;;; 8. External packages

;;; I put them in `~/elisp/' directory.
;;; (second arg of load: NOERROR)

(if (file-exists-p "~/elisp/")
    (add-to-list 'load-path "~/elisp/"))

(load "sierotki" t)                     ; inserts non-breaking space after
                                        ; polish one letter words in TeX
                                        ; modes
(if window-system
    (load "parenface" t))               ; DimGray parenthases in lisp
(load "private" t)

(autoload 'rst-mode "rst-mode" nil t)

(autoload 'song-slides-mode "song-slides" nil t)
(add-to-list 'auto-mode-alist '("\\.slajdy\\'" . song-slides-mode))

;(autoload 'htmlize-buffer "htmlize" nil t)

;; "autoload" AucTeX -- good TeX/LaTeX editing environment
;; third parameter of `require' means NOERROR, so continue if not available
;; (lupan, 2001-08-09 01:59:12+0200)
(require 'tex-site nil t)               ; loads AUC TeX,




;; ;;;; *. Disorder

(setq TeX-open-quote ",,"               ; (lupan, 2001-09-07 14:50:27+0200)
      TeX-parse-self t)                 ; (lupan, 2001-09-07 16:58:42+0200)



;; for eshell
;; as if you run them with `--interactive'
(setq eshell-rm-interactive-query t     ; (lupan, 2001-09-07 16:14:29+0200)
      eshell-cp-interactive-query t     ; (lupan, 2001-09-10 22:04:47+0200)
      eshell-mv-interactive-query t     ; (lupan, 2001-09-10 22:04:50+0200)
      eshell-visual-commands '("vi" "screen" "top" "less" "more"
                               "lynx" "ncftp" "pine" "tin" "trn" "elm"
                               "bash" "su"))
                                        ; (lupan, 2001-09-07 16:14:29+0200)

;;; XXX
(add-hook 'term-mode-hook
          '(lambda ()
             (local-set-key "\ep" 'term-previous-input)
             (local-set-key "\en" 'term-next-input)))
;              (term-set-escape-char ?\C-x))))


(defun cm (x) (* (/ x 2.54) 72))
(setq ps-print-color-p nil)     ; disable colors you may set
;; a nice look for printing command (lupan, 2001-08-31 16:24:41+0200)
(add-hook 'ps-print-hook
      '(lambda ()
         (setq ps-underlined-faces '(underline)
               ps-bold-faces (append ps-bold-faces
                                     '(haskell-keyword-face))
               ps-italic-faces (append ps-italic-faces
                                       '(haskell-comment-face
                                         haskell-constructor-face
                                         haskell-string-char-face))
               ps-number-of-columns 2
               ps-paper-type 'a4
               ps-landscape-mode t
               ps-left-margin (cm 1.5)
               ps-right-margin (cm 1.5)
               ps-inter-column (cm 1)
               ps-top-margin (cm 1)
               ps-bottom-margin (cm 1)
               ps-header-offset (cm .5))
         ;(if (string= major-mode "Info-mode")
         ;    (setq ps-font-family 'Palatino)
         ;  (setq ps-font-family 'Courier))
         ;; ps-font-family to: `Courier' `Helvetica' `Times'
         ;; `Palatino' `Helvetica-Narrow' `NewCenturySchlbk'
         ;; run (ps-line-lengths) -- good info
         ))


;; (lupan, 2002-03-12 01:09:35+0100)
;; Standard Command: `File' saves postscript file
;; Here `Gv' displayes PS file in GV
(add-hook 'LaTeX-mode-hook
          (lambda ()
            (if (boundp 'my-LaTeX-gv-added)
                nil
              (setq my-LaTeX-gv-added t)
              (setq TeX-command-list
                    (cons (list "Gv" "gv %f" 'TeX-run-discard nil nil)
                          TeX-command-list)))))


(if window-system
    ;; let `C-z' run shell if not in a shell or switch to other
    ;; buffer if in the shell mode
    (global-set-key "\C-z" 'my-eshell-toggle))

;; XXX why eshell-toggle disappeared in emacs21?
(defun my-eshell-toggle (make-cd)
  "Runs `eshell-toggle' if available or `shell' if not."
  (interactive "P")
  (cond ((require 'eshell-auto nil t) (eshell-toggle make-cd))
        ((require 'eshell nil t) 
         (if (string= (buffer-name) eshell-buffer-name)
             (if (one-window-p)
                 (switch-to-buffer nil)
               (delete-window))
           (when (one-window-p) 
             (split-window-vertically)
             (other-window 1))
           (eshell)))
        (t (shell))))

; define a proper C style && indention
; according to CodingStyle by Linus
(defun linux-c-mode ()
  "C mode with adjusted defaults for use with the Linux kernel."
  (interactive)
  (c-set-style "K&R")
  (setq c-basic-offset 8))

(add-hook 'c-mode-common-hook
          '(lambda ()
             (linux-c-mode)
             (local-set-key [S-iso-lefttab] `tab-to-tab-stop)
             (setq ispell-local-dictionary "american")))


(add-hook 'java-mode-hook '(lambda () (setq c-basic-offset 4)))


(defun my-pycheck-visited-file ()
  "Runs pychecker on file visited in current buffer"
  (interactive)
  (compile (concat "pychecker " (buffer-file-name))))

(add-hook 'python-mode-hook
          '(lambda ()
             (setq ispell-local-dictionary "american")
             (local-set-key "\C-c;" 'py-comment-region)
             (local-set-key "\C-cc" 'my-pycheck-visited-file)))

(add-hook 'find-file-hooks 'auto-insert)



;; make M-RET to run see on file, (C-RET edit) open according to MIME
;; definitions
(autoload 'dired-run-shell-command "dired-aux" "" t)
(autoload 'dired-shell-stuff-it "dired-aux" "" t)

(defun my-dired-do-see (&optional prefix)
  "run `see' command on a file (so according to mailcap)"
  (interactive)
  (apply 'start-process-shell-command
         "see" "*see*" "see"
         (dired-get-marked-files t current-prefix-arg)))

(defun my-dired-do-edit ()
  "run `edit' command on a file (so according to mailcap)"
  (interactive)
  (dired-run-shell-command
   (concat (dired-shell-stuff-it
            "edit *" (dired-get-marked-files t current-prefix-arg) t)
             "&")))
(add-hook 'dired-mode-hook
          '(lambda ()
             (local-set-key [M-return] 'my-dired-do-see)
             (local-set-key [C-return] 'my-dired-do-edit)))

(add-hook 'change-log-mode-hook
          '(lambda () (setq ispell-local-dictionary "american")))

(add-hook 'mail-setup-hook 'mail-abbrevs-setup)

(add-hook 'compilation-mode-hook
          '(lambda ()
             ;; maybe i'll find better binding for q
             (local-set-key "q" 'bury-buffer)))



;; apt-get uses `C-m', even used with `--quiet', so I prefer `C-m' to
;; be replaced with a new line, than displaying `^M'
(defun lupan-all-ctrl-m-to-ctrl-j (string)
  (while (string-match "\r" string)
    (setq string (replace-match "\n" t t string)))
  string)
(add-hook 'comint-preoutput-filter-functions 'lupan-all-ctrl-m-to-ctrl-j)

(defun my-tex-soft-newline ()
  "Inserts \\\\, than breaks a line an indent"
  (interactive)
  (insert " \\\\")
  (newline-and-indent))

(add-hook 'TeX-mode-hook
          '(lambda ()
             (setq ispell-parser 'tex)
             (setq my-tex-dvi-print-command "dvips")
             (local-set-key [S-return] 'my-tex-soft-newline) ))

(add-hook 'text-mode-hook
          '(lambda ()
             (turn-on-auto-fill)
             ;; turn on expansion of abbreviations
             (abbrev-mode t)))

(setq auto-mode-alist
      (append auto-mode-alist '(("\\.jsp\\'" . java-mode)
                                ("\\.jl$" . lisp-mode))))

(autoload 'sql-postgres "sql" "Interactive SQL mode." t)



;;;; *. Read desktop

;; desktop will not only exclude files opened by ftp (default) but also
;; .newsrc-dribble

(setq desktop-files-not-to-save
      "\\(^/[^/:]*:\\)\\|\\(.*\\.newsrc-dribble\\)")

;; Read desktop file, but only if you are the owner.  This prevents
;; stealing file permissions as root, as root you will not do other user's
;; job or you are a bit insane.
(when (and (eval-and-compile (require 'desktop nil t))
           (file-exists-p desktop-basefilename)
           (file-ownership-preserved-p desktop-basefilename))
  (desktop-load-default)         ; suggested in (emacs)Saving Emacs Session
  (condition-case error
      (desktop-read)
    (error (message "Error while running (desktop-read)"))))

;;(if (get-buffer "TODO") (switch-to-buffer "TODO"))



;;;; *. Turn off debuging
(setq debug-on-error nil)

;;(diary 7)


; ========= AUTOMATIC 
(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)
(put 'narrow-to-page 'disabled nil)
(put 'narrow-to-region 'disabled nil)

(custom-set-variables
  ;; custom-set-variables was added by Custom -- don't edit or cut/paste it!
  ;; Your init file should contain only one such instance.
 '(all-christian-calendar-holidays t t)
 '(c-font-lock-extra-types (quote ("FILE" "\\sw+_t" "integer" "logical" "real" "doublereal" "[A-Z][a-z]\\sw+" "Gtk\\sw+" "Gdk\\sw+")))
 '(frame-background-mode nil)
 '(rmail-preserve-inbox t)
 '(scheme-program-name "guile")
 '(shell-prompt-pattern "^[^#$%>
]*@[^#$%>
]*[#$%>] *")
 '(tex-open-quote ",," t)
 '(w3-default-homepage "http://localhost")
 '(w3-do-incremental-display t)
 '(w3-user-colors-take-precedence t)
 '(w3m-home-page "http://localhost")
 '(w3m-output-coding-system (quote iso-8859-2)))
(custom-set-faces
  ;; custom-set-faces was added by Custom -- don't edit or cut/paste it!
  ;; Your init file should contain only one such instance.
 '(bold ((t (:bold t :foreground "blue4"))))
 '(bold-italic ((t (:bold t :italic t :foreground "purple3"))))
 '(custom-button-face ((((type x w32 mac) (class color)) (:background "lightgrey" :foreground "black" :box (:line-width 1 :style released-button)))))
 '(custom-button-pressed-face ((t (:background "lightgrey" :foreground "black" :box (:line-width 1 :style pressed-button)))))
 '(eshell-ls-backup-face ((((class color) (background light)) (:foreground "gray40"))))
 '(eshell-prompt-face ((nil (:foreground "darkgreen" :weight bold))))
 '(font-lock-builtin-face ((t (:foreground "Orchid4"))))
 '(font-lock-comment-face ((((class color) (background light)) (:foreground "Firebrick4"))))
 '(font-lock-constant-face ((((class color) (background light)) (:foreground "SteelBlue4"))))
 '(font-lock-keyword-face ((((class color) (background light)) (:foreground "Purple3"))))
 '(font-lock-string-face ((t (:foreground "saddlebrown"))))
 '(font-lock-type-face ((((class color) (background light)) (:foreground "springgreen4"))))
 '(font-lock-variable-name-face ((((class color) (background light)) (:foreground "DarkOrange4"))))
 '(font-lock-warning-face ((((class color) (background light)) (:bold t :foreground "Red4"))))
 '(fringe ((((class color) (background light)) (:background "#ffffff"))))
 '(gnus-cite-face-5 ((((class color) (background light)) (:foreground "khaki4"))))
 '(highlight ((((class color) (background light)) (:background "lavender"))))
 '(info-menu-5 ((t (:background "lavender"))))
 '(info-xref ((t (:foreground "blue"))))
 '(italic ((t (:italic t :foreground "purple3"))))
 '(menu ((t (:background "#ffffff" :family "helv" :box (:line-width -1 :style released-button)))))
 '(mmm-default-submode-face ((t (:background "seashell3"))))
 '(modeline ((t (:bold t :background "blue4" :foreground "#ffffff" :box (:line-width -1 :style released-button)))))
 '(preview-face ((t (:background "light grey"))))
 '(py-pseudo-keyword-face ((t (:foreground "slate blue"))))
 '(region ((((class color) (background light)) (:background "ivory2"))))
 '(scroll-bar ((t (:background "#ffffff"))))
 '(sh-heredoc-face ((((class color) (background light)) (:foreground "tan3"))))
 '(show-paren-match-face ((((class color)) (:background "LavenderBlush2"))))
 '(todoo-item-header-face ((t (:foreground "goldenrod4" :weight bold))))
 '(tool-bar ((t (:background "#ffffff" :box (:line-width -1 :style released-button)))))
 '(tooltip ((((class color)) (:background "lightyellow" :foreground "black" :height 0.8 :family "helv"))))
 '(underline ((t (:foreground "blue3" :underline "gray50"))))
 '(w3-style-face-00001 ((t (:bold t :foreground "blue4")))))


;; Local Variables:
;; mode: emacs-lisp
;; mode: outline-minor
;; outline-regexp: ";;;;"
;; fill-column: 75
;; ispell-local-dictionary: "american"
;; End:


; LocalWords:  setq defun CodingStyle lupan's lupan american init ie RET misc
; LocalWords:  iso latin helvetica DEFintions FUNctions defuns behaviour

;;; lupan-emacs.el ends here