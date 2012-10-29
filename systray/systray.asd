(defpackage :systray-system
  (:use :cl :asdf))

(in-package :systray-system)

(defsystem :systray
  :name "systray"
  :author "Alessandro Piras"
  :version "0.1"
  :maintainer "Alexander aka 'CosmonauT' Vynnyk"
  :license "GNU General Public License v2 or later"
  :description "System tray for DSWM"
  :serial t
  :depends-on (#:xembed #:alexandria)
  :components ((:file "systray")))
