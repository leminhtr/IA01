;1.
; etat initial : R1=0 & R2=0
; etat final : R1=2 & R2=1,2,3
; Nombre total d'etat : Seau 1 : 0, 1, 2, 3 ou 4 litres (5 états) et Seau 2 : 4 états. On a donc 5*4 = 20 états possibles
	




;2
1. (x<4, y) -> (4 y)	; remplir x
2. (x, y<3) -> (x 3)	; remplir y
3. (x>0, y) -> (0 y)	; vider x
4. (x, y>0) -> (x 0)	; vider y
5. (x<(3-y), y) -> (0 y+x) ; vider entierement x dans y
6. (x, y<(4-x)) -> (x+y 0) ; vider entierement y dans x
7. (x>=(3-y), y) -> (x-(3-y) 3) ; vider et remplir y en vidant x
8. (x, y>=(4-x)) -> (4 y-(4-x)) ; vider et remplir x en vidant y


;3 Les actions correspondent pas à la question du dessus : pour (4 0) il faudrait par exemple (1 3)
														; mais (actions '(4 0)) renvoie (3 4 6) -> (0 0) (4 0) (4 0) => il y a pas (1 3)
(defun actions (etat)
  (let ((x (car etat)) (y (cadr etat)) (acts nil))
    (when (and (> x (- 4 y)) (< x 4) (> y 0)) (push 8 acts))  ;Remplir R1 depuis R2
    (when (and (<= x (- 4 y)) (> y 0)) (push 7 acts)) ;Vider R2 dans R1
    (when (and (> y (- 3 x)) (> x 0)) (push 6 acts)) ;Remplir R2 depuis R1
    (when (and (<= x 3) (<= y (- 3 x)) (> x 0)) (push 5 acts))  ;Vider R1 dans R2
    (when (> x 0) (push 4 acts))  ;Vider R1
    (when (< y 3) (push 3 acts))  ;Remplir R2
    (when (> y 0) (push 2 acts))  ;Vider R2
    (when (< x 4) (push 1 acts))  ;Remplir R1
    acts
  )
)

;4

; Ensemble des résultats possible après actions (ordre numérique question 2.) => à évaluer.
(setq app_action '((4 y) (x 3) (0 y) (x 0) (0 (+ x y)) ((+ x y) 0) ((- x (- 3 y)) 3) (4 (- y (- 4 x)))))

; /!\ il faut définir x=0 et y=0 au début de la fonction pour utiliser successeurs.
(defun successeurs (etat etatsVisites)
	(setq x (car etat))
	(setq y (cadr etat))
	(let ((act (actions etat)) ;actions possibles
		(etat_tot nil)			; tous les etats successeurs possibles de etat
		(succ nil))
		(dolist (i act)
			(push (list (eval (car (nth (- i 1) app_action))) (eval (cadr (nth (- i 1) app_action)))) etat_tot) ;etat_tot = liste etat après 
		)																										;evaluation des actions possibles
		(print etat_tot)
		(dolist (j etat_tot succ)
			(if (not (member j etatsVisites :test #'equal)) (push j succ))	;Si pas déjà parcourus, ajout (Rmq! :(not member) =nil si j appartient)
		)	;return succ
	)
)

;5 structure pile : pop...
; /!\ il faut définir x=0 et y=0 au début de la fonction pour utiliser successeurs.

(setq etatsVisites nil)

(defun rech-prof(etat)
	(push etat etatsVisites)	;ajout etat visite (<=> chemin parcouru dans l'arbre)
	(let (act successeurs(etat etatsVisites)) 
		(dolist (i act))		;boucle sur tous les successeurs possibles
		(rech-prof((car act)))	;reherche récursive sur l'élément i
		etatsVisites			;return chemin parcouru
		)
)


;6 structure file : push...
; debug
(setq etat '(0 0))

(defun rech-larg (etat)
	(print "Debut programme")
	(setq x 0)
	(setq y 0)
	(setq parcours nil)
	(push etat parcours)
	(print "parcours")
	(print parcours)
	(print "parcours")
	(setq a_visiter (successeurs etat parcours))
	(print "a")
	(print a_visiter)
	(print "b")
	(loop
		(if a_visiter	;s'il existe encore des noeuds
			(progn 
				(dolist (i a_visiter)	;parcourir les noeuds d'une largeur
					(if (not (member i parcours :test #'equal))	; i n'est pas déjà parcourus
						(if (not (eq 2 (car i))) ; i différent de (2 y)
							(progn 
								(push i parcours) ; (setq parcours (append parcours (list i))) ;ajout élément parcourus
								(pop a_visiter)	  ; enlève i des noeuds à parcourir
								(print "parcours2")
								(print parcours)
								(print i)
								(print "parcours2")
								(setq a_visiter (append a_visiter (successeurs i parcours))) ; av= ([i+1;n], succ(i))
								(print "c")
								(print a_visiter)
								(print "d")
							)																;    = reste de largeur en cours + fils de i
							(progn				; i = (2 y)
								(setq a_visiter nil)	; stop visite parcours
								(setq sol (append i parcours))	;stockage parcours solution
							)
						)
					)
				)
			)
			(progn
				(print "Parcours termine")
				(if sol ;si solution existe
					(print sol)	;affiche sol
					nil	;sinon nil
				)
				(return)
			)

		)

	)
)

;parcours 1 etat, push ses succ, parcours le 1er etat, push ses succ, parcours le 2nd etat,...









;7
