(defun printIngred (lettre)
	; ajoute un ingrédient à la *BF*

	(let (
		(dejaUtilise NIL) ; liste des ingrédients déjà affichés
		(index 0) ; numéro d'un ingrédient dans la liste
		(currentItem NIL) ; liste (index nom) d'un ingrédient de l'énumération
		(listOfItems NIL) ; liste de currentItem, contenant tous les ingrédients de l'énumération 
		(selectedIngred NIL) ; liste de l'ingrédient de retour (nom de l'ingrédient quantité)
		) ; fin dec var


		(dolist (current *BR*) ;on prend la liste des recettes (regles) et on tourne dolist dessus (var current)
			(dolist (currentIngredient (cadr current)) 	;on prend tous les nom d'ingredients de la recette actuelle (caadr current) 
														;et on tourne dessus pour afficher ceux qui commencent par la lettre indiquée

				(if (and
						; si currentIng (le nom de l'ingrédient) commence par la lettre cherchée
						(equal (char lettre 0) (char (symbol-name (car currentIngredient)) 0))
						; et s'il nest pas deja utilise
						(not (member (car currentIngredient) dejaUtilise))
						; et s'il ne commence pas par +
						(not (equal (char "+" 0) (char (symbol-name (car currentIngredient)) 0)))
						) 
					(progn
						(push (car currentIngredient) currentItem)
						(push index currentItem)
						(push currentItem listOfItems)
						(setq currentItem NIL)
						(print index)
    					(princ ": ")
    					(princ (car currentIngredient))
						(setq index (+ index 1))
						(push (car currentIngredient) dejaUtilise)
						)
				)
			)
		)
		
		(print "Choisissez un ingredient en inserant le numero correspondant: ")
		(push (cadr (assoc (parse-integer (read-line)) listOfItems)) selectedIngred)
		;on utilise cadr pour recuperer le nom sans parentheses
		;on parse le int lu de la ligne 

		(print "Quelle quantite possedez-vous?")
		(push (parse-integer (read-line)) selectedIngred)
		(print "Ingredient Selectionne: ")
		(princ (reverse selectedIngred))
		(if (assoc (car (reverse selectedIngred)) *BF*)
				(print "Attention, ce truc est deja dans la BF. Action d'ajout ignoree.")
				(push (reverse selectedIngred) *BF*)
				)
	)
)

(defun askForLetter ()
	(let (
		(letter NIL)
		)

		(print "Si vous avez d'autres ingredients a ajouter veuillez indiquer la premiere lettre de l'ingredient (en majuscules)")
		(setq letter (read-line))
		(printIngred letter)
		(if (y-or-n-p "Ajouter un autre ingredient?")
    			(askForLetter)
		)
	)
)




