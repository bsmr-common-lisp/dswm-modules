
(defvar *mixer-backend* nil)

(defvar *mixer-volume-types* '("pcm+" "pcm-" "pcm-toggle" "front+" "front-" "front-toggle" "master+" "master-" "master-toggle" "headphone+" "headphone-" "headphone-toggle"))


(defun volcontrol (channel amount)
  )


(define-dswm-type :volume-type (input prompt)
  (let ((*current-input-history-slot* :volume-type))
    (or (argument-pop-rest input)
	(completing-read 
	 (current-screen) prompt *mixer-volume-types*
	 :require-match t))))


(defcommand mixer-plus (channel) (())

	    )

(defcommand mixer-minus (channel) (())
	    )

(defcommand mixer-toggle (channel) (())
	    )

