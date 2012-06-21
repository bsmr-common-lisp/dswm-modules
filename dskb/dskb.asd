(defpackage :dskb-system
  (:use :cl :asdf))

(in-package :dskb-system)

(defsystem :dskb
  :name "DSKB"
  :author "Alexander aka 'CosmonauT' Vynnyk"
  :version "0.1"
  :maintainer "Alexander aka 'CosmonauT' Vynnyk"
  :license "GNU General Public License v2 or later"
  :description "Keyboard layout definitions  and mode-line information module for DSWM"
  :serial t
  :components ((:file "dskb")))
