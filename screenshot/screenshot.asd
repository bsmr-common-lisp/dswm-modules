(defpackage :screenshot-system
  (:use :cl :asdf))

(in-package :screenshot-system)

(defsystem :screenshot
  :name "Screenshot"
  :author "Michail Filonenko"
  :version "0.1"
  :maintainer "Alexander aka CosmonauT Vynnyk"
  :license "as is"
  :description "Module for making screenshots"
  :serial t
  :depends-on (#:zpng
               #:cl-jpeg)
  :components ((:file "common")
               (:file "png")
               (:file "jpg")))
