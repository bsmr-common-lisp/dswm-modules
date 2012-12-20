(defpackage :hyperbookmarks-system
  (:use :cl :asdf))

(in-package :hyperbookmarks-system)

(defsystem :hyperbookmarks
  :name "HYPERBOOKMARKS"
  :author "Alexander aka CosmonauT Vynnyk <cosmonaut.ok@gmail.com>"
  :version "0.1"
  :maintainer "Alexander aka CosmonauT Vynnyk"
  :license "GNU General Public License v2 or later"
  :description "Hyperbookmarks extension for DSWM"
  :serial t
  :components ((:file "hyperbookmarks")))
