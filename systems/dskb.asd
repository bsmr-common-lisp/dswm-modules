(defpackage :dskb-system
  (:use :cl :asdf))

(in-package :dskb-system)

(defsystem :dskb
  :name "CPU"
  :author "Anonymous Coward, Jonathan Moore Liles"
  :version "0.1"
  maintainer
  :license "GNU General Public License v2 or later"
  :description "(defvar *dskb-keymaps* '())"
  :serial t
  :components ((:file "dskb")))
