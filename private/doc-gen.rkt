#lang racket/base

(require racket/path)

(provide make-docs)

(define (make-docs #:source-dir source-dir
                   #:extension extension
                   #:doctag doctag
                   #:block block
                   #:out-dir scribble-out)
  (parameterize ([current-directory source-dir])
    (for ([p (in-directory)] #:when (path-has-extension? p extension))
      (printf "- ~a\n" p))))
