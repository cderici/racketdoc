#lang racket/base

(require racket/path)

(provide make-docs)

(define (make-docs #:source-dir source-dir
                   #:extension extension
                   #:doctag doctag
                   #:block block
                   #:out-dir scribble-out)
  (define docs-dir (build-path scribble-out "docs"))

  (unless (directory-exists? docs-dir)
    (make-directory docs-dir))

  (parameterize ([current-directory source-dir])
    (for ([p (in-directory)] #:when (path-has-extension? p extension))
      (with-output-to-file (build-path docs-dir (string-append (path->string p) ".scrbl"))
        (lambda () (printf "- hey\n - hoy"))
        #:exists 'replace))))
