(defpackage #:ql-setup
  (:use #:cl)
  (:export #:*quicklisp-home*
           #:qmerge
           #:qenough))

(in-package #:ql-setup)

;;;;;;;;;;;; small dswm lib ;;;;;;;;;;;;;;;;;;
(defvar *data-dir* nil
  "Set default data directory")

(defun concat (&rest strings)
  "Concatenates strings, like the Unix command 'cat'.
A short for (concatenate 'string foo bar)."
  (apply 'concatenate 'string strings))

(defun data-dir (&optional subdir)
  (let ((directory
	 (if (not (null *data-dir*))
	     (make-pathname :directory (concat *data-dir* "/" subdir))
	   (make-pathname
	    :directory (append
			(pathname-directory (user-homedir-pathname))
			(list (concat ".dswm.d"	"/" subdir)))))))
    (when (ensure-directories-exist directory)
      directory)))

(defun data-dir-file (name &optional type subdir)
  "Return a pathname inside dswm's data dir with the specified name and type"
  (if (not (null type))
      (make-pathname :name name :type type :defaults (data-dir subdir))
    (make-pathname :name name :defaults (data-dir subdir))))
;;;;;;;;;;;; /small dswm lib ;;;;;;;;;;;;;;;;;

(defun quicklisp-data-dir ()
  "Return a pathname inside dswm's module data dir with the specified name and type"
  (let ((dir-path (concat (princ-to-string (data-dir)) "/save.d/ql4ds/")))
    (make-pathname :defaults dir-path)))

(defvar *quicklisp-home* (quicklisp-data-dir))

(defun qmerge (pathname)
  "Return PATHNAME merged with the base Quicklisp directory."
  (merge-pathnames pathname *quicklisp-home*))

(defun qenough (pathname)
  (enough-namestring pathname *quicklisp-home*))

;;; ASDF is a hard requirement of quicklisp. Make sure it's either
;;; already loaded or load it from quicklisp's bundled version.

(defvar *required-asdf-version* "2.011")

;;; Put ASDF's fasls in a separate directory

(defun implementation-signature ()
  "Return a string suitable for discriminating different
implementations, or similar implementations with possibly-incompatible
FASLs."
  (let ((*print-pretty* nil))
    (format nil "lisp-implementation-type: ~A~%~
                 lisp-implementation-version: ~A~%~
                 machine-type: ~A~%~
                 machine-version: ~A~%"
            (lisp-implementation-type)
            (lisp-implementation-version)
            (machine-type)
            (machine-version))))

(defun dumb-string-hash (string)
  "Produce a six-character hash of STRING."
  (let ((hash #xD13CCD13))
    (loop for char across string
          for value = (char-code char)
          do
          (setf hash (logand #xFFFFFFFF
                             (logxor (ash hash 5)
                                     (ash hash -27)
                                     value))))
    (subseq (format nil "~(~36,6,'0R~)" (mod hash 88888901))
            0 6)))

(defun asdf-fasl-pathname ()
  "Return a pathname suitable for storing the ASDF FASL, separated
from ASDF FASLs from incompatible implementations. Also, save a file
in the directory with the implementation signature, if it doesn't
already exist."
  (let* ((implementation-signature (implementation-signature))
         (original-fasl (compile-file-pathname (qmerge "asdf.lisp")))
         (fasl
          (qmerge (make-pathname
                   :defaults original-fasl
                   :directory
                   (list :relative
                         "cache"
                         "asdf-fasls"
                         (dumb-string-hash implementation-signature)))))
         (signature-file (merge-pathnames "signature.txt" fasl)))
    (ensure-directories-exist fasl)
    (unless (probe-file signature-file)
      (with-open-file (stream signature-file :direction :output)
        (write-string implementation-signature stream)))
    fasl))

(defun ensure-asdf-loaded ()
  "Try several methods to make sure that a sufficiently-new ASDF is
loaded: first try (require 'asdf), then loading the ASDF FASL, then
compiling asdf.lisp to a FASL and then loading it."
  (let* ((source (qmerge "asdf.lisp"))
         (fasl (asdf-fasl-pathname)))
    (ensure-directories-exist fasl)
    (labels ((asdf-symbol (name)
               (let ((asdf-package (find-package '#:asdf)))
                 (when asdf-package
                   (find-symbol (string name) asdf-package))))
             (version-satisfies (version)
               (let ((vs-fun (asdf-symbol '#:version-satisfies))
                     (vfun (asdf-symbol '#:asdf-version)))
                 (when (and vs-fun vfun
                            (fboundp vs-fun)
                            (fboundp vfun))
                   (funcall vs-fun (funcall vfun) version)))))
      (block nil
        (macrolet ((try (&body asdf-loading-forms)
                     `(progn
                        (handler-bind ((warning #'muffle-warning))
                          (ignore-errors
                            ,@asdf-loading-forms))
                        (when (version-satisfies *required-asdf-version*)
                          (return t)))))
          (try)
          (try (require 'asdf))
          (try (load fasl :verbose nil))
          (try (load (compile-file source :verbose nil :output-file fasl)))
          (error "Could not load ASDF ~S or newer" *required-asdf-version*))))))

(ensure-asdf-loaded)

;;;
;;; Quicklisp sometimes must upgrade ASDF. Ugrading ASDF will blow
;;; away existing ASDF methods, so e.g. FASL recompilation :around
;;; methods would be lost. This config file will make it possible to
;;; ensure ASDF can be configured before loading Quicklisp itself via
;;; ASDF. Thanks to Nikodemus Siivola for pointing out this issue.
;;;

(let ((asdf-init (probe-file (qmerge "asdf-config/init.lisp"))))
  (when asdf-init
    (with-simple-restart (skip "Skip loading ~S" asdf-init)
      (load asdf-init :verbose nil :print nil))))

(push (qmerge "quicklisp/") asdf:*central-registry*) ;; change to module dir

;; (let ((*compile-print* nil)
;;       (*compile-verbose* nil)
;;       (*load-verbose* nil)
;;       (*load-print* nil))
;;   (asdf:oos 'asdf:load-op "quicklisp" :verbose nil))

;; (quicklisp:setup)
