(in-package :dswm.module.cmus)

(defvar *cmus-map* nil)

(defmacro use-controls-p ()
  (when (not (null *cmus-use-default-controls-p*))
    `(progn
       (fill-keymap *cmus-map*
	    (kbd "i") "cmus-info"
	    (kbd "p") "cmus-send play"
	    (kbd "s") "cmus-send stop"
	    (kbd ">") "cmus-send next"
	    (kbd "<") "cmus-send prev"
	    (kbd "f") "cmus-send shuffle"
	    (kbd "r") "cmus-send repeat"
	    (kbd "c") "cmus-send clear"
	    (kbd ";") "cmus-load-playlist"
	    (kbd "w") "cmus-artist-wiki"
	    (kbd "v") "cmus-video"
	    (kbd "l") "cmus-lyrics")
       
       (define-key *root-map* (kbd "M-c") *cmus-map*))))

(use-controls-p)
