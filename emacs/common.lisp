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

(defpackage :dswm.module.emacs
  (:use :cl :dswm :dswm-user)
  (:export *use-daemon-p*))

(in-package :dswm.modules.emacs)

(defvar *emacs-use-daemon-p* nil
  "Use emacs daemon, or no")

(defvar *emacs-daemon-command* "emacs --daemon")
(defvar *emacs-client-command* "emacsclient")
(defvar *emacs-client-options* (make-hash-table :test 'equal))
(defvar *emacs-options* (make-hash-table :test 'equal))
(defvar *emacs-client-alternate-editor* "emacs")

(setf
 (gethash 'version *emacs-client-options*) "-v"
 (gethash 'help *emacs-client-options*) "-H"
 (gethash 'no-windows *emacs-client-options*) "-nw"
 (gethash 'new-frame *emacs-client-options*) "-c"
 (gethash 'eval *emacs-client-options*) "-e"
 (gethash 'quiet *emacs-client-options*) "-q"
 (gethash 'socket *emacs-client-options*) "-s"
 (gethash 'server *emacs-client-options*) "-f"
 (gethash 'alt *emacs-client-options*) "-a"
)

(setf
 (gethash 'version *emacs-client-options*) "-v"
 (gethash 'help *emacs-client-options*) "-H"
 (gethash 'no-windows *emacs-client-options*) "-nw"
 (gethash 'new-frame *emacs-client-options*) "-c"
 (gethash 'eval *emacs-client-options*) "-e"
 (gethash 'quiet *emacs-client-options*) "-q"
 (gethash 'socket *emacs-client-options*) "-s"
 (gethash 'server *emacs-client-options*) "-f"
 (gethash 'alt *emacs-client-options*) "-a"
)
 
(defvar *emacs-command* 
  
