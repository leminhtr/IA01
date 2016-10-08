;Exercice 1

;Q.1 :

(cadddr '(A B C D)) ;D
(cadr (cadr (car '((a (b c)) e)))) ; C
(car (car (car '(((DIEU) ENCORE) UNE)))) ; DIEU
(cadr (car '(((DIEU) ENCORE) UNE))) ; ENCORE


;Q.3

(cadr (cdr (cdr (cdr '(DO RE MI FA SOL LA SI))))) ; SOL
(CONS (cadr '((a b)(c d))) (cddr '(a (b (c))))) ; ((c d)) : construction de la liste avec l'élément liste (c d)
							;cddr de (a (b (c)))=NIL
(cons (cons 'hello nil) '(how are you)) ; ((hello) how are you)
	  ;cons 'hello nil=(hello)
(cons 'je (cons 'je (cons 'je (cons 'balbute nil)))) ; (je (je (je (balbute)))) 
							  ;cons 'balbute nil=(balbute)
(cadr (cons 'tiens (cons '(c est simple) ()))) ; cadr de (tiens (c est simple))=(c est simple)

;Q.4
;Est-ce que : (a (b c) d) -> (a a (b b c c) (b b c c) d d) ou (a a (b c) (b c) d d)??

(defun double (L)
(if (listp L)
(if (< 0 (length L))
(append (list (car L) (car L)) (double(cdr L)))
;(car L)
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







;Ex.2
(defun list-triple (LL)
(mapcar #'(lambda (j) (* j 3)) LL)
)


					;Ex.3
(defun cles (a-list) ; Renvoi les clés d'une a-list
  (if (not (null a-list))
  (append (list (caar a-list)) (cles (cdr a-list)))
  
  )
  )

(setq Test '((Moi 21) (MinhTri 21) (Bebe 1)))

(cles Test)

(defun creation (listeCles listeValeurs)
  (if (not (null listeCles))
   (append (list (list (car listeCles) (car listeValeurs))) (creation (cdr listeCles) (cdr listeValeurs)))
  
   )
)

(creation '(A B C) '(1 2 3))

(cdr Test)

(defun my-assoc (cle a-list)
  (if (eq (caar a-list) cle)
      (print (car a-list))
    (my-assoc cle (cdr a-list))
    )
  )

(my-assoc 'Bebe Test)

					;Ex.4
(setq BaseTest '((" Le Dernier Jour d'un condamné " Hugo 1829 50000)
(" Notre-Dame de Paris " Hugo 1831 3000000)
(" Les Misérables " Hugo 1862 2000000)
("Le Horla " Maupassant 1887 2000000)(" Contes de la bécasse " Maupassant 1883 500000)
("Germinal " Zola 1885 3000000)
))

(defun auteur (ouvrage)
  (cadr ouvrage)
  )

(auteur '("Notre-Dame de Paris" Hugo 1831 3000000))

(defun titre (ouvrage)
  (car ouvrage)
  )

(titre '("Notre-Dame de Paris" Hugo 1831 3000000))

(defun annee (ouvrage)
  (caddr  ouvrage)
  )
  
(annee '(" Notre-Dame de Paris " Hugo 1831 3000000))

(defun nombre (ouvrage)
  (cadddr  ouvrage)
  )
  
(nombre '(" Notre-Dame de Paris " Hugo 1831 3000000))

(defun FB1 (database)
  database
  )

(FB1 BaseTest)


(defun FB2 (database)
	(dolist (x database)
		(if (equal (auteur x) 'Hugo) (print x)))
	)
(FB2 BaseTest)

(defun FB3(database auteur)
	(setq s '())
	(dolist (x database)
   		(if (equal (auteur x) auteur) (setq s (append s (list (titre x))))))
  	s
)

(FB3 BaseTest 'Hugo)

(defun FB4 (database ann)
	(dolist (x database)
		(if (equal (annee x) ann) (progn (print x) (return))))
	)
(FB4 BaseTest '1831)

(defun FB5 (database)
	(dolist (x database)
		(if (> (nombre x) 1000000) (print x)))
	)
(FB5 BaseTest)


(defun FB6 (database aut)
  (setq compt 0)
  (setq nb 0)
	(dolist (x database)
		(if (eq aut (auteur x)) (progn (setq compt (+ compt 1)) (setq nb (+ nb (nombre x)))))
		)
	(/ nb compt)
	)

(FB6 BaseTest 'Hugo)

