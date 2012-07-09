(defpackage :dswm.module.audio
  (:use :cl :dswm :cl-ppcre))

(in-package :dswm.module.audio)

(defvar *audio-backends* nil)

(defvar *default-audio-backend* "pavol")

(push (list "amixer" (run-shell-command "which amixer" t)) *audio-backends*)
(push (list "aumix" (run-shell-command "which aumix" t)) *audio-backends*)
(push (list "pavol" (run-shell-command "which pacmd" t)) *audio-backends*)

(define-dswm-type :audio-backend
  (or (argument-pop input)
      (completing-read (current-screen)
                       prompt
                       (audio-backends-list)
		       :require-match t)))

(defun make-volume-bar (percentage muted-p &key channel verbose-p)
  (let ((p percentage)
	(m muted-p)
	(c channel))
    (concat
     "Volume: " (if verbose-p
		    (concat "~%"
			    "State: " (if m "MUTED" "UNMUTED") "~%"
				     (if channel (concat "Channel: " c "~%"))	   
				     "Level:" (princ-to-string p) "%~%")
		  (concat (if m "MUTED" "UNMUTED") " "))
     (bar-zone-color percentage) "["
     (bar percentage 25 #\# #\:) "]")))

(defun audio-backends-list ()
  "Sets audio backends list"
  (let ((backends nil))
    (dolist (backend *audio-backends*)
      (when (not (equal "" (cadr backend)))
	(setf backends (cons (car backend) backends))))
    backends))

(defun get-audio-backend-command (name &optional (list *audio-backends*))
  (cond ((null list) nil)
	((equal name (caar list))
	 (cadar list))
	(t (get-audio-backend-command name (cdr list)))))
