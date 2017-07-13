;;; init.el --- The first thing GNU Emacs runs

;; Do NOT run garbage collection during startup by setting the value super high.
;; This drastically improves `emacs-init-time'. SOURCE= https://redd.it/3kqt6e
;; NOTE: We reset this value at the end of the config.
(setq gc-cons-threshold 999999999999)

;; Ignore default REGEXP checks of file names at startup.
;; This also drastically improves `emacs-init-time'. SOURCE= https://redd.it/3kqt6e
;; NOTE: Some bogus, benign errors about packages/directories may be thrown due to this...
(let ((file-name-handler-alist nil))

  ;; Set up package.el for use with MELPA
  (require 'package) ;; You might already have this line
  (setq package-enable-at-startup nil) ; 
  (let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
		      (not (gnutls-available-p))))
	 (url (concat (if no-ssl "http" "https") "://melpa.org/packages/")))
    (add-to-list 'package-archives (cons "melpa" url) t))
  (when (< emacs-major-version 24)
    ;; For important compatibility libraries like cl-lib
    (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
  (package-initialize) ;; You might already have this line

  ;; Bootstrap `use-package'.  It will manage all other packages.
  (unless (package-installed-p 'use-package)
    (package-refresh-contents)
    (package-install 'use-package))
  ;; Reduce load time of `use-package'
  (eval-when-compile
    (require 'use-package))
  (require 'diminish)                ;; if you use :diminish
  (require 'bind-key)                ;; if you use any :bind variant
  

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
     (setq gc-cons-threshold 20000000)))) ; magnars' recommendation

;;; init.el ends here
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages (quote (use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
