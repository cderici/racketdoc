#lang racket/base

(provide generate-makefile)

(define (generate-makefile dir)
  (with-output-to-file (build-path dir "Makefile")
    (lambda ()
      (define makefile-text
        (format "doc:
\tracket -I scheme/init -l scribble/run.rkt manual.scrbl

clean:
\trm -f *.html
\trm -f *.css
\trm -f *.js
\trm -f *~~ "))
      (printf "~a" makefile-text))
    #:exists 'replace))
