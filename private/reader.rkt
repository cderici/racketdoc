#lang racket/base

(require racket/string
         "config.rkt")

(provide read-configs)

(define (read-configs config-file)
  (let ([config-ht
         (with-input-from-file config-file
           (lambda ()
             (for/hash ([ln (in-lines)]
                        #:when (string-contains? ln ":"))
               (let ([k-v (string-split ln ":")])
                 (values (string->symbol (car k-v)) (cadr k-v))))))])
    (check-configs config-file config-ht)
    ;; FIXME: refactor away the hash table
    (values (hash-ref config-ht 'source-dir)
            (hash-ref config-ht 'extension)
            (hash-ref config-ht 'doctag)
            (hash-ref config-ht 'block)
            (hash-ref config-ht 'scribble-out-dir))))
