(defpackage :dswm.module.ql4ds
  (:use :cl :dswm))

;;;;
(cl:in-package #:cl-user)
(cl:defpackage #:qlqs-user
  (:use #:cl #:dswm))
(cl:in-package #:qlqs-user)

(defpackage #:qlqs-impl
  (:use #:cl #:dswm)
  (:export #:*implementation*)
  (:export #:definterface
           #:defimplementation)
  (:export #:lisp
           #:abcl
           #:allegro
           #:ccl
           #:clisp
           #:cmucl
           #:cormanlisp
           #:ecl
           #:gcl
           #:lispworks
	   #:mkcl
           #:scl
           #:sbcl))

(defpackage #:qlqs-impl-util
  (:use #:cl #:qlqs-impl #:dswm)
  (:export #:call-with-quiet-compilation))

(defpackage #:qlqs-network
  (:use #:cl #:qlqs-impl #:dswm)
  (:export #:open-connection
           #:write-octets
           #:read-octets
           #:close-connection
           #:with-connection))

(defpackage #:qlqs-progress
  (:use #:cl #:dswm)
  (:export #:make-progress-bar
           #:start-display
           #:update-progress
           #:finish-display))

(defpackage #:qlqs-http
  (:use #:cl #:qlqs-network #:qlqs-progress #:dswm)
  (:export #:fetch
           #:*proxy-url*
           #:*maximum-redirects*
           #:*default-url-defaults*))

(defpackage #:qlqs-minitar
  (:use #:cl #:dswm)
  (:export #:tarball-contents
           #:unpack-tarball))

(defpackage #:quicklisp-quickstart
  (:use #:cl #:qlqs-impl #:qlqs-impl-util #:qlqs-http #:qlqs-minitar #:dswm)
  (:export #:install
           #:help
	   #:*home*
           #:*proxy-url*
           #:*asdf-url*
           #:*quicklisp-tar-url*
           #:*setup-url*
           #:*help-message*
           #:*after-load-message*
           #:*after-initial-setup-message*))
