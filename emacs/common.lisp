
(defvar *emacs-cmd* "emacs")
(defvar *ec-cmd* "emacsclient")

(defvar *emacs-server-instances* '("default"))

;; emacs server start-stop
(defvar *emacs-start-server* "emacs --daemon")
(defvar *emacs-stop-server* "emacsclient -e '(kill-emacs)'")
(defvar *emacs-save-stop-server* "emacsclient -e '(client-save-kill-emacs)'")

(defvar *emacs-shortcut-hash* (make-hash-table))

;;;; Common functions
(defun make-emacs-call (&rest rest)
  "Make emacs call"
  (eval (append (list 'concat *ec-cmd* " -e '") rest '("'"))))

(defun make-emacs-call-in-new-frame (&rest rest)
  "Make emacs call to run it in new `emacs frame`"
  (eval (append (list 'concat *ec-cmd* " -c -e '") rest '("'"))))

(defun e-call (&rest body)
  "Call from emacsclient to emacs daemon to run some command"
  (run-shell-command
   (eval (cons 'make-emacs-call body)) t))

(defun e-buffers ()
  (cl-ppcre:split 
   "\"+\ \"+|\"+"
   (cl-ppcre:regex-replace-all
    "\\(\"|\"\\)" 
    (e-call "(mapcar (function buffer-name) (buffer-list))") "")))
;;;; /Common functions

;;; DSWM types
(define-dswm-type :emacs-buffer (input prompt)
  (let ((*current-input-history-slot* :emacs-buffer))
    (or (argument-pop-rest input)
	(completing-read (current-screen) prompt (e-buffers) :require-match nil))))

(define-dswm-type :emacs-existent-buffer (input prompt)
  (let ((*current-input-history-slot* :emacs-buffer))
    (or (argument-pop-rest input)
	(completing-read (current-screen) prompt (e-buffers) :require-match t))))
;;; /DSWM types

(defun switch-current-buffer-from-menu ()
  (let ((z (select-from-menu (current-screen) (e-buffers))))
    (run-shell-command
     (make-emacs-call
	 (concat "(switch-to-buffer \"" z "\")")))))

(defun open-buffer-from-menu ()
  (let ((z (select-from-menu (current-screen) (e-buffers))))
    (run-shell-command (make-emacs-call-in-new-frame "(switch-to-buffer \"" z "\")"))))

