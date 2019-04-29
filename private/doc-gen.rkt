#lang racket/base

(require racket/path "boilerplate.rkt")

(provide make-docs)

(define (make-docs #:source-dir source-dir
                   #:extension extension
                   #:doctag doctag
                   #:block block
                   #:out-dir scribble-out
                   #:main-scrbl-file main.scrbl
                   #:title title)
  (define docs-dir (build-path scribble-out "docs"))

  (generate-makefile docs-dir main.scrbl)

  (generate-main-scrbl docs-dir main.scrbl title)

  (unless (directory-exists? docs-dir)
    (make-directory docs-dir))

  (parameterize ([current-directory source-dir])
    (for ([p (in-directory)] #:when (path-has-extension? p extension))
      (with-output-to-file (build-path docs-dir (string-append (path->string p) ".scrbl"))
        (lambda () (printf "- hey\n - hoy"))
        #:exists 'replace))))
