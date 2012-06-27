;;; Emacs integration for DSWM
;;;
;;; Copyright 2012 Alexander aka 'CosmonauT' Vynnyk
;;;
;;; Maintainer: Alexander aka 'CosmonauT' Vynnyk
;;;
;;; This module is free software; you can redistribute it and/or modify
;;; it under the terms of the GNU General Public License as published by
;;; the Free Software Foundation; either version 2, or (at your option)
;;; any later version.
;;;
;;; This module is distributed in the hope that it will be useful,
;;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;;; GNU General Public License for more details.
;;;
;;; You should have received a copy of the GNU General Public License
;;; along with this software; see the file COPYING.  If not, write to
;;; the Free Software Foundation, Inc., 59 Temple Place, Suite 330,
;;; Boston, MA 02111-1307 USA
;;;

;;; USAGE:
;;;
;;; Put:
;;;
;;;     (load-module "emacs")
;;;
;;; In your ~/.dswm or ~/.dswm.d/init.lisp
;;;
;;; Then you can use ...
;;;

(in-package :dswm-user)

(export '(*use-daemon-p*))

(defvar *emacs-use-daemon-p* nil
  "Use emacs daemon, or no")

(defpackage :dswm.modules.emacs
  (:use :cl :dswm))

(in-package :dswm.modules.emacs)

