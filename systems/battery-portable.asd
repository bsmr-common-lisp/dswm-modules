(defpackage :battery-portable-system
  (:use :cl :asdf))

(in-package :battery-portable-system)

(defsystem :battery-portable
  :name "CPU"
  :author "Anonymous Coward, Jonathan Moore Liles"
  :version "0.1"
  maintainer
  :license "GNU General Public License v2 or later"
  :description "Portable battery information for DSWM's mode-line."
  :serial t
  :components ((:file "battery-portable")))
