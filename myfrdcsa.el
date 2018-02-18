;; load all the emacs scripts for our systems

(defun get-directory-files (dir)
 ""
 (if (file-accessible-directory-p dir)
  (directory-files dir)))

(defun frdcsa-el-load-all-files ()
 "nonsense"
 (interactive)
 (load (concat frdcsa-internal-codebases "/kmax/kmax.el"))
 (mapcar
  (lambda (file)
   (if
    (and
     (not
      (string-equal file
       (concat frdcsa-internal-codebases "/frdcsa-el/frdcsa-el.el")
       )
      )
     (not
      (string-equal file
       (concat frdcsa-internal-codebases "/kmax/kmax.el")
       )
      ))
    (and (file-exists-p file)
     (progn
					; (message file)
					; (sit-for 0.4)
      (load file)
      )
     )
    )
   )
  (append
   (mapcar
    (lambda (file)
     (concat frdcsa-internal-codebases "/" file "/" file ".el"))
    (get-directory-files frdcsa-internal-codebases))
   (mapcar
    (lambda (file)
     (concat frdcsa-minor-codebases "/" file "/" file ".el"))
    (get-directory-files frdcsa-minor-codebases))
   (mapcar
    (lambda (file)
     (concat frdcsa-work-work "/" file "/" file ".el"))
    (get-directory-files frdcsa-work-work))
   )))

(frdcsa-el-load-all-files)

; (visit-tags-table "/usr/local/share/perl/5.8.3")
(global-set-key "\C-cw" 'w3m-browse-file)

(defun reload-etags ()
 "Make /usr/share/emacs/TAGS and visit-tags-table them."
 (interactive)
 (shell-command "cd /usr/share/emacs && sudo sh -c \"find . | grep '\.el$' | etags -L - \"")
 (visit-tags-table "/usr/share/emacs/TAGS")
 )

(defun update-dlocatedb ()
 "run update-dlocatedb"
 (interactive))

(defun myfrdcsa-convert-emacs-to-cyc-style ()
  "Converts  function  names from  emacs  style,  i.e. lowercase  with
dashes, to Cyc style, i.e. no spaces capitalized"
  (interactive)
  (backward-sexp)
  (set-mark-command)
  (search-forward " ")
  (narrow-to-region)
  (beginning-of-line)
  ;; while no errors
  (while
      (progn)))

(global-set-key [C-tab] 'complete-symbol)

;; add to emacs the capability to search for named entities, like, for
;; instance: "C-M-s & d a t e" would find the next date)

(defun myfrdcsa-add-scripts-to-path ()
 "Add all the FRDCSA scripts directories to the path"
 (interactive)
 (dolist 
  (dir1 (list frdcsa-internal-codebases frdcsa-minor-codebases))
  (dolist
   (dir2 (split-string (shell-command-to-string (concat "ls -d " dir1 "/*/scripts")) "\n"))
   ;; (message (prin1-to-string dir2))
   (message dir2)
   (eshell/addpath dir2)
   ;; (sit-for 0.1)
   )))

;; (myfrdcsa-add-scripts-to-path)

(defun frdcsa-add-external-emacs-software-to-load-path ()
 (let*
  ((regex (concat "^[^\\.]"))
   (directories (directory-files "/var/lib/myfrdcsa/codebases/internal/frdcsa-el/external" nil regex)))
  (mapcar (lambda (dir) (add-to-list 'load-path (concat "/var/lib/myfrdcsa/codebases/internal/frdcsa-el/external/" dir))) directories)))

;; (frdcsa-add-external-emacs-software-to-load-path)
