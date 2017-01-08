; Création des variables globales
(setq *BF* NIL)
(setq *QuestionOK* T)

; Chargement de la base de fait et des fonctions.
(load "BR.lisp")
(load "func.lisp")

(defun main ()

	(let 
		((categorie nil)
			(temps nil)
			(result nil)
			(ingredients nil)
			)


  	(print "Bienvenue sur CTR (Choisi ta recette !)")
	(print "Lancement de la fabrication de BF")
	
	; Mise à 0 des variables globales

	(setq *BF* NIL)

	(print "Voulez-vous ajouter vos propres ingrédients ? (Sinon, version de démonstration)")
    ; On demande à l'utilisateur de rentrer les informations
    (if (oui_non)
    	(askUser)
    	(let ((choice 0))
			(loop while (or (not (>= choice 1)) (not (<= choice 3))) do

				(print "Préferez-vous une démo sur :")
				(print "1. Une entrée")
				(print "2. Un plat")
				(print "3. Un dessert")
				(setq choice (parse-integer (read-line)))
			)			
				(cond
					((eq choice 1)
						(setq *BF* '(($categorie entree) ($temps 100) (pate_brisee 1) (creme_epaisse 250) (tomate 10) (thon 500) (fromage 100) (oeuf 6) (yaourt 12) (FARINE 1000) (LEVURE_CHIMIQUE 1))))
					((eq choice 2)
						(setq *BF* '(($categorie plat) ($temps 120) (pates 1000) (OEUF 6) (lardon 250) (SEL 100) (oignon 3) (poulet 1000) (curry 50) (creme_fraiche 500))))
					((eq choice 3)
						(setq *BF* '(($categorie dessert) ($temps 80) (FARINE 1000) (SUCRE 1000) (OEUF 12) (EAU 20000) (SEL 5) (LAIT 1000) (SUCRE_VANILLE 2) (FRAISE 1000) (BEURRE 1000) (LEVURE_CHIMIQUE 1))))
				)
    		)
    	)
	
    (print "La base de faits vaut : ")
	(print *BF*)


	; Lancement recherche
	(print "Lancement du moteur d'inférence")

	; On ne garde que les recettes avec la bonne categorie
	(setq categorie (get_attribut *BF* '$categorie))
	(setq result (tri_categ *BR* categorie))

	; On ne garde que les recettes avec le temps adequat
	(setq temps (get_attribut *BF* '$temps))
	(setq result (tri_temps result temps))

	; On ne garde que les recettes pour lesquelles on a les ingredients
	(setq ingredients (get_ingr *BF*))
	(setq result (tri_ingr result ingredients))

	(print_result result)
	) ; Fin let
) ; Fin defun main
