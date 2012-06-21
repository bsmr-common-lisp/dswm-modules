(defpackage :eliza-system
  (:use :cl :asdf))

(in-package :eliza-system)

(defsystem :eliza
  :name "Eliza"
  :author "Peter Norvig"
  :version "0.1"
  :maintainer "Alexander aka CosmonauT Vynnyk"
  :license "GNU General Public License v2 or later"
  :description "-*- Mode: Lisp"
  :serial t
  :components ((:file "eliza")))
