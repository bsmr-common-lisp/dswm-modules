(defpackage :cpu-system
  (:use :cl :asdf))

(in-package :cpu-system)

(defsystem :cpu
  :name "CPU"
  :author "Anonymous Coward, Jonathan Moore Liles"
  :version "0.1"
  maintainer
  :license "GNU General Public License v2 or later"
  :description "CPU formatters for the mode-line"
  :serial t
  :components ((:file "cpu")))
