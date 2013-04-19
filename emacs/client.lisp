(defcommand e-switch-to-buffer (buffer) ((:emacs-buffer "Input emacs buffer name: "))
  (run-shell-command
   (make-emacs-call-in-new-frame "(switch-to-buffer \"" buffer "\")")))

(defcommand e-list-buffres () ()
	    (open-buffer-from-menu))

(defcommand e-set-current-buffer () ()
	    (switch-to-buffer-from-menu))

(defcommand e-kill-buffer
    (buffer)
    ((:emacs-existent-buffer "Input emacs buffer name to kill:"))
       (run-shell-command
	(make-emacs-call "(kill-buffer \"" buffer "\")")))

(defcommand e-kill-buffer-from-menu () ()
  (let ((z (select-from-menu (current-screen) (e-buffers))))
    (run-shell-command
     (make-emacs-call "(kill-buffer \"" z "\")"))))

(defcommand e-rename-buffer (buffer) ((:string "Input new emacs buffer name: "))
  ;; TODO creates new buffer
  (let ((current-buffer (car (e-buffers))))
    (run-shell-command
     (make-emacs-call "(rename-buffer \"" buffer "\")"))))

(defcommand e-rename-buffer-from-menu () ()
   (let ((current-buffer (car (e-buffers))))
     (switch-current-buffer-from-menu)
     (run-commands "e-rename-buffer")
     (run-shell-command
      (make-emacs-call "(switch-to-buffer \"" current-buffer "\")"))))

(defcommand e-find-file (file) ((:file "Input filename to open: "))
   (run-shell-command
    (make-emacs-call-in-new-frame "(find-file \"" file "\")")))

(defcommand e-eval (eval) ((:string "Input emacs code to eval: "))
   (run-shell-command
    (make-emacs-call eval)))

(defcommand e-start-client () ()
   (run-shell-command (concat *ec-cmd* " -c")))
