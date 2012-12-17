(defpackage :ql4ds-system
  (:use :cl :asdf))

(in-package :ql4ds-system)

(defsystem :ql4ds
  :name "QL4DS"
  :author "Alexander aka 'CosmonauT' Vynnyk"
  :version "0.1"
  :maintainer "Alexander aka 'CosmonauT' Vynnyk"
  :license "GNU General Public License v2 or later"
  :description "QL4DS formatters for the mode-line"
  :serial t
  :components ((:file "packages")
	       (:file "quicklisp")
	       (:file "load")
	       (:file "library")
	       (:file "ql4ds")))
