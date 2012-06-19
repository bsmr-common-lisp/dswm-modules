(defpackage :s-bindings-system
  (:use :cl :asdf))

(in-package :s-bindings-system)

(defsystem :s-bindings
  :name "CPU"
  :author "Anonymous Coward, Jonathan Moore Liles"
  :version "0.1"
  maintainer
  :license "GNU General Public License v2 or later"
  :description "-*- Mode: LISP"
  :serial t
  :components ((:file "s-bindings")))
