(defpackage :disk-system
  (:use :cl :asdf))

(in-package :disk-system)

(defsystem :disk
  :name "CPU"
  :author "Anonymous Coward, Jonathan Moore Liles"
  :version "0.1"
  maintainer
  :license "GNU General Public License v2 or later"
  :description "Disk usage monitoring for dswm's modeline"
  :serial t
  :components ((:file "disk")))
