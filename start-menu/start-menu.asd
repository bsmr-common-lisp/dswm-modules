(defpackage :start-menu-system
  (:use :cl :asdf))

(in-package :start-menu-system)

(defsystem :start-menu
  :name "start-menu"
  :author "Alexander aka 'CosmonauT' Vynnyk <cosmonaut.ok@gmail.com>"
  :version "0.1"
  :maintainer "Alexander aka CosmonauT Vynnyk"
  :license "GNU General Public License v2 or later"
  :description "Start menu for launch programs"
  :serial t
  :components ((:file "start-menu")))
