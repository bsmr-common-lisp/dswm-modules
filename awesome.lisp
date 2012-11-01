(require 'clx)
(proclaim '(optimize (speed 0) (space 0) (debug 3)))

(defstruct awesome-mode-line
  "A mode-line for stumpwm"
  display
  screen
  window
  gcontext
  border
  border-width
  cells)

(defstruct cell
  "A place to put content. It resides in the awesome-mode-line"
  x
  y
  width
  height
  content				; String to display
  cell-list				; List of subcells
)

(defun create-awesome-mode-line (&optional parent-window)
  (let* ((display (xlib:open-default-display))
	 (screen (first (xlib:display-roots display)))
	 (my-parent-window (or parent-window
			       (xlib:screen-root screen)))
	 (foreground-color (xlib:screen-black-pixel screen))
	 (background-color (xlib:screen-white-pixel screen))
	 (text-font "fixed"))
    (make-awesome-mode-line
     :display display
     :screen screen
     :gcontext (xlib:create-gcontext :drawable   my-parent-window
				     :foreground foreground-color
				     :background background-color
				     :font       text-font)
     :window (xlib:create-window
	      :parent       my-parent-window
	      :class        :input-output
	      :x            0
	      :y            0
	      :width        (xlib:screen-width screen)
	      :height       20
	      :border-width 0
	      :save-under   :on
	      :override-redirect :on
	      :event-mask   (xlib:make-event-mask :leave-window :exposure))
     :cells '())))

(defun awesome-mode-line-width (aml)
  (xlib:drawable-width (awesome-mode-line-window aml)))

(defun awesome-mode-line-height (aml)
  (xlib:drawable-height (awesome-mode-line-window aml)))

(defun destroy-awesome-mode-line (aml)
  (xlib:unmap-window (awesome-mode-line-window aml))
  (xlib:free-gcontext (awesome-mode-line-gcontext aml))
  (xlib:destroy-window (awesome-mode-line-window aml)))

(defun map-awesome-mode-line (aml)
  (xlib:map-window (awesome-mode-line-window aml)))

(defun present-awesome-mode-line (aml)
  (map-awesome-mode-line aml)
  (let ((window (awesome-mode-line-window aml))
	(gcontext (awesome-mode-line-gcontext aml))
	(width (awesome-mode-line-width aml))
	(height (awesome-mode-line-height aml)))
    ;; Fill background
    (xlib:with-gcontext (gcontext :foreground (xlib:gcontext-background gcontext))
      (xlib:draw-rectangle window gcontext 0 0 width height :fill-p))
    ;; Draw box around aml
    (xlib:draw-line window gcontext 0 0 width 0)
    (xlib:draw-line window gcontext width 0 width height)
    (xlib:draw-line window gcontext width height 0 height)
    (xlib:draw-line window gcontext 0 height 0 0)
    ;; Iterate over cells and display them
    (dolist (cell (awesome-mode-line-cells aml))
      (xlib:draw-line window gcontext
		      (+ (cell-x cell) (cell-width cell)) (cell-y cell)
		      (+ (cell-x cell) (cell-width cell)) (+ (cell-y cell) (cell-height 
cell)))
      )))

(defun awesome-mode-line ()
  (let ((aml (create-awesome-mode-line))
	(cell1 (make-cell :x 0 :y 0 :width 200 :height 20))
	(cell2 (make-cell :x 400 :y 0 :width 200 :height 20)))
    (setf (awesome-mode-line-cells aml) (append (awesome-mode-line-cells aml) (list cell1)))
    (setf (awesome-mode-line-cells aml) (append (awesome-mode-line-cells aml) (list cell2)))
    (present-awesome-mode-line aml)
    (xlib:display-finish-output (awesome-mode-line-display aml))
    (sleep 3)
    (xlib:display-finish-output (awesome-mode-line-display aml))
    (destroy-awesome-mode-line aml)
    (xlib:display-finish-output (awesome-mode-line-display aml))))

