(defpackage :wallpaper-system
  (:use :cl :asdf))

(in-package :wallpaper-system)

(defsystem :wallpaper
  :name "CPU"
  :author "Anonymous Coward, Jonathan Moore Liles"
  :version "0.1"
  maintainer
  :license "GNU General Public License v2 or later"
  :description "(defstruct wallpaper-maker"
  :serial t
  :components ((:file "wallpaper")))
