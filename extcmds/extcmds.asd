(defpackage :extcmds-system
  (:use :cl :asdf))

(in-package :extcmds-system)

(defsystem :extcmds
  :name "EXTCMDS"
  :author "Julian Stecklina"
  :version "0.1"
  :maintainer "Alexander aka 'CosmonauT' Vynnyk"
  :license "GNU General Public License v2 or later"
  :description "EXTCMDS - extended commands collection for DSWM"
  :serial t
  :components ((:file "package")
	       (:file "frame")
	       (:file "group")
	       (:file "window")
	       (:file "other")))
