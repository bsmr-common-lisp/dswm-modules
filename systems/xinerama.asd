(defpackage :xinerama-system
  (:use :cl :asdf))

(in-package :xinerama-system)

(defsystem :xinerama
  :name "Xinerama"
  :author "Alexander aka 'CosmonauT' Vynnyk"
  :version "0.1"
  maintainer
  :license "GNU General Public License v2 or later"
  :description "-*- Mode: LISP"
  :serial t
  :components ((:file "xinerama")))
