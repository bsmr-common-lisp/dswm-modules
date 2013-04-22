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
;;(in-package :dswm.modules.emacs)
(in-package #:dswm)

(defcommand e-switch-to-buffer (buffer) ((:emacs-buffer "Input emacs buffer name: "))
  (let ((cw (current-window)))
    (if (and (not (null cw))
	     (equal (window-class cw) "Emacs"))
	(run-shell-command
	 (make-emacs-call "(switch-to-buffer \"" buffer "\")"))
	(run-shell-command
	 (make-emacs-call-in-new-frame "(switch-to-buffer \"" buffer "\")")))))

(defcommand e-list-buffres () ()
  (let ((cw (current-window)))
    (if (and (not (null cw))
	     (equal (window-class cw) "Emacs"))
	(switch-current-buffer-from-menu)
	(open-buffer-from-menu))))

(defcommand e-set-current-buffer () ()
  (switch-current-buffer-from-menu))

(defcommand e-kill-buffer (buffer) ((:emacs-existent-buffer "Input emacs buffer name to kill: "))
  (run-shell-command
   (make-emacs-call "(kill-buffer \"" buffer "\")")))

(defcommand e-kill-buffer-from-menu () ()
  (let ((z (select-from-menu (current-screen) (e-buffers))))
    (run-shell-command
     (make-emacs-call "(kill-buffer \"" z "\")"))))

(defcommand e-rename-buffer (buffer) ((:string "Input new emacs buffer name: "))
  ;; TODO creates new buffer
  (let ((current-buffer (car (e-buffers))))
    (run-shell-command
     (make-emacs-call "(rename-buffer \"" buffer "\")"))))

(defcommand e-rename-buffer-from-menu () ()
   (let ((current-buffer (car (e-buffers))))
     (switch-current-buffer-from-menu)
     (run-commands "e-rename-buffer")
     (run-shell-command
      (make-emacs-call "(switch-to-buffer \"" current-buffer "\")"))))

(defcommand e-find-file (file) ((:file "Input filename to open: "))
   (run-shell-command
    (make-emacs-call-in-new-frame "(find-file \"" file "\")")))

(defcommand e-eval (eval) ((:string "Input emacs code to eval: "))
   (run-shell-command
    (make-emacs-call eval)))

(defcommand e-start-client () ()
   (run-shell-command (concat *ec-cmd* " -c")))

(defcommand e-save-modified-buffers () ()
  (run-shell-command
   (make-emacs-call "(save-some-buffers t)")))
