;;; Screenshot maker
;;;
;;; Copyright 2012 Michael Filonenko, Alexander Vynnyk
;;;
;;; Maintainer: Alexander aka 'CosmonauT' Vynnyk
;;;
;;; License?
;;;
;;; USAGE:
;;;
;;; Put:
;;;
;;;     (load-module "screenshot")
;;;
;;; In your ~/.dswm or ~/.dswm.d/init.lisp
;;;

(in-package :dswm)

(defun %get-raw-image (drawable &key
                               (height (xlib:drawable-height drawable))
                               (width (xlib:drawable-width drawable)))
  (xlib:get-raw-image drawable :x 0 :y 0 :width width :height height
                      :format :Z-PIXMAP))

(defun %screenshot-window-png (drawable file &key
                                        (height (xlib:drawable-height drawable))
                                        (width (xlib:drawable-width drawable)))
  (let* ((png (make-instance 'zpng:pixel-streamed-png
			     :color-type :truecolor-alpha
			     :width width
			     :height height)))
    (multiple-value-bind (pixarray depth visual)
        (%get-raw-image drawable :width width :height height)
      (with-open-file (stream file
                              :direction :output
                              :if-exists :supersede
                              :if-does-not-exist :create
                              :element-type '(unsigned-byte 8))
                      (zpng:start-png png stream)
                      ;;(zpng:write-row pixarray png)
                      (case (xlib:display-byte-order (xlib:drawable-display drawable))
                        (:lsbfirst
                         (do ((i 0 (+ 4 i)))
                             ((>= i (length pixarray)))
                           (zpng:write-pixel (list (aref pixarray (+ 2 i))
                                                   (aref pixarray (+ 1 i))
                                                   (aref pixarray i)
                                                   #xFF)
                                             png)))
                        (:msbfirst 
                         (do ((i 0 (+ 4 i)))
                             ((>= i (* height width 4)))
                           (zpng:write-pixel (list (aref pixarray (1+ i))
                                                   (aref pixarray (+ 2 i))
                                                   (aref pixarray (+ 3 i))
                                                   #xFF)
                                             png))))
                      (zpng:finish-png png)))))

(defun %screenshot-window-jpg (drawable file &key
                                       (height (xlib:drawable-height drawable))
                                       (width (xlib:drawable-width drawable)))
  (let (pixarray (%get-raw-image drawable :width width :height height)
    (jpeg:encode-image file pixarray 3 height width)))
