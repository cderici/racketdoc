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
      (define scrbl-file-name (string-append (path->string p) ".scrbl"))
      ;; write an include-section into the main.scrble
      (with-output-to-file (build-path docs-dir main.scrbl)
        (lambda () (printf "\n@include-section[\"~a\"]" scrbl-file-name))
        #:exists 'append)

      (with-output-to-file (build-path docs-dir scrbl-file-name)
        (lambda () (printf (source-page-scrbl-template p)))
        #:exists 'replace))))
