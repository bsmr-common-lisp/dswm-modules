
(defvar *emacs-command* "emacs")
(defvar *emacs-client-command* "emacsclient")

(defvar *emacs-server-instances* '("default"))

;; emacs server start-stop
(defvar *emacs-start-server* "emacs --daemon")
(defvar *emacs-stop-server* "emacsclient -e '(kill-emacs)'")
(defvar *emacs-save-stop-server* "emacsclient -e '(client-save-kill-emacs)'")

(defvar *emacs-shortcut-hash* (make-hash-table))

(defun e-call (&rest body)
  "Call from emacsclient to emacs daemon to run some command"
  (run-shell-command
   (eval (append
	  (list 'concat *emacs-client-command* " " "-e" " '")
	  body '("'"))) t)))

(defun e-buffers ()
  (cl-ppcre:split
   ":" (cl-ppcre:regex-replace-all
	"\\(\\:|\\:\\)" (cl-ppcre:regex-replace-all
			 "\"+\ \"+|\"+"
			 (e-call "(mapcar (function buffer-name) (buffer-list))")
			 ":") "")))

(defun e-switch-to-buffer ()
  (let ((z (select-from-menu (current-screen) (e-buffers))))
    (run-shell-command (concat "emacsclient -c -e '(switch-to-buffer \"" z "\")'"))))

(defun e-switch-to-buffer-e ()
  (let ((z (select-from-menu (current-screen) (e-buffers))))
    (run-shell-command (concat "emacsclient -e '(switch-to-buffer \"" z "\")'"))))


;; (defun e-call-open-client (&rest body)
;; FIXME: freezing
;;   "Call from emacsclient to emacs daemon to run some command"
;;   (run-shell-command
;;    (eval (append
;; 	  (list 'concat *emacs-client-command* " " "-c" " " "-e" " '")
;; 	  body '("'"))) t)))

;;; client
