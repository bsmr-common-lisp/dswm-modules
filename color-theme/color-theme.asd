(defpackage :color-theme-system
  (:use :cl :asdf))

(in-package :color-theme-system)

(defsystem :color-theme
  :name "COLOR-THEME"
  :author "1999-2000: Jonadab the Unsightly One <jonadab@bright.net>, 2000-2003: Alex Schroeder <alex@gnu.org>, 2003-2006: Xavier Maillard <zedek@gnu.org>, 2013: Alexander aka 'CosmonauT' Vynnyk"
  :version "0.1"
  :maintainer "Alexander aka 'CosmonauT' Vynnyk"
  :license "GNU General Public License v2 or later"
  :description "COLOR-THEME formatters for the mode-line"
  :serial t
  :components ((:file "color-theme")))
