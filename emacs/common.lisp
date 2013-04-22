;;; -*- Mode: LISP; Syntax: Common-lisp; Package: dswm.modules.emacs -*-

;; Copyright 2011 Alexander aka 'CosmonauT' Vynnyk
;;
;; Author: Alexander aka CosmonauT Vynnyk <cosmonaut.ok@gmail.com>
;; Version: id: web,v 0.1 22 Apr 2013 cosmonaut.ok@gmail.com
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
;;; Filename: package.lisp
;;; Eamcs integration extension for dswm
;;;==================================================================
;;;
;;; Code:
;; (in-package :dswm.modules.emacs)
(in-package :dswm)

(defvar *emacs-cmd* "emacs")
(defvar *ec-cmd* "emacsclient")


(defvar *server-instances* '("default"))

;; emacs server start-stop
(defvar *start-server* "emacs --daemon")
(defvar *stop-server* "emacsclient -e '(kill-emacs)'")
(defvar *save-stop-server* "emacsclient -e '(client-save-kill-emacs)'")

(defvar *shortcut-hash* (make-hash-table))

;;;; Common functions
(defun make-emacs-call (&rest rest)
  "Make emacs call"
  (eval (append (list 'concat *ec-cmd* " -e '") rest '("'"))))

(defun make-emacs-call-in-new-frame (&rest rest)
  "Make emacs call to run it in new `emacs frame`"
  (eval (append (list 'concat *ec-cmd* " -c -e '") rest '("'"))))

(defun e-call (&rest body)
  "Call from emacsclient to emacs daemon to run some command"
  (run-shell-command
   (eval (cons 'make-emacs-call body)) t))

(defun e-buffers ()
  (cl-ppcre:split 
   "\"+\ \"+|\"+"
   (cl-ppcre:regex-replace-all
    "\\(\"|\"\\)" 
    (e-call "(mapcar (function buffer-name) (buffer-list))") "")))
;;;; /Common functions

;;; DSWM types
(define-dswm-type :emacs-buffer (input prompt)
  (let ((*current-input-history-slot* :emacs-buffer))
    (or (argument-pop-rest input)
	(completing-read (current-screen) prompt (e-buffers) :require-match nil))))

(define-dswm-type :emacs-existent-buffer (input prompt)
  (let ((*current-input-history-slot* :emacs-buffer))
    (or (argument-pop-rest input)
	(completing-read (current-screen) prompt (e-buffers) :require-match t))))
;;; /DSWM types

(defun switch-current-buffer-from-menu ()
  (let ((z (select-from-menu (current-screen) (e-buffers))))
    (run-shell-command
     (make-emacs-call
	 (concat "(switch-to-buffer \"" z "\")")))))

(defun open-buffer-from-menu ()
  (let ((z (select-from-menu (current-screen) (e-buffers))))
    (run-shell-command (make-emacs-call-in-new-frame "(switch-to-buffer \"" z "\")"))))

;;; common.lisp ends here