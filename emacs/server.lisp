(define-dswm-type :e-server
)

(define-dswm-type :e-running-server
)

(defun server-start (&key servernames)
  (if-not-null servername
   (run-shell-command (concat *emacs-start-server* "=" servername))
   (dolist (i *server-instances*)
     (run-shell-command (concat *emacs-start-server* "=" i)))))

(defun server-stop (&key servernames save-p)
  (if-not-null servername
   (if-not-null save-p
    (dolist (i servernames)
      (run-shell-command (concat *emacs-save-stop-server* " --socket-name=" i)))
    (dolist (i servernames)
      (run-shell-command (concat *emacs-stop-server* " --socket-name=" i))))
   (dolist (i *server-instances*)
     (run-shell-command (concat *emacs-stop-server* " --socket-name=" i)))))

(defun server-restart (&key servernames)
  (if-not-null servernames
	       (and (server-stop :servernames servernames)
		    (server-start :servernames servernames))
	       (and (server-stop)
		    (server-start))))

(defun server-reload (&key servername)
  (princ "Not implemented"))


