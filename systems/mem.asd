(defpackage :mem-system
  (:use :cl :asdf))

(in-package :mem-system)

(defsystem :mem
  :name "CPU"
  :author "Anonymous Coward, Jonathan Moore Liles"
  :version "0.1"
  maintainer
  :license "GNU General Public License v2 or later"
  :description "MEM formatters for the mode-line"
  :serial t
  :components ((:file "mem")))
