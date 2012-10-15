(defpackage :cmus-system
  (:use :cl :asdf))

(in-package :cmus-system)

(defsystem :cmus
  :name "CMUS"
  :author "JD Adams"
  :version "0.1"
  :maintainer "Alexander aka 'CosmonauT' Vynnyk"
  :license "GNU General Public License v2 or later"
  :description "CMUS player frontend for DSWM"
  :serial t
  :components ((:file "cmus")
	       (:file "controls")))
