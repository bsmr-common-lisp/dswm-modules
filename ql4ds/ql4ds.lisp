(defpackage :dswm.module.ql4ds
  (:use :cl :dswm))

(in-package :dswm.module.ql4ds)

;; (defvar *quicklisp-path* (make-pathname :directory (append (pathname-directory (user-homedir-pathname)) (list "quicklisp"))))
;; (defvar *quicklisp-proxy* nil)
;; (defvar *modules-path* (make-pathname :directory (append (pathname-directory (user-homedir-pathname)) (list "quicklisp"))))

;; (defun modules-paths-list ()
;;   "Return a list of the real paths of available modules"
;;   (let ((mod-list nil)
;; 	(mod-path-list))
;;     (dolist (module-path asdf:*central-registry*)
;;       (dolist (subpath (list-directory module-path))
;; 	(let ((local-name (car (last (pathname-directory subpath)))))
;; 	  (when (and (not (member local-name mod-list :test 'equal))
;; 		     (file-exists-p (make-pathname
;; 				     :defaults subpath
;; 				     :name local-name
;; 				     :type "asd"))
;; 		     (directory-pathname-p subpath))
;; 	  (and 
;; 	   (push local-name mod-list)
;; 	   (push subpath mod-path-list))))))
;;   mod-path-list))


;;   ;; is file symlink
;; (defun add-modules-to-ql ()
;;   "Add local modules to quicklisp local-projects"
;;   (dolist (path (modules-paths-list))
;;     (let* ((ql-local-name (car (last (pathname-directory path))))
;; 	   (ql-local-projects-dir
;; 	    (make-pathname :directory (append
;; 				       (pathname-directory *quicklisp-path*)
;; 				       (list "local-projects")) :name ql-local-name)))
;;       (when (not (ignore-errors
;; 		   (sb-posix:s-islnk
;; 		    (sb-posix:stat-mode
;; 		     (sb-posix:lstat ql-local-projects-dir)))))
;; 	(sb-posix:symlink path ql-local-projects-dir)))))

;; (defun quicklisp-system-p (term)
;;   "Like ql:apropos, but useful for programming"
;;   (let ((print-systems nil))
;;     (dolist (system (ql-dist:provided-systems t))
;;       (when (or (search term (ql-dist:name system))
;; 		(search term (ql-dist:name (ql-dist:release system))))
;; 	(push system print-systems)))
;;     print-systems))

;; (defun update-repos ()
;;   "Update repositories ql4ds"
;;   (when (and (find-package :ql) (not (quicklisp-system-p "ql4ds")))
;;     ;; update repository files
;;     ))

;; (defun install (dir)
;;   "Install quicklisp into given directory"
;;   (quicklisp-quickstart:install :path *quicklisp-path* :proxy *quicklisp-proxy*))


;; ;;;; Initial process ;;;;
;; (defun init ()
;;   "Initialize module"
;;   (if (find-package :ql)
;;       (when (not (not (quicklisp-system-p "ql4ds")))
;; 	(update-repos))
;;     (install)))

;; (init)
;; ;;;; /Initial process ;;;;

(defun ql-modules-list ()
  "Build list of all modules: local and remote"
  ;;...
  )

(define-dswm-type :ql-module (input prompt)
  (or (argument-pop-rest input)
      (completing-read (current-screen) prompt (ql-modules-list) :require-match t)))

(defun ql-fetch-module (name)
  "Just fetch module. Don't load it"
  )

(defun ql-refetch-module (name)
  "Refetch module. Updates it, if needed"
  )

(defcommand ql-update () ()
  "Update quicklisp repository files"
  )

(defcommand ql-upgrade () () ;; TODO: update modules.txt too
  "Upgrade all quicklisp libraries and modules etc"
  (and
   (ql:update-all-dists)
   (ql:update-client)
   (message "Done")))

(defcommand ql-remove-module (name unlink-p)
  ((:module "Input module name: ")
   (:y-or-n "Remove module files from disk? "))
  "Remove module from ql4ds database and, if needed, from disk"
  )

(defcommand ql-load-module (name) ((:module "Input module name: "))
  "Loads module from disk, if it exists locally, or try to download it before loading"
  )

(defcommand ql-reload-module (name) ((:module "Input module name: "))
  "Reload module"
  )

(defcommand ql-module-info (name) ((:module "Input module name: "))
  "View module info"
  )

(defcommand ql-modules () ()
  "List of local and remote modules"
  )

