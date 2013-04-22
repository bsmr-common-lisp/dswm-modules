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

;; (define-dswm-type :e-server
;;   (let ((server (or (argument-pop input)
;; 		    (completing-read (current-screen)
;; 				     prompt
;; 				     *emacs-server-instances*))))
;;     (let ((*current-input-history-slot* :emacs-server))
;;       (when (not (equal server (car (gethash *current-input-history-slot* *input-history*))))
;; 	(push cmd (gethash *current-input-history-slot* *input-history*)))
;;       server)))

;; (define-dswm-type :e-running-server
;;   (let ((server (or (argument-pop input)
;; 		    (completing-read (current-screen)
;; 				     prompt
;; 				     (run-shell-command
;; 				     ))))
;;     (let ((*current-input-history-slot* :emacs-server))
;;       (when (not (equal server (car (gethash *current-input-history-slot* *input-history*))))
;; 	(push cmd (gethash *current-input-history-slot* *input-history*)))
;;       server)))

(defun start-server (&key servernames)
  (if-not-null servernames
   (run-shell-command (concat *emacs-start-server* "=" servername))
   (run-shell-command *start-server*)))
   ;; (dolist (i *server-instances*)
   ;;   (run-shell-command (concat *emacs-start-server* "=" i)))))

(defun stop-server (&key servernames)
  (if-not-null servernames
   (run-shell-command (concat *stop-server* "=" servername))
   (run-shell-command *stop-server*)))

;; (defun server-stop (&key servernames save-p)
;;   (if-not-null servernames
;;    (if-not-null save-p
;;     (dolist (i servernames)
;;       (run-shell-command (concat *emacs-save-stop-server* " --socket-name=" i)))
;;     (dolist (i servernames)
;;       (run-shell-command (concat *emacs-stop-server* " --socket-name=" i))))
;;    (dolist (i *server-instances*)
;;      (run-shell-command (concat *emacs-stop-server* " --socket-name=" i)))))

(defun restart-server (&key servernames)
  (if-not-null servernames
	       (and (server-stop :servernames servernames)
		    (server-start :servernames servernames))
	       (and (server-stop)
		    (server-start))))

(defun reload-server (&key servername)
  (princ "Not implemented"))

(defcommand e-start-server () ()
  (if (start-server)
      (message "Emacs server started")
    (error "Cannot start server")))

(defcommand e-stop-server () ()
  (if (stop-server)
      (message "Emacs server stopped")
    (error "Cannot stop server")))

(defcommand e-restartserver () ()
  (restart-server))
