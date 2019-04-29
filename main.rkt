#lang racket/base

(require racket/runtime-path
         racket/cmdline
         "private/reader.rkt")

(define-runtime-module-path doc-gen "private/doc-gen.rkt")


(define (racketdoc dir config-file)

  (define-values (source-dir extension doctag block scribble-out main-scrbl title)
    (read-configs config-file))

  ((dynamic-require doc-gen 'make-docs)
   #:source-dir source-dir
   #:extension extension
   #:doctag doctag
   #:block block
   #:out-dir scribble-out
   #:main-scrbl-file main-scrbl
   #:title title))

(module+ main

  (define working-dir #f)
  (command-line
   #:args (directory-path)

   (unless (directory-exists? directory-path)
     (error 'racketdoc "No such directory : ~a" directory-path))

   (set! working-dir directory-path)

   (define config-file-path (build-path directory-path "racketdoc.config"))

   (unless (file-exists? config-file-path)
     (error 'racketdoc "No racketdoc.config found in ~a" directory-path))

   (racketdoc directory-path config-file-path)))
