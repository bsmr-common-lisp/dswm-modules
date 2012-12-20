(in-package :dswm-user)

(export '(*quicklisp-path*
	  *quicklisp-proxy*
	  *modules-path*))

(defvar *quicklisp-path*
  (make-pathname :directory (append
			     (pathname-directory (user-homedir-pathname))
			     (list "quicklisp"))))

(defvar *quicklisp-proxy* nil)

(defvar *modules-path*
  (make-pathname :directory (append
			     (pathname-directory (user-homedir-pathname))
			     (list "quicklisp"))))

(in-package :dswm.module.ql4ds)

(defun ql4ds-install ()
  "Install quicklisp into given directory"
  (quicklisp-quickstart:install :path dswm-user:*quicklisp-path* :proxy dswm-user:*quicklisp-proxy*))


;;;; Initial process ;;;;
  (when (not (find-package :ql))
	     (ql4ds-install))
;;;; /Initial process ;;;;
