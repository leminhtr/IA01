;Exercice 1

;Q.1 :

(cadddr '(A B C D)) ;D
(cadr (cadr (car '((a (b c)) e)))) ; C
(car (car (car '(((DIEU) ENCORE) UNE)))) ; DIEU
(cadr (car '(((DIEU) ENCORE) UNE))) ; ENCORE


;Q.3

(cadr (cdr (cdr (cdr '(DO RE MI FA SOL LA SI))))) ; SOL
(CONS (cadr '((a b)(c d))) (cddr '(a (b (c))))) ; ((c d)) : construction de la liste avec l'élément liste (c d)
(cons (cons 'hello nil) '(how are you)) ; ((hello) how are you)
(cons 'je (cons 'je (cons 'je (cons 'balbute nil)))) ; (je (je (je (balbute))))
(cadr (cons 'tiens (cons '(c est simple) ()))) ; (c est simple)

;Q.4

(defun double (L)
(if (listp L)
(if (< 0 (length L))
(append (list (car L) (car L)) (double(cdr L)))
(car L)
)
(nil)
)
)

;pb : si élément non dans L -> renvoie longueur liste..
(defun rang (X L)
(if (endp L) 0
(if (equal X (car L)) 1 (+ 1 (rang X (cdr L))))
))

;brouillon
(defun ran (X L)
(cond
((equal X (car L)) 1)
((endp L) 0)
(T (let ((R (ran X (cdr L))))))
((= R 0) 0)
((+ 1 R))
)
)

;brouillon
(defun occ (sym nested-list)
  (cond
    ((consp nested-list)
     (+ (occ sym (car nested-list)) (occ sym (cdr nested-list)))
     )
    ((eq sym nested-list) 1)
    (t 0)
   )
)