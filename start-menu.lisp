;;; -*- Mode: LISP; Syntax: Common-lisp; Package: dswm -*-

;; Copyright 2010 Alexander aka 'CosmonauT' Vynnyk
;;
;; Author: Alexander aka 'CosmonauT' Vynnyk <cosmonaut.ok@gmail.com>
;; Version: id: start-menu,v 0.1 03 Dec 2010 cosmonaut.ok@gmail.com
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
;;; Filename: start-menu.lisp
;;; Experimantal feature - "startmenu"
;;;==================================================================
;;
;;
;;

;;; Code:
(in-package #:dswm)


(defparameter *start-menu*
  '(
    ("Graphics"
     ("Color Picker"   "gcolor2")
     ("GIMP"           "gimp")
     ("Inkscape"       "inkscape")
     ("Picasa"         "picasa")
     ("Scanner"        "xsane")
     ("OCR"            "gocr"))

    ("Internet"
     ("Filezilla" "filezilla")
     ("Firefox"   "firefox")
     ("Skype"     "skype"))

    ("Office"
     ("OpenOffice.org"  "openoffice"))

    ("Sound and Video"
     ("Europe 1"      "mplayer http://vipicecast.yacast.net/europe1")
     ("RTL"           "mplayer http://streaming.radio.rtl.fr/rtl-1-44-96")
     ("Mixer"         "xterm -rv -e alsamixer")
     ("K3b Burner"    "k3b")
     ("Eject CD-ROM"  "eject cdrom"))

    ("System Tools"
     ("Calculator"        "speedcrunch")
     ("Disk space"        "filelight")
     ("File Manager"      "nautilus")  ; thunar
     ("Nvidia X Server"   "nvidia-settings")
     ("Power Preferences" "gnome-power-preferences")
     ("Printers"          "system-config-printer")
     ("Terminal Server"   "tsclient")
         ; Turn on "Enable window manager's key bindings" for prefix key to
         ; be passed seamlessly (when *not* in full screen).
         ; Toggle between full screen and not full screen using
         ; `Ctrl-Alt-Enter'.

     ;; > In the case of Rdesktop you have to launch the app with the option
     ;; > '-K' so Stump can retain control over the key combinations that you
     ;; > input inside the remote session.

     ("VirtualBox"       "VirtualBox"))

    ("X Windows Tools"
     ("Clipboard"  "xclipboard")
     ("Fonts"      "xfontsel")
     ("Ruler"      "kruler")
     ("Events"     "xev"))
    ))

(defcommand menu () ()
  "docstring"
  (labels ((pick (options)
                 (let ((selection (dswm::select-from-menu
                                   (current-screen) options "")))
                   (cond
                    ((null selection)
                     (throw 'dswm::error "Abort."))
                    ((stringp (second selection))
                     (second selection))
                    (t
                     (pick (cdr selection)))))))
    (let ((choice (pick *start-menu*)))
      (run-shell-command choice))))

(define-key *root-map* (kbd ".") "menu")

;;; start-menu.lisp ends here
