(defpackage :dswm.module.ql4ds
  (:use :cl :dswm :sb-posix))

(in-package :dswm.module.ql4ds)

(defvar *quicklisp-path* (make-pathname :directory (pathname-directory (user-homedir-pathname)) (list "quicklisp")))
(defvar *modules-path* (make-pathname :directory (pathname-directory (user-homedir-pathname)) (list "quicklisp")))


(defun modules-paths-list ()
  "Return a list of the real paths of available modules"
  (let ((mod-list nil)
	(mod-path-list))
    (dolist (module-path asdf:*central-registry*)
      (dolist (subpath (list-directory module-path))
	(let ((local-name (car (last (pathname-directory subpath)))))
	  (when (and (not (member local-name mod-list :test 'equal))
		     (file-exists-p (make-pathname
				     :defaults subpath
				     :name local-name
				     :type "asd"))
		     (directory-pathname-p subpath))
	  (and 
	   (push local-name mod-list)
	   (push subpath mod-path-list))))))
  mod-path-list))


  ;; is file symlink
(defun add-modules-to-ql ()
  "Add local modules to quicklisp local-projects"
  (dolist (path (modules-paths-list))
    (let* ((ql-local-name (car (last (pathname-directory path))))
	   (ql-local-projects-dir
	    (make-pathname :directory (append
				       (pathname-directory *quicklisp-path*)
				       (list "local-projects")) :name ql-local-name)))
      (when (not (ignore-errors
		   (sb-posix:s-islnk
		    (sb-posix:stat-mode
		     (sb-posix:lstat ql-local-projects-dir)))))
	(sb-posix:symlink path ql-local-projects-dir)))))
