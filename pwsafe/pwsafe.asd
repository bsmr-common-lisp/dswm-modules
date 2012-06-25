(defpackage :pwsafe-system
  (:use :cl :asdf))

(in-package :pwsafe-system)

(defsystem :pwsafe
  :name "Pwsafe"
  :author "Wojciech Meyer"
  :version "0.1"
  :maintainer "Alexander aka CosmonauT Vynnyk"
  :license "GNU General Public License v2 or later"
  :description "Initial interface to pwsafe password keyring"
  :serial t
  :components ((:file "pwsafe")))
