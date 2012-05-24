(defpackage :wifi-system
  (:use :cl :asdf))

(in-package :wifi-system)

(defsystem :wifi
  :name "CPU"
  :author "Anonymous Coward, Jonathan Moore Liles"
  :version "0.1"
  maintainer
  :license "GNU General Public License v2 or later"
  :description "Wifi formatter for the mode-line"
  :serial t
  :components ((:file "wifi")))
