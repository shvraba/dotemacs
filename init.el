;;; init.el --- The first thing GNU Emacs runs

;; Keep all temporary files in system's $TMPDIR.  This reduces file clutter.
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;;; init.el ends here
