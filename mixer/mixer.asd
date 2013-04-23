(defpackage :audio-system
  (:use :cl :asdf))

(in-package :audio-system)

(defsystem :audio
  :name "AUDIO"
  :author "Julian Stecklina"
  :version "0.1"
  :maintainer "Alexander aka 'CosmonauT' Vynnyk"
  :license "GNU General Public License v2 or later"
  :description "AUDIO regulation support for the mode-line"
  :serial t
  :components ((:file "audio")
	       (:file "backend/amixer")
	       (:file "backend/aumix.lisp")
	       (:file "backend/pavol.lisp")))
