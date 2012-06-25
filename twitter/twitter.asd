(defpackage :twitter-system
  (:use :cl :asdf))

(in-package :twitter-system)

(defsystem :twitter
  :name "Twitter"
  :author "Anonymous Coward, Jonathan Moore Liles"
  :version "0.1"
  :maintainer "Alexander aka CosmonauT Vynnyk"
  :license "GNU General Public License v2 or later"
  :description "TODO"
  :serial t
  :components ((:file "twitter")))
