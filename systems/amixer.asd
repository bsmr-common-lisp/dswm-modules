(defpackage :amixer-system
  (:use :cl :asdf))

(in-package :amixer-system)

(defsystem :amixer
  :name "CPU"
  :author "Anonymous Coward, Jonathan Moore Liles"
  :version "0.1"
  maintainer
  :license "GNU General Public License v2 or later"
  :description "Amixer module for DSWM."
  :serial t
  :components ((:file "amixer")))
