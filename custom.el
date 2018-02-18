(defun frdcsa-el-browse-thing-at-point (arg)
 "view the system's url"
 (interactive "P")

 (browse-url-mozilla (Sradar-get-url-for-system-at-point arg))
 (shell-command (concat "mozilla -remote 'openURL(" (radar-get-url-for-system-at-point arg) ",new-tab)'"))
 )
()