(defpackage :helen-system
  (:use :cl :asdf))

(in-package :helen-system)

(defsystem :helen
  :name "CPU"
  :author "Anonymous Coward, Jonathan Moore Liles"
  :version "0.1"
  maintainer
  :license "GNU General Public License v2 or later"
  :description "-*- Mode: Lisp"
  :serial t
  :components ((:file "helen")))
