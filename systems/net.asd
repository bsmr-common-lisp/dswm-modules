(defpackage :net-system
  (:use :cl :asdf))

(in-package :net-system)

(defsystem :net
  :name "CPU"
  :author "Anonymous Coward, Jonathan Moore Liles"
  :version "0.1"
  maintainer
  :license "GNU General Public License v2 or later"
  :description "Network activity formatter for the mode-line"
  :serial t
  :components ((:file "net")))
