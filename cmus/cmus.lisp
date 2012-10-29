;;; -*- Mode: LISP; Syntax: Common-lisp; Package: dswm.web -*-
;;: DSWM CMus

;;; This is a list of handy functions for dealing with CMus music
;;; player in Dswm. It can send commands to cmus-remote. It uses the
;;; output from cmus-remote to  find the currently playing artist, title
;;; and album.  It also includes commands to browse wikipedia, youtube
;;; and search for lyrics via google.

;;; Copyright 2012 JD Adams
;;;
;;; Maintainer: JD Adams
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
;;; along with this software; see the file COPYING.  If not, see
;;; <http://www.gnu.org/licenses/>.
;;;
;;; DEPENDS
;;; surfaw, cmus, cmus-remote

;;; USAGE:
;;; Put it in your dswm contrib directory and then...
;;; (load-module "cmus")
;;;
;;; ...in your ~/.dswmrc, followed by some keybindings (according
;;; to your preference)
;;; 
;;;  You can send commands to cmus-remote by using the cmus-send command. 
;;;  It looks for playlists in the ~/.cmus/ directory by default.  You can
;;;  change this directory by adding: 
;;;    (setf *cmus-playlist-directory* "/path/to/your/playlists/")
;;;  to your .dswmrc.
;;; 
;;;  Here is an example taken from my .dswmrc:
;;;  
;;;  (load-module "dswm-cmus")
;;;  ;;Cmus playback controls
;;;  (define-key *root-map* (kbd "C-M-i") "cmus-info")
;;;  (define-key *root-map* (kbd "C-M-p") "cmus-send play")
;;;  (define-key *root-map* (kbd "C-M-s") "cmus-send stop")
;;;  (define-key *root-map* (kbd "C-M->") "cmus-send next")
;;;  (define-key *root-map* (kbd "C-M-<") "cmus-send prev")
;;;  (define-key *root-map* (kbd "C-M-f") "cmus-send shuffle")
;;;  (define-key *root-map* (kbd "C-M-r") "cmus-send repeat")
;;;  (define-key *root-map* (kbd "C-M-c") "cmus-send clear")
;;;  (define-key *root-map* (kbd "C-M-;") "cmus-load-playlist")
;;;  (define-key *root-map* (kbd "C-M-w") "cmus-artist-wiki")
;;;  (define-key *root-map* (kbd "C-M-v") "cmus-video")
;;;  (define-key *root-map* (kbd "C-M-l") "cmus-lyrics")


;;; Code:
(defpackage :dswm.module.cmus
  (:use :cl :dswm :cl-ppcre)
  (:export *cmus-playlist-directory*
	   *cmus-use-default-controls-p*))

(in-package :dswm.module.cmus)

(defun strings-only (list)
  (cond ((null (car list)) nil)
	((stringp (car list))
	 (cons (car list) (strings-only (cdr list))))
	(t (strings-only (cdr list)))))

(defvar *cmus-commands* '( :PLAY "play" :PAUSE "pause" :STOP "stop" 
				 :NEXT "next" :PREV "prev" :FILE "file" :REPEAT "repeat" 
				 :SHUFFLE "shuffle" :VOLUME "volume" :CLEAR "clear" :RAW "raw")
  "CMus commands list")

(defvar *cmus-playlist-directory* "~/.cmus/"
  "CMus directory with playlist")

(defvar *cmus-use-default-controls-p* nil
  "To use or not default cmus module keymap")
 
(define-dswm-type :cmus (input prompt)
  (or (argument-pop input)
      (completing-read (current-screen)
                       prompt
		       (strings-only *cmus-commands*))))

(defun query-cmus (tag)
   "Queries active cmus play session for matching tag"
   (let ((cmus-command "cmus-remote -Q | grep 'tag ") cmus-result)
     (setf cmus-result (run-shell-command (concat cmus-command tag " '") t))
     (string-trim '(#\Newline) (string-left-trim (concat "tag " tag) cmus-result))))

(defun cmus-control (command)
   "sends a command to cmus via cmus-remote"
   (run-shell-command (concat "cmus-remote " command)))

(defcommand cmus-send (command) ((:cmus "Enter Command: "))
  "Send control commands to cmus."
  (when (member command (strings-only *cmus-commands*) :test 'equal)
    (cmus-control (concat "--" command))))

(defcommand cmus-video () ()
   "Find videos on youtube matching currently playing song in cmus"
   (run-shell-command (concat "surfraw youtube " 
                            (query-cmus "artist") 
                            (query-cmus "title"))))

(defcommand cmus-artist-video () ()
   "Find videos on youtube matching current artist in cmus"
   (run-shell-command (concat "surfraw youtube " 
                            (query-cmus "artist"))))

(defcommand cmus-artist-wiki () ()
   "Search wikipedia for current artist in cmus"
    (run-shell-command (concat "surfraw wikipedia " 
                            (query-cmus "artist"))))

(defcommand cmus-lyrics () ()
   "Search wikipedia for current artist in cmus"
    (run-shell-command (concat "surfraw google  " 
                            (query-cmus "artist") 
                            " " 
                            (query-cmus "title")
                            " lyrics")))

(defcommand cmus-load-playlist (playlist) ((:string "Enter Filename: "))
   "Loads and plays a  playlist from the *cmus-playlist-directory*"
   (let ((full-path (concat *cmus-playlist-directory* playlist)))
     (cmus-control "--clear")
     (cmus-control (concat "-p " full-path))
     ;; next ensures that the currently playing cmus track is cleared.
     (cmus-control "--next")))

(defcommand cmus-search-library (tag) ((:string "Enter Search: "))
  "search library view for tag. "
 (cmus-control "--raw 'view tree'")
 (cmus-control (concat "--raw ' /" tag "'")))

(defcommand cmus-play-album (tag) ((:string "Enter Search: "))
  "Search and play album matching tag"
  (cmus-control "--raw 'view tree'")
  (cmus-control (concat "--raw ' /" tag "'"))
  (cmus-control "--clear")
  (cmus-control "--raw win-add-p")
  (cmus-control "--next")
  (cmus-control "--raw 'view playlist'")
  (cmus-control "--play"))

(defcommand cmus-play-song (tag) ((:string "Enter Search: "))
  "Search and play song matching tag"
  (cmus-control "--raw 'view tree'")
  (cmus-control (concat "--raw ' /" tag "'"))
  (cmus-control "--clear")
  (cmus-control "--raw win-next")
  (cmus-control "--raw win-add-p")
  (cmus-control "--next")
  (cmus-control "--raw 'view playlist'")
  (cmus-control "--play"))

(defcommand cmus-info () ()
   "Print cmus info to screen"
   (let ((title  (query-cmus "title")) (artist  (query-cmus "artist")) (album (query-cmus "album"))) 
        (echo-string (current-screen) (concat "Now Playing: " '(#\NewLine) artist ": " title ": " album))))
