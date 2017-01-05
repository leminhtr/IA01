; Création des variables globales
(setq *BR* NIL)
(setq *BF* NIL)
(setq *QuestionOK* T)
(setq *Categorie* NIL)

; Chargement de la base de fait et des fonctions.
(load "BR.lisp")
(load "func.lisp")

(defun main ()

  	(print "Bienvenue sur CTR (Choisi ta recette !)")
	(print "Lancement de la fabrication de BF")
	
	; Mise à 0 des variables globales
	(setq *BR* NIL)
	(setq *BF* NIL)
	(setq *QuestionOK* T)
	(setq *Categorie* NIL)

        ; On demande à l'utilisateur de rentrer les informations
	(askUser)
	
        (print "La base de faits vaut : ")
	(print *BF*)
	(print "La categorie vaut : ")
	(print *Categorie*)

	; Lancement recherche
	(print "Lancement du moteur d'inférence")


)

(main)
