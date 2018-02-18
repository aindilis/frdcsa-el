(defun frdcsa-test-equals (&optional function)
 (if (not (equal nil function))
  (see "not equal"))
 (if (non-nil function)
  (see "non-nil"))
 (if (boundp 'function)
  (see "boundp")))

;; (frdcsa-test-equals 'frdcsa-test-equals)


