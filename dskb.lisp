(defvar *dskb-keymaps* '())

(defvar *dskb-switch* "")

(defvar *dskb-led* "")

(defvar *setxkbmap-command* "/usr/bin/setxkbmap")


(defstruct dskb-keymap
  "keymap options"
  name
  layout-name
  variants)

(defstruct dskb-switch
  name
  command-string)

(defstruct dskb-led
  name
  command-string)














(defmacro add-dskb-map (name layout-name variants)
  `(add-to-list *dskb-keymaps* (make-dskb-keymap
				:name ,name
				:layout ,layout-name
				:variants ,variants)))

(defmacro add-dskb-switch (name command-string)
  `(add-to-list *dskb-switch* (make-dskb-switch
			       :name ,name
			       :command-string ,command-string)))

(defmacro add-dskb-led (name command-string)
  `(add-to-list *dskb-led*

;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; Keymap definitions ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setf dskb-keymaps '((make-dskb-keymap :name "English" :layout "en" :variants '())
		     (make-dskb-keymap :name "Ukrainian" :layout "ua" :variants '("winkeys"))
		     (make-dskb-keymap :name "Russian" :layout "ru" :variants '("winkeys"))))

(setf dskb-switches '((make-dskb-switch :name "Alt+Shift" :command-string "alt_shift_toggle")
		      (make-dskb-switch :name "Control+Shift" :command-string "ctrl_shift_toggle")
		      (make-dskb-switch :name "Control+Alt" :command-string "ctrol_alt_toggle")))

(setf dskb-leds '((make-dskb-led :name "Scroll lock" :command-string "scroll")))


(defcommand set-xkb-map () ()
  (