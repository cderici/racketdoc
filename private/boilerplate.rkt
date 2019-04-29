#lang racket/base

(provide generate-makefile
         generate-main-scrbl
         source-page-scrbl-template)

(define (generate-makefile dir main.scrbl)
  (with-output-to-file (build-path dir "Makefile")
    (lambda ()
      (define makefile-text
        (format "doc:
\tracket -I scheme/init -l scribble/run.rkt ~a

clean:
\trm -f *.html
\trm -f *.css
\trm -f *.js
\trm -f *~~ " main.scrbl))
      (printf "~a" makefile-text))
    #:exists 'replace))

(define (generate-main-scrbl dir main.scrbl title)
  (with-output-to-file (build-path dir main.scrbl)
    (lambda ()
      (define main-content
        (format "#lang scribble/manual

@title{~a}

Welcome to ~a's documentation

" title title))
      (printf "~a" main-content))
    #:exists 'replace))


(define (source-page-scrbl-template title)
  (format "#lang scribble/manual

@title{~a}

Hey



" title))
