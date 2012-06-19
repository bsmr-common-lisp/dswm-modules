(defpackage :g15-keysyms-system
  (:use :cl :asdf))

(in-package :g15-keysyms-system)

(defsystem :g15-keysyms
  :name "CPU"
  :author "Anonymous Coward, Jonathan Moore Liles"
  :version "0.1"
  maintainer
  :license "GNU General Public License v2 or later"
  :description "keysyms for the Logitech G15 keyboard"
  :serial t
  :components ((:file "g15-keysyms")))
