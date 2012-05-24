(defpackage :aumix-system
  (:use :cl :asdf))

(in-package :aumix-system)

(defsystem :aumix
  :name "CPU"
  :author "Anonymous Coward, Jonathan Moore Liles"
  :version "0.1"
  maintainer
  :license "GNU General Public License v2 or later"
  :description "Aumix front end module for dswm"
  :serial t
  :components ((:file "aumix")))
