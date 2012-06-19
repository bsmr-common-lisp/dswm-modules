(defpackage :notifications-system
  (:use :cl :asdf))

(in-package :notifications-system)

(defsystem :notifications
  :name "CPU"
  :author "Anonymous Coward, Jonathan Moore Liles"
  :version "0.1"
  maintainer
  :license "GNU General Public License v2 or later"
  :description "notifications.lisp -- Poor man's systray for DSWM"
  :serial t
  :components ((:file "notifications")))
