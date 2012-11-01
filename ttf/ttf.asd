;;;; clx-truetype.asd

(defpackage :ttf-system
  (:use :cl :asdf))

(in-package :ttf-system)

(defsystem #:clx-truetype
  :serial t
  :description "clx-truetype is pure common lisp solution for antialiased TrueType font rendering using CLX and XRender extension."
  :author "Michael Filonenko <filonenko.mikhail@gmail.com>"
  :license "MIT"
  :version "0.1"
  :depends-on (#:clx
               #:zpb-ttf
               #:cl-vectors
               #:cl-paths-ttf
               #:cl-aa
               #:cl-store
               #:trivial-features)
  :components ((:file "package")
               (:file "clx-utils")
               (:file "font-cache")
               (:file "clx-truetype")))

(defsystem #:ttf
  :name "TTF"
  :author "Michael Filonenko <filonenko.mikhail@gmail.com>, Alexander aka 'CosmonauT' Vynnyk"
  :version "0.1"
  :maintainer "Alexander aka 'CosmonauT' Vynnyk"
  :license "GNU General Public License v2 or later"
  :description "TTF support module for the mode-line"
  :serial t
  :depends-on (#:clx-truetype)
  :components ((:file "ttf")))
