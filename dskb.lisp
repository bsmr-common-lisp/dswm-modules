


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
