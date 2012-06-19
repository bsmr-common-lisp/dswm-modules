(defpackage :web-system
  (:use :cl :asdf))

(in-package :web-system)

(defsystem :web
  :name "CPU"
  :author "Anonymous Coward, Jonathan Moore Liles"
  :version "0.1"
  maintainer
  :license "GNU General Public License v2 or later"
  :description "-*- Mode: LISP"
  :serial t
  :components ((:file "web")))
