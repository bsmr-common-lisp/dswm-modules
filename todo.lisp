;;; -*- Mode: LISP; Syntax: Common-lisp; Package: dswm.web -*-

;; Copyright 2012 Alexander aka 'CosmonauT' Vynnyk
;;
;; Author: Alexander aka CosmonauT Vynnyk <cosmonaut.ok@gmail.com>
;; Version: id: web,v 0.1 20 Mar 2012 cosmonaut.ok@gmail.com
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
;;; Filename: todo.lisp
;;; TODO for dswm
;;;==================================================================
;;
;;
;;; Code:
(defpackage :dswm.modules.todo
  (:use :common-lisp :dswm :cl-ppcre))

(in-package :dswm-user)

(defvar *todos-list* nil
  "Defines list of all todos, saved by user")

(defvar *todos-file* (data-dir-file "todos" "list")
  "Defines default todo file")

(defstruct todo
  "Todo structure"
  name description time)

(define-dswm-type :todo (input prompt)
  (or (argument-pop input)
      (completing-read (current-screen)
                       prompt
                       (get-todo-names-list))))

(define-dswm-type :todo-time (input prompt)
  (eval (cons 'encode-universal-time
	      (coerce
	       (or (argument-pop-rest input)
		   (read-one-line (current-screen) prompt)) 'list))))

(defun get-todo-names-list (&optional (list *todos-list*))
  (cond
    ((null (car list)) nil)
    (t (cons (todo-name (car list))
             (get-todo-names-list (cdr list))))))

(defun get-descriptions-list (&optional (list *todos-list*))
  (cond
    ((null (car list)) nil)
    (t (cons (todo-name (car list))
             (get-todo-names-list (cdr list))))))

(defun find-todo (&key name description time (list *todos-list*))
  (cond ((null list) nil)
        ((or
          (and (not (null name))
               (equal name (todo-name (car list))))
          (and (not (null description))
               (equal description (todo-description (car list))))
          (and (not (null time))
               (equal time (todo-time (car list)))))
         (car list))
        (t
         (find-todo
          :name name
          :description description
          :time time
          :list (cdr list)))))

(defmacro find-todo-by-name (name)
  `(find-todo :name ,name))

(defmacro find-todo-by-description (description)
  `(find-todo :description ,description))

(defmacro find-todo-by-time (time)
  `(find-todo :time ,time))

(defun dump-todos (&optional (hbdump *todos-list*))
  (dswm::dump-structure hbdump t *todos-file*))



(defcommand todo-add (name description time)
  ((:string "Enter todo name: ")
   (:rest "Explain, please, what do you want to do: ")
   (:todo-time "To what date you have to do this task? "))
  (if
      (null (find-todo-by-name name))
      (progn
	(dswm::add-to-list *todos-list*
			   (make-todo
			    :name name
			    :description description
			    :time time))
	(dump-todos))
    (message "todo '~a' already exists" name)))

(defcommand todo-remove (name) ((:todo "What todo
  do you want to remove? "))
  (dswm::remove-from-list
   *todos-list*
   (find-todo-by-name name))
  (dump-todos))

(defcommand todo-open (name)
  ((:todo "Enter todo name: "))
  (let ((bookmark (find-todo-by-name name)))
    (run-shell-command
     (dswm::concat (todo-description bookmark)
             " "
             (todo-time bookmark)))))

(defcommand todo-list () ()
            (let ((list "Name~20tdescription~50ttime~%
-------------------------------------------------------------------------~%"))
              (dolist (i *todos-list*)
                (setf list (concatenate 'string list
                                        (todo-name i) "~20t"
                                        (todo-description i) "~50t"
                                        (todo-time i) "~%")))
               (message list)))

(defcommand todo-reload () ()
  (if (probe-file *todos-file*)
      (progn
        (setf *todos-list*
              (dswm::read-dump-from-file *todos-file*))
        (message "Loaded"))
        (message "Nothing to load")))


;; Initialization
;;(todo-reload)
;;(add-to-list *todos-list*

;;; web.lisp ends here

