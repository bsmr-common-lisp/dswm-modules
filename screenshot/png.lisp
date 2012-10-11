;;; Screenshot maker
;;;
;;; Copyright 2012 Michael Filonenko
;;;
;;; Maintainer: Alexander aka 'CosmonauT' Vynnyk
;;;
;;; License?
;;;
;;; USAGE:
;;;
;;; Put:
;;;
;;;     (load-module "screenshot")
;;;
;;; In your ~/.dswm or ~/.dswm.d/init.lisp
;;;

(in-package :dswm)

(defcommand screenshot
  (filename)
  ((:rest "Filename: "))
  "Make screenshot of root window"
  (%screenshot-window (screen-root (current-screen)) filename))

(defcommand screenshot-window
  (filename)
  ((:rest "Filename: "))
  "Make screenshot of focus window"
  (%screenshot-window (window-xwin (current-window)) filename))
