(defpackage :ql4ds-system
  (:use :cl :asdf))

(in-package :ql4ds-system)

(asdf:defsystem #:quicklisp
  :name "quicklisp"
  :description "The Quicklisp client application, adopted for useing as DSWM module"
  :author "Zach Beane <zach@quicklisp.org> Alexander aka CosmonauT Vynnyk <cosmonaut.ok@gmail.com>"
  :maintainer "Alexander aka CosmonauT Vynnyk"
  :license "BSD-style"
  :serial t
  :version "2012010700"
  :components ((:file "init")
	       (:file "package")
               (:file "utils")
               (:file "config")
               (:file "impl")
               (:file "impl-util")
               (:file "network")
               (:file "progress")
               (:file "http")
               (:file "deflate")
               (:file "minitar")
               (:file "cdb")
               (:file "dist")
               (:file "setup")
               (:file "client")
               (:file "client-update")
               (:file "dist-update")
               (:file "misc")
               (:file "local-projects")
	       (:file "quicklisp-dswm")))
