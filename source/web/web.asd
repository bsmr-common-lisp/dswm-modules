(defpackage :web-system
  (:use :cl :asdf))

(in-package :web-system)

(defsystem :web
  :name "Web"
  :author "Anonymous Coward, Jonathan Moore Liles"
  :version "0.1"
  ;; maintainer
  :license "GNU General Public License v2 or later"
  :description "CPU formatters for the mode-line"
  :serial t
  :components ((:file "web")))