(defpackage :window-tags-system
  (:use :cl :asdf))

(in-package :window-tags-system)

(defsystem :window-tags
  :name "CPU"
  :author "Anonymous Coward, Jonathan Moore Liles"
  :version "0.1"
  maintainer
  :license "GNU General Public License v2 or later"
  :description ""
  :serial t
  :components ((:file "window-tags")))
