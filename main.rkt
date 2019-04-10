#lang racket/base

(require racket/runtime-path
         racket/cmdline
         "private/reader.rkt")

(define-runtime-module-path doc-gen "private/doc-gen.rkt")      
                

(define (racketdoc dir config-file)

  (define config (read-configs config-file))
  (printf "config : ~a\n" config)
  ((dynamic-require doc-gen 'make-docs)
   #:dir dir
   #:config config))

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
