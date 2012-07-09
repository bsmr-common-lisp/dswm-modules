;;;; pavol.lisp

(in-package #:dswm.module.audio)

(export
 '(pavol-vol+
   pavol-vol-
   pavol-toggle-mute
   show-volume-bar
   *pavol-keymap*
   pavol-interactive
   pavol-exit-interactive))

;;; "pavol" goes here. Hacks and glory await!

(defvar *pavol-program* (get-audio-backend-command "pavol"))

(defparameter *pavol-max* 65536)

(defparameter *pavol-keymap*
  (let ((m (make-sparse-keymap)))
    (labels ((dk (k c)
               (define-key m k c)))
      (dk (kbd "j") "pavol-vol-")
      (dk (kbd "k") "pavol-vol+")
      (dk (kbd "m") "pavol-toggle-mute")
      (dk (kbd "RET") "pavol-exit-interactive")
      (dk (kbd "C-g") "pavol-exit-interactive")
      (dk (kbd "ESC") "pavol-exit-interactive")
      m)))

(defun volume ()
  (let ((str-sinks
         (run-shell-command (concat *pavol-program* " list-sinks") t)))
    (multiple-value-bind (start end start-reg end-reg)
        (cl-ppcre:scan "volume: 0:(.*?)%" str-sinks)
      (declare (ignore start end))
      (parse-integer (subseq str-sinks (elt start-reg 0) (elt end-reg 0))))))

(defun mutep ()
  (let ((str-sinks
         (run-shell-command (concat *pavol-program* " list-sinks") t)))
    (multiple-value-bind (start end start-reg end-reg)
        (cl-ppcre:scan "muted: (.*)" str-sinks)
      (declare (ignore start end))
      (string= "yes" (subseq str-sinks (elt start-reg 0) (elt end-reg 0))))))

(defun percentage->integer (percentage)
  (truncate (* *pavol-max* percentage) 100))

(defun set-volume (percentage)
  (run-shell-command
   (concat *pavol-program*
	   (format nil " set-sink-volume 0 ~a"
		   (percentage->integer percentage)))))

(defun mute (state)
  (run-shell-command
   (concat *pavol-program*
	   (format nil " set-sink-mute 0 ~:[0~;1~]" state))))

(defun interactivep ()
  (equal *top-map* *pavol-keymap*))

(defun show-volume-bar (&optional verbose-p)
  (let ((percent (volume)))
    (funcall (if (interactivep)
                 #'dswm::message-no-timeout
	       #'dswm:message)
	     (make-volume-bar percent (mutep) :verbose-p verbose-p))))

(defcommand pavol-vol+ (&optional (percentage "+5")) ()
  "Increase the volume by 5 points"
  (set-volume (min (+ (volume) percentage) 100))
  (show-volume-bar))

(defcommand pavol-vol- (&optional (percentage "-5")) ()
  "Decrease the volume by 5 points"
  (set-volume (max (- (volume) percentage) 0))
  (show-volume-bar))

(defcommand pavol-toggle-mute () ()
  "Toggle mute"
  (if (mutep)
      (mute nil)
    (mute t))
  (show-volume-bar))

(defcommand pavol-exit-interactive () ()
  "Exit the interactive mode for changing the volume"
  (pop-top-map))

(defcommand pavol-interactive () ()
  "Change the volume interactively using `j', `k' and `m' keys"
  (push-top-map *pavol-keymap*)
  (show-volume-bar))
