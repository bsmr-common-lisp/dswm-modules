;;; -*- Mode: LISP; Syntax: Common-lisp; Package: dswm -*-

;; Copyright 2011 Alexander aka 'CosmonauT' Vynnyk
;;
;; Author: Alexander aka 'CosmonauT' Vynnyk <cosmonaut.ok@gmail.com>
;; Version: id: keypad,v 0.1 22 Feb 2011 cosmonaut.ok@gmail.com
;; Keywords:
;; X-URL: not distributed yet

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program; if not, write to the Free Software
;; Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.

;;; Commentary:

;;;==================================================================
;;; Filename: keypad.lisp
;;; Super- extrabindings for dswm (experimental)
;;;==================================================================
;;
;;
;;

;;; Code:
(defpackage :dswm.module.keypad
  (:use :cl :dswm))

(in-package :dswm.module.keypad)

(defmacro defkey-top (key cmd)
  `(define-key *top-map* (kbd ,key) ,cmd))

(defmacro defkeys-top (&rest keys)
  (let ((ks (mapcar #'(lambda (k) (cons 'defkey-top k)) keys)))
    `(progn ,@ks)))

(defvar *kp-move-map* nil)
(defvar *kp-group-map* nil)
(defvar *kp-resize-map* nil)

;; (defvar *kp-group-key* (kbd "KP_Begin"))

(defvar *kp-move-map* nil)
(defvar *kp-group-move-map* nil)
(defvar *kp-resize-key* nil)

  (kbd "Up")      "move-focus up"
  (kbd "Down")    "move-focus down"
  (kbd "Left")    "move-focus left"
  (kbd "Right")   "move-focus right"
  (kbd "M-Up")    "move-window up"
  (kbd "M-Down")  "move-window down"
  (kbd "M-Left")  "move-window left"
  (kbd "M-Right") "move-window right"

(defkeys-top
  ("KP_Left" "move-focus left")
  ("KP_Right" "move-focus right")
  ("KP_Up" "move-focus up")
  ("KP_Down" "move-focus down")
  ("KP_Home" "fselect")
  ("KP_End" "")
  ("KP_Page_Up" "vsplit")
  ("KP_Page_Down" "hsplit")
  ("KP_Insert" "")
  ("KP_Delete" "")
  ("KP_Enter" "")
  ("KP_Divide" "vgroups")
  ("KP_Multiply" "mark")
  ("KP_Subtract" "")
  ("KP_Add" "balance-frames")
  ("KP_Begin" *kp-group-map*))

(fill-keymap *kp-group-map*

  (kbd "KP_Left") "gprev"
  (kbd "KP_Right") "gnext"
  (kbd "KP_Up") "gother"
  (kbd "KP_Down") "scratchpad"
  (kbd "KP_Home") "gselect"
  (kbd "KP_End") ""
  (kbd "KP_Page_Up") ""
  (kbd "KP_Page_Down") ""
  (kbd "KP_Insert") ""
  (kbd "KP_Delete") ""
  (kbd "KP_Enter") ""
  (kbd "KP_Divide") "vgroups"
  (kbd "KP_Multiply") ""
  (kbd "KP_Subtract") ""
  (kbd "KP_Add") "gnew"
  (kbd "KP_Begin") *kp-group-map*)

  (kbd "g")     "vgroups"
  (kbd "c")     "gnew"
  (kbd "n")     "gnext"
  (kbd "C-n")   "gnext"
  (kbd "SPC")   "gnext"
  (kbd "C-SPC") "gnext"
  (kbd "N")     "gnext-with-window"
  (kbd "p")     "gprev"
  (kbd "C-p")   "gprev"
  (kbd "P")     "gprev-with-window"
  (kbd "o")     "gother"
  (kbd "'")     "gselect"
  (kbd "\"")    "grouplist"
  (kbd "m")     "gmove"
  (kbd "M")     "gmove-marked"
  (kbd "s")     "gmove-scratchpad"
  (kbd "S")     "gmove-marked-scratchpad"
  (kbd "k")     "gkill"
  (kbd "A")     "grename"
  (kbd "r")     "grename"
  (kbd "!")     "grun-new"
  (kbd "@")     "grun-new-float"
  (kbd "1")     "gselect 1"
  (kbd "2")     "gselect 2"
  (kbd "3")     "gselect 3"
  (kbd "4")     "gselect 4"
  (kbd "5")     "gselect 5"
  (kbd "6")     "gselect 6"
  (kbd "7")     "gselect 7"
  (kbd "8")     "gselect 8"
  (kbd "9")     "gselect 9"
  (kbd "0")     "gselect 10")


;;; keypad.lisp ends here

