(in-package :dswm.module.emacs)

(defun process-running-p (&key process-name process-number)
  (let ((running-p nil))
    (if-not-null process-name
		 (setf running-p (run-prog-collect-output "/bin/sh" "-c" (concat "ps aux | grep " process-name " | grep -v 'grep'")))
		 (setf running-p (run-prog-collect-output "/bin/sh" "-c" (concat "ps aux | awk '{print $2}' | grep " process-number " | grep -v 'grep'"))))
    (if (equal running-p "") nil running-p)))
  
(defcommand emacs-start-daemon () ()
  "Check, if emacs daemon is running and starts it if not"
  (if (not (process-running-p "emacs --daemon"))
      (when (run-shell-command *emacs-daemon-command*)
	(message "Emacs daemon launched"))
    (message "Emacs daemon already running")))

;; Example
(defcommand wanderlust () ()
	    (emacs)
	    (send-meta-key (current-screen) (kbd "M-x"))
	    (window-send-string "wl")
	    (send-meta-key (current-screen) (kbd "RET")))
