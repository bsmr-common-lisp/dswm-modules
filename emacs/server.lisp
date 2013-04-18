(defun emacs-server-start (&key servernames)
  (if-not-null servername
   (run-shell-command (concat *emacs-start-server* "=" servername))
   (dolist (i *emacs-server-instances*)
     (run-shell-command (concat *emacs-start-server* "=" i)))))

(defun emacs-server-stop (&key servernames save-p)
  (if-not-null servername
   (if-not-null save-p
    (dolist (i servernames)
      (run-shell-command (concat *emacs-save-stop-server* " --socket-name=" i)))
    (dolist (i servernames)
      (run-shell-command (concat *emacs-stop-server* " --socket-name=" i))))
   (dolist (i *emacs-server-instances*)
     (run-shell-command (concat *emacs-stop-server* " --socket-name=" i)))))

(defun emacs-server-restart (&key servernames)
  (if-not-null servernames
	       (and (emacs-server-stop :servernames servernames)
		    (emacs-server-start :servernames servernames))
	       (and (emacs-server-stop)
		    (emacs-server-start))))

(defun emacs-server-reload (&key servername)
  (princ "Not implemented"))

