(defpackage :todo-system
  (:use :cl :asdf))

(in-package :todo-system)

(defsystem :todo
  :name "CPU"
  :author "Anonymous Coward, Jonathan Moore Liles"
  :version "0.1"
  maintainer
  :license "GNU General Public License v2 or later"
  :description "-*- Mode: LISP"
  :serial t
  :components ((:file "todo")))
