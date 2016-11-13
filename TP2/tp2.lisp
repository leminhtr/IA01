;1.
; etat initial : R1=0 & R2=0
; etat final : R1=2 & R2=1,2,3
; Nombre total d'etat : Seau 1 : 0, 1, 2, 3 ou 4 litres (5 états) et Seau 2 : 4 états. On a donc 5*4 = 20 états possibles
	
;2
1.
(x<4, y) -> (4 y)	; remplir x
2.
(x, y>0) -> (x 0)	; vider y
3.
(x, y<3) -> (x 3)	; remplir y
4.
(x>0, y) -> (0 y)	; vider x
5.
(x>0, y<=3-x) -> (0 y+x) ; vider entierement x dans y
6.
(x>=(3-y), y<3) -> (x-(3-y) 3) ; vider et remplir y en vidant x
7.
(x<=4-y, y>0) -> (x+y 0) ; vider entierement y dans x
8.
(x<4, y>=(4-x)) -> (4 y-(4-x)) ; vider et remplir x en vidant y

;3
(defun actions (etat)
  (let ((x (car etat)) (y (cadr etat)) (acts nil))
    (when (< x 4) (push 1 acts))
    (when (> y 0) (push 2 acts)) 
    (when (< y 3) (push 3 acts)) 
    (when (> x 0) (push 4 acts)) 
    (when (and (> x 0) (<= y (- 3 x))) (push 5 acts)) 
    (when (and (>= x (- 3 y)) (< y 3)) (push 6 acts))
    (when (and (<= x (- 4 y)) (> y 0)) (push 7 acts))
    (when (and (< x 4) (>= y (- 4 x))) (push 8 acts)) 
    acts
    )
  )

(actions (list 0 0))

;4
; Ensemble des résultats possible après actions (ordre numérique question 2.)
(setq app_action '((4 y) (x 0) (x 3) (0 y) (0 (+ x y)) ((- x (- 3 y)) 3) ((+ x y) 0) (4 (- y (- 4 x)))))

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
		(dolist (j etat_tot succ)
			(if (not (member j etatsVisites :test #'equal)) (push j succ))	;Si pas déjà parcourus, ajout (Rmq! :(not member) =nil si j appartient)
		)	;return succ
	)
)

(successeurs (list 0 0) ())

;5 

(defun rech-prof(etatInitial)
  (setq etatsVisites '())
  (rech-etat etatInitial etatsVisites)
  )

(defun rech-etat(branche etatsVisites)
  (setq etat (car branche))
  (push etat etatsVisites)
  
  (if (eq (car etat) '2) (print branche)

      (dolist (i (successeurs etat etatsVisites) t)
	(rech-etat (cons i branche) etatsVisites)
	
	)

      ))



(rech-prof '((0 0)))


;6
(setq etat '(0 0))

(defun backtrack(sol father initial)
	(setq path nil) ; liste d'état parcouru bottoms-up
	(push sol path)	; on cherche les états menant à 'etat'
	(loop	; Il y a encore un père : pas encore état initial
		(if (equal sol (car initial))
     		(prog1	; Plus de père : backtrack fini
     			(print path)
				(return)
			)
			(progn
				(setq sol (cadr (assoc sol father))) ;recherche du père
   				(push sol path)	;ajout à liste des pères
     		)
		)
	)
)

(defun rech-larg (etat)
	(print "Debut programme")
	(setq x 0)
	(setq y 0)
	(setq parcours nil)	; état parcouru
	(setq fath nil)		; liste de pères parcouru et d'un etat
	(setq a_visiter (list etat))
	(loop
		(if a_visiter	;s'il existe encore des noeuds
			(progn 
				(setq ici (car a_visiter))
				(push ici parcours)
					(if (not (eq 2 (car ici))) ; ici différent de (2 y)
						(progn 
							(dolist (i (successeurs ici parcours))	;parcours les noeuds d'une largeur
								;(push i parcours) ; (setq parcours (append parcours (list i))) ;ajout élément parcourus
								(push (list i ici) fath) ; ajout (père et fils) dans liste
								(setq a_visiter (append a_visiter (list i))) ; ajout i à la fin de la liste
							)		
						)	; ici = (2 y) : solution trouvé												
						(backtrack ici fath (list etat))	
					)
					(pop a_visiter)	;enlève l'état visité
			) ;fin
			(progn
				(print "Fin du programme")
				(return)
			)
		)
	)
)

(rech-larg '(0 0))