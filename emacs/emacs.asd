(defvar dswm-user:*emacs-use-swank-p* nil)

(defpackage :emacs-system
  (:use :cl :asdf))

(in-package :emacs-system)

(defsystem :emacs
  :name "EMACS"
  :author "Alexander aka 'CosmonauT' Vynnyk"
  :version "0.1"
  :maintainer "Alexander aka 'CosmonauT' Vynnyk"
  :license "GNU General Public License v2 or later"
  :description "Emacs integration for DSWM"
  :serial t
  :depends-on ((when (not (null dswm-user:*emacs-use-swank-p*))) :swank)
  :components ((:file "daemon")
	       (:file "client")
	       (:file "emacs")
	       (:file "common")))
