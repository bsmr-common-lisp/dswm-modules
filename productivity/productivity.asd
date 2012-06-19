(defpackage :productivity-system
  (:use :cl :asdf))

(in-package :productivity-system)

(defsystem :productivity
  :name "CPU"
  :author "Anonymous Coward, Jonathan Moore Liles"
  :version "0.1"
  maintainer
  :license "GNU General Public License v2 or later"
  :description ""
  :serial t
  :components ((:file "productivity")))
