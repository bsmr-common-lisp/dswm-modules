(defpackage :battery-system
  (:use :cl :asdf))

(in-package :battery-system)

(defsystem :battery
  :name "CPU"
  :author "Anonymous Coward, Jonathan Moore Liles"
  :version "0.1"
  maintainer
  :license "GNU General Public License v2 or later"
  :description "Battery charge formatters for the mode-line"
  :serial t
  :components ((:file "battery")))
