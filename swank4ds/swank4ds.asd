(defpackage :swank-loader
  (:use :cl))

(in-package :swank-loader)

(asdf:defsystem :swank4ds
  :name "SWANK4DS"
  :author "Daniel Barlow"
  :version "20120627"
  :maintainer "Alexander aka 'CosmonauT' Vynnyk"
  :license "Public Domain"
  :description "SWANK support for DSWM"
  :serial t
  :components ((:file "swank-loader")
	       (:file "swank4ds")))
