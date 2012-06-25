(defpackage :keyboards-system
  (:use :cl :asdf))

(in-package :keyboards-system)

(defsystem :keyboards-system
  :name "Keyboadrs"
  :author "Alexander aka 'CosmonauT' Vynnyk,Ted Zlatanov"
  :version "0.1"
  :maintainer "Alexander aka 'CosmonauT' Vynnyk"
  :license "GNU General Public License v2 or later"
  :description "Keysyms and configuration templates for various non-standard keyboards"
  :serial t
  :components ((:file "g15-keysyms")
	       (:file "msnatural-4000_7000-keysyms")
	       (:file "keyboards")
	       ))
