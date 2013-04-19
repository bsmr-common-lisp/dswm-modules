;; Copyright (C) 2003-2008 Shawn Betts
;; Copyright (C) 2010-2012 Alexender aka CosmonauT Vynnyk
;;
;;  This file is part of dswm.
;;
;; dswm is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.

;; dswm is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this software; see the file COPYING.  If not, see
;; <http://www.gnu.org/licenses/>.

;; Commentary:
;;
;; define standard key bindings
;;
;; Code:

(in-package #:dswm)

(export '(*emacs-map*))

;; (defvar *emacs-key* "e")

(defvar *emacs-map* nil
  "The keymap that group related key bindings sit on. It is bound to @kbd{C-j g} by default.")








(defmacro defkey-root (key cmd)
  `(define-key *root-map* (kbd ,key) ,cmd))

(defmacro defkeys-root (&rest keys)
  (let ((ks (mapcar #'(lambda (k) (cons 'defkey-root k)) keys)))
    `(progn ,@ks)))

(defkeys-root
    ("e"  *emacs-map*)
    ("C-e" *emacs-map*))


(fill-keymap *emacs-map*
  (kbd "e") "send-escape"
  (kbd "b") "e-open-buffer"
  (kbd "C-b") "e-switch-to-buffer"
  (kbd "f") "e-open-file"
  (kbd "k") "e-fill-current"
  (kbd "C-k") "e-kill-buffer"
  (kbd "x") "e-colon"
  (kbd ":") "e-eval"
  (kbd "C-e" "e-start-client"))

