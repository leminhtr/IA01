; Création des variables globales
(setq *BR* NIL)
(setq *BF* NIL)
(setq *QuestionOK* T)

; Chargement de la base de fait et des fonctions.
(load "BR.lisp")
;(load "func.lisp")


(defun askIngredient ()
  ; On constitue la base de fait
  (askForLetter)
  ; On demande si l'utilsateur veut une entrée, un plat ou un dessert
  (entreePlatDessert)
)

(defun main ()

  	(print "Bienvenue sur CTR (Choisi ta recette !)")
	(print "Lancement de la fabrication de BF")
	
	; On demande à l'utilisateur de rentrer ses ingrédients
	(askIngredient)

	; Mise à 0 des variables globales
	(setq *BR* NIL)
	(setq *BF* NIL)
	(setq *QuestionOK* T)
	
        (print "La base de faits vaut : ")
	(print *BF*)

	; Lancement recherche
	(print "Lancement du moteur d'inférence")
	(moteurInference)
	(showFinishedRecipes)

)

(defun moteurInference ()

	(dolist (current *BR*)

		(if (not (equal NIL (assoc (car current) *BF*))) ()

		;***********************************************
		;	ON TEST SI LA RECETTE COMPLETE EXISTE DEJA
		;***********************************************
			;Sinon on appelle verifyFacts pour vérifer la recette

			(if (equal (verifyFacts (car current)) T) 
				(progn
					(ajoutBF (list (car current) (caddr current)))
				)
				(ajoutBF (list (car current) 0))
			)
		)
	)
)
