;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; General Stuff
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Modes
(icomplete-mode)
;;(global-font-lock-mode)

(setq stack-trace-on-error t)

;; Buffers
(setq tags-revert-without-query t)

;; Processes
(server-start)

;; Variables
(put 'narrow-to-region 'disabled nil)
(put 'upcase-region 'disabled nil)
(setq sgml-insert-missing-element-comment nil)
(setq lisp-indent-offset 1)

;; Bindings
(global-set-key "\C-c." 'ffap)
;; (global-set-key "\C-x\M-t" 'text-translator)

(eshell)
(eshell/addpath "/sbin")
(eshell/addpath "/usr/sbin")
(eshell/addpath "/var/lib/myfrdcsa/codebases/internal/myfrdcsa/bin")
(setq eshell-save-history-on-exit t)

(shell)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; W3M Configuration
;; function to get the url under point and copy it to the kill ring
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq browse-url-browser-function 'w3m-browse-url)
(global-set-key "\C-x\C-g" 'browse-url)
(global-set-key "\C-ck" 'w3m-kill-anchor) ; should really put this in w3m-mode
(defun w3m-kill-anchor () ""
 (interactive)
 (kill-new (w3m-anchor)))
;; enable frames support in w3m-el
(require 'executable)
(let ((w3mmee (executable-find "w3mmee-img"))
      (mbconv (executable-find "mbconv")))
 (when (and w3mmee mbconv)
  (setq w3m-command w3mmee)))
(require 'w3m)
;; (eval-after-load "w3m"
;;   '(setq w3m-command-arguments
;; 	 (nconc w3m-command-arguments
;; 		'("-o" "http_proxy=http://localhost:8080/"))))

(defun w3m-search-region ()
 ""
 (interactive)
 (let ((string (buffer-substring-no-properties (point) (mark))))
  (if (string= mode-name "w3m")
   (w3m-copy-buffer))
  (w3m-search "google" string)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Docbook configuration
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun frdcsa-el-set-prolog-comment-start ()
 (set (make-local-variable 'comment-start) "%%"))

(add-hook 'prolog-mode-hook 'frdcsa-el-set-prolog-comment-start)

;; Loading
(if (load "nxml-mode.el" t)
 (autoload 'xml-mode "psgml" "Major mode to edit XML files." t ) 
 (add-hook 'nxml-mode-hook 'my-fix-keys)

 (setq auto-mode-alist
  (cons '("\\.bashrc$" . shell-script-mode) auto-mode-alist))
 (setq
  auto-mode-alist (append '(
			    ;; DocBook-XML
			    ("\\.db" . xml-mode)
			    )
		   auto-mode-alist))
 (add-hook 'sgml-mode-hook 'turn-on-auto-fill)
 (setq sgml-custom-dtd '(
			 ( "HTML 4.0 Strict"
			  "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0//EN\"
              \"dtd/html-4.0s.dtd\">" )
			 ( "HTML 4.0 Blaireau"
			  "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML Transitional 4.0//EN\"
              \"dtd/html-4.0-loose.dtd\">" )
			 ( "DocBook 3.1 XML Article"
			  "<?xml version=\"1.0\" encoding=\"iso-8859-1\"?>
               <!DOCTYPE article PUBLIC \"-//Norman Walsh//DTD DocBk XML V3.1//EN\"
               \"dtd/docbook-xml/docbookx.dtd\">" )
			 ))
 (setq sgml-insert-missing-element-comment nil)
 )

;; Functions
(defun my-fix-keys () ""
 (define-key nxml-mode-map "\C-c\C-c"
  'nxml-complete))

;; GTYPIST configuration
;; (autoload 'gtypist-mode "gtypist-mode")
;; (setq auto-mode-alist       
;;      (cons '("\\.typ\\'" . gtypist-mode) auto-mode-alist))

;; find or create this function

(defun find-file-with-tricks ()
 ""
 ())

(setq browse-url-new-window-flag nil)

;; (add-hook 'comint-dynamic-complete-functions 'comint-dynamic-complete)

;; (require 'felineherd)

(setq cperl-electric-parens 'null)
