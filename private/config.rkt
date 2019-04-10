#lang racket/base

(provide check-configs)

(define expected-config-keys '(source-dir       ; will be traversed to look in
                               extension        ; file with .extension
                               doctag           ; to find lines starting with doctag
                               block            ; that's contained within two blocks
                               scribble-out-dir ; to generate scribble written in scribble-out-dir
                               ))

(define (check-configs config-file-path config-ht)

  ;; check if we have all the keys we want
  (for/and ([k (in-list expected-config-keys)])
    (unless (hash-has-key? config-ht k)
      (error 'config "~a is not in the ~a" k config-file-path)))

  ;; check if the given source-dir exists
  (let ([sdir (hash-ref config-ht 'source-dir)])
    (unless (directory-exists? sdir)
      (error 'config "given source-dir in the ~a doesn't exists : ~a"
             config-file-path sdir)))

  ;; check if the given scribble-out-dir exists
  (let ([odir (hash-ref config-ht 'scribble-out-dir)])
    (unless (directory-exists? odir)
      (error 'config "given scribble-out-dir in the ~a doesn't exists : ~a"
             config-file-path odir))))
