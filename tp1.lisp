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

(defun double (L)
(if (listp L)
	(if (< 0 (length L)) ; si not fin liste
		(append
		(list (car L) (car L)) (double(cdr L))) ; doubler élément puis réitérer avec reste liste
	)
	L
)

(defun double (L)
(if (listp L)			 ; if liste
	(if (< 0 (length L)) 	; if not fin liste
		(append				 	; then créer liste en ajoutant double (1 par 1)
		(if (listp (car L))  		; if sous-liste
			(list (double (car L))) 	;then doubler sous-liste
			(list (car L) (car L)) 	;else doubler
		))
		(double(cdr L))			; else élément suivant
	)
	L 					 ; else return liste		
)
)


(defun rang (X L)
(cond
	((not (member X L)) 0)  ; X n'appartient pas à L =>0
							; si fin de liste alors X=nil donc True.
	((equal X (car L)) 1)	; si trouvé alors return 1
	(t (+ 1 (rang X (cdr L))))	; sinon appel rang sur élément suivant
)
)

(defun tete (N L)
(if (<= N (length L)); N<= nb. élément de L
(if (> N 0 ); Nème élément pas atteint
(cons (car L) (tete (- N 1) (cdr L))); then construction tete liste
); avec i ème élément
L); sinon return L
)



(defun elim(L)
(cond
((and L (listp L)) ; L différent de nil
    (setq a (car L))         ; a=ième élément
    (setq new_list (list a)) ; new_list=liste sans doublon
    (dolist (i (cdr L))     ; boucle sur les [i+1;N] éléments
        (unless (eq a i)        ; i est doublon de a ??
        (setq new_list (append new_list (list i)))) ; si non doublon alors ajout i à new_list
    )
    (cons (car new_list) (elim (cdr new_list))) ; new_list est une liste sans doublon par rapport à l'élément a.
)                                               ; construction de new_list avec le reste de la liste => récursion avec l'élément i+1.
(t L)   ;liste vide alors return la liste.
))



(defun monEqual (X Y)
(if (and (listp X) (listp Y)) ; if X ET Y list
(equal X Y) 	; then appliquer equal
(eq X Y)		; else appliquer eq
)
)


;Ex.2
(defun list-triple (LL)
(mapcar #'(lambda (j) (* j 3)) LL)
)


;Ex.3
; Définition d'une a-list pour tester les fonctions
(setq Test '((Moi 21) (MinhTri 21) (Bebe 1)))

(defun my-assoc (cle a-list) ; Retourne la valeur d'une clé dans une liste d'associations
  (if (eq (caar a-list) cle)
      (print (car a-list))
    (if (not (null a-list)) (my-assoc cle (cdr a-list)))
    )
  )

(my-assoc 'Bebe Test)

(defun cles (a-list) ; Renvoi les clés d'une a-list
  (if (not (null a-list))
  (append (list (caar a-list)) (cles (cdr a-list)))
  
  )
  )

(cles Test)

(defun creation (listeCles listeValeurs) ;Retourne une a-liste à partir d'une liste de clés et de valeurs
  (if (and (not (null listeCles)) (not (null listeValeurs)))
   (append (list (list (car listeCles) (car listeValeurs))) (creation (cdr listeCles) (cdr listeValeurs)))
  
   )
)

(creation '(A B C) '(1 2 3 4))




;Ex.4
(setq BaseTest '((" Le Dernier Jour d'un condamné " Hugo 1829 50000)
(" Notre-Dame de Paris " Hugo 1831 3000000)
(" Les Misérables " Hugo 1862 2000000)
("Le Horla " Maupassant 1887 2000000)(" Contes de la bécasse " Maupassant 1883 500000)
("Germinal " Zola 1885 3000000)
))

(defun auteur (ouvrage) ; Retourne l'auteur de l'ouvrage passé en argument
  (cadr ouvrage)
  )

(auteur '("Notre-Dame de Paris" Hugo 1831 3000000)) 

(defun titre (ouvrage) ; Retourne le titre de l'ouvrage passé en argument
  (car ouvrage)
  )

(titre '("Notre-Dame de Paris" Hugo 1831 3000000))

(defun annee (ouvrage) ; Retourne l'année de l'ouvrage passé en argument
  (caddr  ouvrage)
  )
  
(annee '(" Notre-Dame de Paris " Hugo 1831 3000000))

(defun nombre (ouvrage) ; Retourne le nombre d'exemplaire de l'ouvrage passé en argument
  (cadddr  ouvrage)
  )
  
(nombre '(" Notre-Dame de Paris " Hugo 1831 3000000))

(defun FB1 (database)
  (dolist (x database) 
    (print  x))
)
(FB1 BaseTest)


(defun FB2 (database) ; Affiche les ouvrages de l'auteur Hugo
	(dolist (x database)
		(if (equal (auteur x) 'Hugo) (print x)))
	)
(FB2 BaseTest)

(defun FB3(database auteur) ; Retourne la liste des titres d'ouvrages dont l'auteur est auteur
	(let (s '())
	(dolist (x database)
   		(if (equal (auteur x) auteur) (setq s (append s (list (titre x))))))
  	s
	)
)

(FB3 BaseTest 'Hugo)


(defun FB4 (database annee) ; Retourne le premier ouvrage paru en année ann ou nil
	(dolist (x database)
		(if (equal (annee x) annee) (return x) nil))
)
(FB4 BaseTest '1831)


(defun FB5 (database) ; Retourne la liste des ouvrages dont le nb d'exemplaires vendus dépasse 1000000 ou nil
	(let (( nb '()))
	(dolist (x BaseTest)
		(if (> (nombre x) 1000000) (setq nb (append nb (list (titre x))))))
	      nb
	      )
)
(FB5 BaseTest)



(defun FB6 (database aut) ; Calcule et retourne la moyenne du nombre d'exemplaires vendus de l'auteur aut
  (let ((compt 0) (nb 0))
	(dolist (x database)
		(if (eq aut (auteur x)) (progn (setq compt (+ compt 1)) (setq nb (+ nb (nombre x)))))
		)
	(/ nb compt)
	))

(FB6 BaseTest 'Hugo)
