(defpackage :emacs-system
  (:use :cl :asdf))

(in-package :emacs-system)

(defsystem :emacs
  :name "EMACS"
  :author "Alexander Vynnyk"
  :version "0.1"
  :maintainer "Alexander aka 'CosmonauT' Vynnyk"
  :license "GNU General Public License v2 or later"
  :description "DSWM extension for better working with emacs"
  :serial t
  :components ((:file "package")
	       (:file "common")
	       (:file "emacsclient")
	       (:file "emacs")))
