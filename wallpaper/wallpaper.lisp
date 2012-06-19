(defstruct wallpaper-maker
  name
  path
  (default-key nil)
  (fullscreen-key nil) ;; Key for fullscreen image with resizing, if needed
  (center-key nil) ;; Key for center image
  (tile-key nil) ;; Key for tiiling image
  (fullscreen-noresize-key nil) ;; Key for fullscreen image, but without resizing
  (fixed-size-key nil))

(defvar *default-wallpaper-maker* "imagemagick")

(defvar *wallpaper-makers-list* nil)


(defcommand set-wallpaper (path) (:string "Enter path to wallpaper: ")
  (let ((

;; Standard wallpaper-makers
(add-to-list
 *wallpaper-makers-list*
 (make-wallpaper-maker
  :name "imagemagick"
  :path (make-pathname :directory '(:absolute "usr" "bin")
		       :name "display")
  :default-key "-window root"
  :fullscreen-key ""
  :center-key
  :tile-key
  :fixed-size-key))

(add-to-list
 *wallpaper-makers-list*
 (make-wallpaper-maker
  :name "feh"
  :path (make-pathname :directory '(:absolute "usr" "bin")
		       :name "feh")
  :fullscreen-key "--bg-scale"
  :center-key "--bg-center"
  :tile-key "--bg-tile"
  :fullscreen-noresize-key "-bg-max"))