(defun verifyFacts (ingredient)
	(let (
		(answer NIL)
		(quantite NIL)
		(allIngred T)
		(currentItem NIL)
		(itemTemp NIL)
		)

		(dolist (currentIngredient (cadr (assoc ingredient *BR*))) ; pour chaque ingrédient de la recette courante
			(if (or (equal (string (symbol-name (car currentIngredient))) "+T_PREPARATION")
								(equal (string (symbol-name (car currentIngredient))) "+DIFFICULTE")
								(equal (string (symbol-name (car currentIngredient))) "+CATEGORIE"))
				; si c'est une exception
				; si ça ne correspond pas à la BF (= aux souhaits de l'utilisateur), on quitte
				(if (handleException currentIngredient) (return))

				; sinon, si c'est un ingrédient normal
				(progn
					(if  (not (equal NIL (assoc (car currentIngredient) *BF*)))
						; si l'assoc retourne qq chose : l'ingredient existe dans la base de faits

						;*******************
						;	Si l'ingredient est dans la base de faits
						;*******************
							(if (>= (cadr (assoc (car currentIngredient) *BF*)) (cadr currentIngredient)) ;si la qtte est superieure a la regle

								; (on utilise cadr pour prendre la valeur numerique de quantite sans parentheses)
								() ; all good


								; il n'y a pas assez de l'ingrédient actuel
								(return-from verifyFacts NIL) ;juste pour "break" le loop
							)

						;*******************
						;	Si l'ingredient n'est pas dans la base de faits
						;*******************
							(if (and *QuestionOk* (askQuestion currentIngredient)) ; si en posant la question on obtient l'ingrédient
								() ; then, all ok !

								;else si la reponse est NON (= il n'y en a pas assez / on ne pose pas la question)
								; ---> on check si il est dans la BR pour voir si on peut fabriquer l'ingrédient courant
									 ; càd s'il existe dans les recettes et n'existe pas dans la BF
								(if (and (equal NIL (assoc (car currentIngredient) *BF*))
									(not (equal NIL (assoc (car currentIngredient) *BR*)))
									)
									
									; on regarde si on peut effectivement le fabriquer
									(if (equal (verifyFacts (car currentIngredient)) T)
										; si oui, on met à jour la valeur
										(progn
											(if (assoc (car currentIngredient) *BF*)
												(setq *BF* (remove (assoc (car currentIngredient) *BF*) *BF*))
											)
											(ajoutBF currentIngredient)
										)
										(setq allIngred NIL)
									)

									; s'il n'est pas "fabriquable" c'est la fin des haricots, on ne peut rien faire...
									(return-from verifyFacts NIL)

								)
							)
					); FIN IF l'ingrédient est/n'est pas dans la BF
				); FIN PROGN
			) ; FIN IF c'est une exception ou un ingrédiant normal
		) ; FIN DOLIST

		; si tous les ingrédients de la recette sont OK, la recette est vérifiée (= faisable)
		(if (equal allIngred T)
			T
			NIL
		)
	)
)

(defun entreePlatDessert ()
	; Type de plat
	(print "Vous cherchez... ")
	(print "	1. une entree")
	(print "	2. un plat")
	(print "	3. un dessert")
	(let ((choice (parse-integer (read-line))))
		(cond
			((eq choice 1)
				(ajoutBF '(+categorie entree)))
			((eq choice 2)
				(ajoutBF '(+categorie plat)))
			((eq choice 3)
				(ajoutBF '(+categorie dessert)))
			(T
				(ajoutBF '(+categorie tout)))
		)
	)

)

(defun askQuestion (&optional ingredient)
	; demande si l'ingrédient est dans la possession de l'utilisateur
	; ajoute l'information à la *BF*
	; retourne T si il en possède, NIL sinon
	; Attention ! Prérequis : ingredient NE FAIT PAS PARTIE DE *BF*
	(let (answer qte)
		(write-char #\space) ; retour à la ligne sans print

		(if (eq (cadr ingredient) 1)
			(progn ; si on fait la phrase au singulier
				(princ "Possedez-vous un(e) ")
				(princ (car ingredient))
				(princ " ? Y/N ")
				(setq answer (read-line))

				; Check reponse correcte
				(loop while (and (not (equal answer "Y")) (not (equal answer "N"))) do
						(print "Seulement Y ou N ")
						(setq answer (read-line))
					)

				; Push *BF*
				(if (equal answer "Y")
					(progn
						(ajoutBF (list (car ingredient) 1))
						(setq qte 1)
					)
					(progn
						(ajoutBF (list (car ingredient) 0))
						(setq qte 0)
					)
					)
				)
			(progn ; si on la fait au pluriel
				(princ "Possedez-vous de la/du ")
				(princ (car ingredient))
				(princ " ? Indiquez une quantite ")
				(setq qte (parse-integer (read-line)))

				; Check reponse correcte
				(loop while (< qte 0) do
					(print "Rentrez un nombre positif svp ")
					(setq qte (parse-integer (read-line)))
					)

				(if (eq qte NIL)
					(setq qte 0))

				; push BF
				(ajoutBF (list (car ingredient) qte))
			)
		)

		(if (>= qte (cadr ingredient))
			T
			NIL
		)
	)
)

(defun handleException (currentIngredient)

	(if (equal (string (symbol-name (car currentIngredient))) "+T_PREPARATION")
		(cond
			( (and (equal (string (cadr (assoc 'T_PREPARATION *BF*))) "COURT") (> (cadr currentIngredient) 20))
				(return-from handleException T)
			)
			( (and (equal (string (cadr (assoc 'T_PREPARATION *BF*))) "MOYEN") (> (cadr currentIngredient) 40))
				(return-from handleException T)
			)
		)
	)

	(if (and (equal (string (symbol-name (car currentIngredient))) "+DIFFICULTE")
		(> (cadr (assoc '+DIFFICULTE *BF*)) (cadr currentIngredient)) ;Si la difficulte est inferieure a celle de la recette
		)
		(progn 
			(if (not (equal (cadr (assoc '+DIFFICULTE *BF*)) 4)) ; Si ce n'est pas 4 on quitte la boucle
				(return-from handleException T)
			)
		)
	)

	; (if (and (equal (string (symbol-name (car currentIngredient))) "+CATEGORIE")
	; 	(not (equal (string (cadr (assoc '+CATEGORIE *BF*))) (string (cadr currentIngredient)))) ;Si la categorie n'est pas la meme
	; 	)
	; 	(progn 
	; 		(if (not (equal (string (cadr (assoc '+CATEGORIE *BF*))) "TOUT")) ; Si ce n'est pas tout on quitte la boucle
	; 			(return-from handleException T)
	; 			)
	; 	)
	; )	
)

(defun ajoutBF (ingredient)
	(if (listp ingredient)
		(if (eq (length ingredient) 2)
			(if (assoc (car ingredient) *BF*)
				(progn
					(print "Attention, ce truc est deja dans la BF. Action d'ajout ignoree !")
					(print ingredient)
				)
				(progn
					(push ingredient *BF*)
					(if (and (assoc '+CATEGORIE (cadr (assoc (car ingredient) *BR*))) (not (eq (cadr ingredient) 0)))
						(push (car ingredient) *BaseResult*)
					)
				)
			)
			(progn
				(print "Erreur, l'ingredient n'est pas de la forme (igredient qte)")
				(print ingredient)
			)
		)
		(progn
			(print "Erreur, ingredient n'est pas une liste")
			(print ingredient)
		)
	)
)

(defun showFinishedRecipes()
	(let (
		(index 0)
		(recipesOrder NIL)
		(recipeChosen NIL)
		(subRecipes NIL)
		)

		(if *BaseResult*
			(progn
				(print "Choisissez la recette a afficher grace au numero!")
				(dolist (currentRecipe *BaseResult*)
					(if currentRecipe
						(progn
							(print index)
							(princ ": ")
							(princ currentRecipe)
							(push (list index currentRecipe) recipesOrder)
							(setq index (+ index 1))
						)
						()
					)
				)

				(print "Entrez le numero de la recette a afficher: ")
				(setq recipeChosen (parse-integer (read-line)))
				(setq recipeChosen (cadr (assoc recipeChosen recipesOrder)))
				


				(setq subRecipes (searchIngredients recipeChosen))
				(push recipeChosen subRecipes)
				(dolist (currentRecipe subRecipes)
					(if currentRecipe
						(progn
								(print "Pour faire ")
								(princ currentRecipe)
								(princ " vous aurez besoin de:")

									(dolist (currentIngredient (cadr (assoc currentRecipe *BR*)))
										(print currentIngredient)
										)
								(print "*******************")
						)
						()
					)
				)
			)
			(print "Le SE n'a pas trouve de recette !")
		)
	)
)

(defun searchIngredients (recipe)
	(let (
		(tempList NIL)
		)

		(dolist (currentIngredient (cadr (assoc recipe *BR*)))
			(if (assoc (car currentIngredient) *BR*)
				(progn

					(push (car currentIngredient) tempList)
					(push (cadr (searchIngredients (car currentIngredient))) tempList)

				)
			)
		)

		tempList

	)
)
