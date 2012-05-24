(defpackage :mpd-system
  (:use :cl :asdf))

(in-package :mpd-system)

(defsystem :mpd
  :name "CPU"
  :author "Anonymous Coward, Jonathan Moore Liles"
  :version "0.1"
  maintainer
  :license "GNU General Public License v2 or later"
  :description "MPD client description formatters for dswm"
  :serial t
  :components ((:file "mpd")))
