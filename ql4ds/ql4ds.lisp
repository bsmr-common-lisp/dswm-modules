(defpackage :dswm.module.ql4ds
  (:use :cl :dswm))

(in-package :dswm.module.ql4ds)

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

