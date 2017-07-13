;;; init.el --- The first thing GNU Emacs runs

;; Do NOT run garbage collection during startup by setting the value super high.
;; This drastically improves `emacs-init-time'. SOURCE= https://redd.it/3kqt6e
;; NOTE: We reset this value at the end of the config.
(setq gc-cons-threshold 999999999999)

;; Keep all temporary files in system's $TMPDIR.  This reduces file clutter.
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;; Revert garbage collection behaviour to a normal, more modern level.
;; SOURCE= https://www.reddit.com/r/emacs/comments/3kqt6e/2_easy_little_known_steps_to_speed_up_emacs_start/cv059dc/
(run-with-idle-timer
 5 nil
 (lambda ()
   (setq gc-cons-threshold 20000000))) ; magnars' recommendation

;;; init.el ends here
