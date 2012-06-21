(defpackage :amixer-system
  (:use :cl :asdf))

(in-package :amixer-system)

(defsystem :amixer
  :name "Amixer"
  :author "Amy Templeton, Jonathan Moore Liles, Ivy Foster"
  :version "0.1"
  :maintainer "Ivy Foster"
  :license "GNU General Public License v2 or later"
  :description "Amixer module for DSWM."
  :serial t
  :components ((:file "amixer")))
