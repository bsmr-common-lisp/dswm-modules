;;;; pavol.lisp

(defpackage #:pavol
  (:use #:cl #:dswm)
  (:export :vol+
           :vol-
           :toggle-mute
           :show-volume-bar
           :*pavol-keymap*
           :set-interactive
           :unset-interactive))

(in-package #:pavol)

;;; "pavol" goes here. Hacks and glory await!

(defparameter *pavol-max* 65536)

(defparameter *pavol-keymap*
  (let ((m (dswm:make-sparse-keymap)))
    (labels ((dk (k c)
               (dswm:define-key m k c)))
      (dk (dswm:kbd "j") "pavol-vol-")
      (dk (dswm:kbd "k") "pavol-vol+")
      (dk (dswm:kbd "m") "pavol-toggle-mute")
      (dk (dswm:kbd "RET") "pavol-exit-interactive")
      (dk (dswm:kbd "C-g") "pavol-exit-interactive")
      (dk (dswm:kbd "ESC") "pavol-exit-interactive")
      m)))

(defun volume ()
  (let ((str-sinks
         (dswm:run-shell-command "pacmd list-sinks" t)))
    (multiple-value-bind (start end start-reg end-reg)
        (cl-ppcre:scan "volume: 0:(.*?)%" str-sinks)
      (declare (ignore start end))
      (parse-integer (subseq str-sinks (elt start-reg 0) (elt end-reg 0))))))

(defun mutep ()
  (let ((str-sinks
         (dswm:run-shell-command "pacmd list-sinks" t)))
    (multiple-value-bind (start end start-reg end-reg)
        (cl-ppcre:scan "muted: (.*)" str-sinks)
      (declare (ignore start end))
      (string= "yes" (subseq str-sinks (elt start-reg 0) (elt end-reg 0))))))

(defun percentage->integer (percentage)
  (truncate (* *pavol-max* percentage) 100))

(defun set-volume (percentage)
  (dswm:run-shell-command
   (format nil "pacmd set-sink-volume 0 ~a"
           (percentage->integer percentage))))

(defun mute (state)
  (dswm:run-shell-command
   (format nil "pacmd set-sink-mute 0 ~:[0~;1~]" state)))

(defun set-interactive ()
  (dswm::push-top-map pavol:*pavol-keymap*))

(defun unset-interactive ()
  (dswm::pop-top-map))

(defun interactivep ()
  (equal dswm:*top-map* pavol:*pavol-keymap*))

(defun show-volume-bar ()
  (let ((percent (volume)))
    (funcall (if (interactivep)
                 #'dswm::message-no-timeout
                 #'dswm:message)
             (format nil "~:[OPEN~;MUTED~]~%^B~3d%^b [^[^7*~a^]]"
                     (mutep) percent (dswm::bar percent 50 #\# #\:)))))

(defun volume-up (percentage)
  (set-volume (min (+ (volume) percentage) 100)))

(defun volume-down (percentage)
  (set-volume (max (- (volume) percentage) 0)))

(defun vol+ (percentage)
  (volume-up percentage)
  (show-volume-bar))

(defun vol- (percentage)
  (volume-down percentage)
  (show-volume-bar))

(defun toggle-mute ()
  (if (mutep)
      (mute nil)
      (mute t))
  (show-volume-bar))

;; commands

(defcommand pavol-vol+ () ()
  "Increase the volume by 5 points"
  (pavol:vol+ 5))

(defcommand pavol-vol- () ()
  "Decrease the volume by 5 points"
  (pavol:vol- 5))

(defcommand pavol-toggle-mute () ()
  "Toggle mute"
  (pavol:toggle-mute))

(defcommand pavol-exit-interactive () ()
  "Exit the interactive mode for changing the volume"
  (pavol:unset-interactive))

(defcommand pavol-interactive () ()
  "Change the volume interactively using `j', `k' and `m' keys"
  (pavol:set-interactive)
  (pavol:show-volume-bar))
