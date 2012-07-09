(defpackage :audio-system
  (:use :cl :asdf))

(in-package :audio-system)

(defsystem :audio
  :name "Audio"
  :author "Amy Templeton, Jonathan Moore Liles, Ivy Foster, Fredrik Tolf, Diogo F. S. Ramos, Alexander aka CosmonauT Vynnyk"
  :version "0.1"
  :maintainer "Alexander aka CosmonauT Vynnyk"
  :license "GNU General Public License v3 or later"
  :description "Audio module for DSWM."
  :serial t
  :depends-on (:cl-ppcre)
  :components ((:file "common")
	       (:file "aumix")
	       (:file "amixer")
	       (:file "pavol")
	       (:file "audio")))
