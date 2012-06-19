(defpackage :wmii-like-dswmrc-system
  (:use :cl :asdf))

(in-package :wmii-like-dswmrc-system)

(defsystem :wmii-like-dswmrc
  :name "CPU"
  :author "Anonymous Coward, Jonathan Moore Liles"
  :version "0.1"
  maintainer
  :license "GNU General Public License v2 or later"
  :description "-*- Mode: Lisp -*-"
  :serial t
  :components ((:file "wmii-like-dswmrc")))
