(defpackage :decorations-system
  (:use :cl :asdf))

(in-package :decorations-system)

(defsystem :decorations
  :name "Decorations"
  :author "Alexander aka CosmonauT Vynnyk"
  :version "0.1"
  :maintainer "Alexander aka CosmonauT Vynnyk"
  :license "GNU General Public License v2 or later"
  :description "-*- Mode: LISP"
  :serial t
  :components ((:file "decorations")))
