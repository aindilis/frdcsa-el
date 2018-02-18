;; Emacsen independent startup file.  All of the various installed
;; flavors of emacs (emacs 19, emacs 20, xemacs) will load this file
;; at startup.  Make sure any code you put here is emacs flavor
;; independent.

;; Package maintainers: do not have DebK!ian packages edit this file.
;; See the policy manual for the proper way to handle Emacs package
;; initialization code.

;; Need script to be idempotent

;; This  is  a  collection  of  utilities  to  make  the  FRDCSA  more
;; accessible in Emacs.

(defun join (separator list)
  "Same as Perl join"
  (setq value "")
  (let* ((first nil)
	 (value
	  (dolist (elt list value)
	    (setq value (concat value (if first separator "") elt))
	    (setq first t))))
    value))

(defvar frdcsa-el-os-directory-separator "/")

(defun frdcsa-el-concat-dir (list)
 (listp list)
 (join frdcsa-el-os-directory-separator (mapcar #'kmax-strip-trailing-forward-slashes list)))

(setq frdcsa-home "/var/lib/myfrdcsa")
(setq frdcsa-codebases (concat frdcsa-home "/codebases"))
(setq frdcsa-internal-codebases (concat frdcsa-codebases "/internal"))
(setq frdcsa-external-codebases (concat frdcsa-codebases "/external"))
(setq frdcsa-minor-codebases (concat frdcsa-codebases "/minor"))
(setq frdcsa-work (concat frdcsa-codebases "/work"))
(setq frdcsa-work-clients (concat frdcsa-work "/clients"))
(setq frdcsa-work-work (concat frdcsa-work "/work"))
(setq frdcsa-projects (concat frdcsa-home "/projects"))
(setq frdcsa-sandbox (concat frdcsa-home "/sandbox"))
(setq frdcsa-releases (concat frdcsa-codebases "/releases"))
(setq frdcsa-collections (concat frdcsa-home "/collections"))
(setq frdcsa-capabilities (concat frdcsa-home "/capabilities"))
(setq frdcsa-github (concat frdcsa-home "/github/aindilis"))
(setq frdcsa-repositories-internal (concat frdcsa-home "/repositories/internal"))
(setq frdcsa-repositories-internal-cvs (concat frdcsa-repositories-internal "/cvs"))
(setq frdcsa-repositories-internal-git (concat frdcsa-repositories-internal "/git"))
(setq frdcsa-repositories-internal-svn (concat frdcsa-repositories-internal "/svn"))
(setq frdcsa-repositories-external (concat frdcsa-home "/repositories/external"))
(setq frdcsa-repositories-external-cvs (concat frdcsa-repositories-external "/cvs"))
(setq frdcsa-repositories-external-git (concat frdcsa-repositories-external "/git"))
(setq frdcsa-repositories-external-svn (concat frdcsa-repositories-external "/svn"))
(setq frdcsa-packages (concat frdcsa-home "/packages"))
(setq frdcsa-datasets (concat frdcsa-home "/datasets"))
(setq frdcsa-partial-packages (concat frdcsa-packages "/partial"))
(setq frdcsa-binary-packages (concat frdcsa-packages "/binary"))
(setq frdcsa-source-packages (concat frdcsa-packages "/source"))
(setq frdcsa-el-dir (concat frdcsa-internal-codebases "/frdcsa-el"))

(setq frdcsa-cats (concat frdcsa-codebases "/cats"))

(defun frdcsa-get-latest-version (directory codebase)
 (let*
  ((regex (concat "^" codebase "-\\(.+\\)$"))
   (codebase-and-version 
    (completing-read "Version: "
     (directory-files directory nil regex)))
   (version (progn
	     (string-match regex codebase-and-version)
	     (match-string 1 codebase-and-version))))
  version))

(defun frdcsa-sandbox-dir (codebase &optional version)
 ;; get the latest version of the codebase, or use version
 (let*
  ((version-to-use (or version (frdcsa-get-latest-version frdcsa-sandbox codebase))))
  (concat frdcsa-sandbox "/" codebase "-" version-to-use "/" codebase "-" version-to-use)))

;; (frdcsa-get-latest-version frdcsa-sandbox "spark")
;; (frdcsa-sandbox-dir "spark")

(defmacro with-library (symbol &rest body)
 `(condition-case nil
   (progn
    (require ',symbol)
    ,@body)
   
   (error (message (format "I guess we don't have %s available." ',symbol))
    nil)))
;; (put 'with-library 'lisp-indent-function 1)

(load (setq frdcsa-el-prefs-file (concat frdcsa-el-dir "/prefs.el")))
;; /var/lib/myfrdcsa/codebases/internal/frdcsa-el/prefs.el
; (load (setq frdcsa-el-hooks (concat frdcsa-el-dir "/hooks.el")))
;; /var/lib/myfrdcsa/codebases/internal/frdcsa-el/hooks.el
(load (setq frdcsa-el-myfrdcsa-file (concat frdcsa-el-dir "/myfrdcsa.el")))
;; /var/lib/myfrdcsa/codebases/internal/frdcsa-el/myfrdcsa.el
(load (setq frdcsa-el-date-file (concat frdcsa-el-dir "/date.el")))
;; /var/lib/myfrdcsa/codebases/internal/frdcsa-el/date.el
(load (setq frdcsa-el-utils-file (concat frdcsa-el-dir "/utils.el")))
;; /var/lib/myfrdcsa/codebases/internal/frdcsa-el/utils.el
; (load (concat frdcsa-el-dir "/lupan-emacs.el"))
;; /var/lib/myfrdcsa/codebases/internal/frdcsa-el/lupan-emacs.el

;; (load (concat frdcsa-el-dir "/tests.el"))

(global-set-key "\C-crerE" 'frdcsa-el-edit-dot-emacs)
(global-set-key "\C-crerf" 'frdcsa-el-edit-frdcsa-el-file)
(global-set-key "\C-crerx" 'frdcsa-el-edit-frdcsa-el-examples)

;; (defun frdcsa-el-load-file ()
;;  )

(defun frdcsa-el-edit-dot-emacs ()
 "Edit the file containing the bashrc"
 (interactive)
 (ffap "~/.emacs"))

(defun frdcsa-el-get-best-filename-for-file (files)
 (mapcar
  (lambda (file)
   ())
  files))

(kmax-fixme "fix the bottom stuff of frdcsa-el.el")

(defun frdcsa-el-get-best-filename-for-files (files)
 (let ((rules
	'(
	  ("/myfrdcsas/versions/myfrdcsa-1.0/" . "/myfrdcsa/")
	  ;; ("/releases/\\([a-zA-Z0-9-]+\\)-[0-9\.]+/\\([a-zA-Z0-9-]+\\)-[0-9\.]+/" .
	  ;;  (lambda (match)
	  ;;   (string-match "/releases/\\([a-zA-Z0-9-]+\\)-[0-9\.]+/\\([a-zA-Z0-9-]+\\)-[0-9\.]+/" match)
	  ;;    (concat "/internal/" (match-string 1 match) "/")))
	  ;; ("/var/lib/myfrdcsas/versions/myfrdcsa-1.0/codebases/releases/[a-zA-Z0-9-]+-[0-9\.]+/cso-[0-9\.]+" . "/var/lib/myfrdcsa/codebases/internal/cso")
	  ;; ("myfrdcsa" . "toadstools")
	  )))
 (kmax-do-string-replace-regexes files rules)))

(defun kmax-do-string-replace-regexes (strings rules)
 ""
 (interactive)
 (let ((all-results nil))
  (mapcar
   (lambda (string)
    (let* ((temporary-result string))
	   (mapcar 
	    (lambda (entry)
	     (setq temporary-result (replace-regexp-in-string (car entry) (cdr entry) string)))
	    rules)
      (push temporary-result all-results)))
   strings)
  all-results))

(defun frdcsa-el-frdcsa-el-file ()
 (interactive)
 (car
  (frdcsa-el-get-best-filename-for-files
   (list "/var/lib/myfrdcsas/versions/myfrdcsa-1.0/codebases/releases/frdcsa-el-0.1/frdcsa-el-0.1/frdcsa-el.el"))))

(defun frdcsa-el-edit-frdcsa-el-file ()
 "Edit the file containing the bashrc"
 (interactive)
 (ffap (frdcsa-el-frdcsa-el-file)))

(defun frdcsa-el-edit-frdcsa-el-examples ()
 ""
 (interactive)
 (ffap "/var/lib/myfrdcsa/codebases/internal/frdcsa-el/frdcsa-el-examples.el"))
