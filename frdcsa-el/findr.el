;;; findr.el	-- Breadth-first file-finding facility for (X)Emacs
;;  Thursday July 27 1999

;; Copyright (C) 1999 Free Software Foundation, Inc.

;; Author: David Bakhash <<EMAIL: PROTECTED>>
;; Maintainer: David Bakhash <<EMAIL: PROTECTED>>
;; Version: 0.0
;; Created: Tue Jul 27 08:49:22 EST 1999
;; Keywords: files

;; This file is not part of emacs or XEmacs.

;; Emacs is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as
;; published by the Free Software Foundation; either version 2 of the
;; License, or (at your option) any later version.

;; Emacs program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with XEmacs; see the file COPYING.  If not, write to the Free
;; Software Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
;; 02111-1307, USA.

;; Commentary:

;; This code contains a command, called `findr`, which allows you to
;; search for a file breadth-first.  This works on UNIX, Windows, and
;; over the network, using efs and ange-ftp. It`s pretty quick, and (at
;; times) is a better and easier alternative to other mechanisms of
;; finding nested files, when you`ve forgotten where they are.

;; You pass `findr` a regexp, which must match the file you`re looking
;; for, and a directory, and then it just does its thing:

;; M-x findr <ENTER> ^my-lib.p[lm]$ <ENTER> c:/ <ENTER>

;; It will stop when it finds a matching file.  It won`t be a big deal to
;; change this behavior, of course.

;; Code:

(require `cl)				; of course

(provide `findr)			; unobtrusive name, for now

;;;; breadth-first file finder...

(defun* findr (name dir)
  "Search directory DIR breadth-first for files matching the
regexp NAME.  This function will exit as soon as it finds a match."
  (interactive "sfile name regexp: 
DDirectory: ")
  (labels ((findr-1 (dir)
	     (message "searching %s ..." dir)
	     (let ((files (directory-files dir t "\w")))
	       (loop
		for file in files
		for fname = (file-relative-name file)
		when (file-directory-p file)
		do (findr-enqueue file *dirs*)
		when (string-match name fname)
		do (message "file found: %s" file)
		   (return-from findr file)))))
    (let ((*dirs* (findr-make-queue)))
      (findr-enqueue dir *dirs*)
      (while (findr-queue-contents *dirs*)
	(findr-1 (findr-dequeue *dirs*))))))

;;;; Queues

(defun findr-make-queue ()
  "Build a new queue, with no elements."
  (let ((q (cons nil nil)))
    (setf (car q) q)
    q))

(defun findr-enqueue (item q)
  "Insert item at the end of the queue."
  (setf (car q)
        (setf (rest (car q))
              (cons item nil)))
  q)

(defun findr-dequeue (q)
  "Remove an item from the front of the queue."
  (prog1 (pop (cdr q))
    (when (null (cdr q))
      (setf (car q) q))))


(defsubst findr-queue-contents (q)
  (cdr q))
