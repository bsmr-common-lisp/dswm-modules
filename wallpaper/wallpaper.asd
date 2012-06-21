(defpackage :wallpaper-system
  (:use :cl :asdf))

(in-package :wallpaper-system)

(defsystem :wallpaper
  :name "Wallpaper"
  :author "Alexander aka 'CosmonauT' Vynnyk"
  :version "0.1"
  :maintainer "Alexander aka CosmonauT Vynnyk"
  :license "GNU General Public License v2 or later"
  :description "Module for setting wallpapers on root window, using various backends"
  :serial t
  :components ((:file "wallpaper")))
