(defun string-match-p (regex string)
 ""
 (not (not (string-match regex string))))

;; ;; In order to switch between ansi-term and shell-mode

;; ;; (http://www.emacswiki.org/emacs/ShellMode)

;; (
;;  (require 'shell)
;;  (require 'term)

;;  (defun term-switch-to-shell-mode ()
;;   (interactive)
;;   (if (equal major-mode 'term-mode)
;;    (progn
;;     (shell-mode)
;;     (set-process-filter  (get-buffer-process (current-buffer)) 'comint-output-filter )
;;     (local-set-key (kbd "C-j") 'term-switch-to-shell-mode)
;;     (compilation-shell-minor-mode 1)
;;     (comint-send-input)
;;     )
;;    (progn
;;     (compilation-shell-minor-mode -1)
;;     (font-lock-mode -1)
;;     (set-process-filter  (get-buffer-process (current-buffer)) 'term-emulate-terminal)
;;     (term-mode)
;;     (term-char-mode)
;;     (term-send-raw-string (kbd "C-l"))
;;     )))
;;  )

