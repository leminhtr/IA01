; Demande à l'utilisateur toutes les informations dont on a besoin pour constituer la base de fait
(defun askUser ()
  ; Demande la catégorie voulue
  (choixCategorie)
  ; Demande le temps de cuisine voulue
  (choixTemps)
  ; Demande les ingrédients disponibles
  (choixIngredient)
)

(defun choixCategorie ()	; !!! BUG SI ON RENTRE UNE STRING !!!
	; Type de plat
	(print "Que souhaitez-vous cuisiner ?")
	(print "1. Une entree")
	(print "2. Un plat")
	(print "3. Un dessert")
	(print "4. Entree ou plat ou dessert")
	
	(let ((choice (parse-integer (read-line))))

		(loop while (or (not (>= choice 1)) (not (<= choice 4))) do
						(print "Erreur. Veuillez choisir un plat entre :")
						(print "1. Une entree")
						(print "2. Un plat")
						(print "3. Un dessert")
						(print "4. Entree, plat ou dessert")
						(setq choice (parse-integer (read-line)))
		)
		(cond
			((eq choice 1)
				(ajoutCategorie '($categorie entree)))
			((eq choice 2)
				(ajoutCategorie '($categorie plat)))
			((eq choice 3)
				(ajoutCategorie '($categorie dessert)))
			((eq choice 4)
				(ajoutCategorie '($categorie entree))
				(ajoutCategorie '($categorie plat))
				(ajoutCategorie '($categorie dessert)))
		)
	)
)

(defun ajoutCategorie (cat)
	(if (member '$categorie cat)
			(pushBF cat)
	)
)

(defun choixTemps ()	; !!!!!!!! BUG : Si on rentre une string ça plante !!!!!!!!!!!!!!
	; Demander temps disponible + ajout
	(print "De combien de temps disposez-vous pour cuisiner (en minute) ?")
	
	(let ((duree (parse-integer (read-line))))	;lit un nombre

		(loop while (and (or (numberp duree)) (not (> duree 0))) do
						(print "Veuillez saisir un temps numerique positif.")
						(setq duree (parse-integer (read-line))))
		(ajoutTemps (list '$temps duree))
	)
)

(defun ajoutTemps (duree)
	; Ajoute duree à *Temps*, retourne le fait ajouté si possible
	(if  (member '$temps duree)
			(pushBF duree)
	)
)

(defun oui_non ()	;TESTE ET APPROUVE
	; demande à l'utilisateur oui ou non
		; test la validité de la réponse
		; renvoie t si oui, nil si non.
	(print "o/n ?")
	(let 
		((quest (string-downcase (read-line)))); lit la réponse et la convertit en minuscule

		(loop while (and (not (equal quest "o")) (not (equal quest "n"))) do;tant que la réponse n'est pas correcte
			(print "Erreur. Veuillez répondre uniquement o pour oui ou n pour non.")
			(setq quest (string-downcase (read-line)))	; Reessaye
		)
		(if (equal quest "o")
			t; renvoie t si oui
			nil	;nil sinon
		)
	)
)

(defun choixQuantite ()	; !!!!!!!! BUG : Si on rentre une string ça plante !!!!!!!!!!!!!!
	; Demande à l'utilisateur une quantité entier
	; renvoie le nombre si ok.
	(print "Quelle quantité ?")
		(let
			((quant (parse-integer (read-line))))

			(loop while (or (not (numberp quant)) (not (> quant 0))) do
				(print "Veuillez saisir un nombre positif.")
				(setq quant (parse-integer (read-line))))
			quant
		)
)

(defun choix_list (liste)	;TESté et APPROUVé
	; Demande à l'utilisateur de saisir un élément de la liste
		; Affiche la liste
		; Si il y a un element qui l'interesse alors
			; Si erreur de saisie alors nouvelle tentative
			; Renvoie l'élément si ok
			; nil sinon
		; Sinon sortie
	(if (not (null (car liste)))	; si la liste est non vide
		(dolist (ingr liste)
			(print ingr)	;affiche element liste...
		)
		(print "L'element voulu est-il dans cette liste ?")
		(let 
			((quest (oui_non)))
			(if quest	;si oui
			;un élément nous interesse donc on le demande
				(progn
					(print "Veuillez recopier l'element en toute lettre.")

					; convertit input en valeur : "string" -> string
					(setq quest (read (make-string-input-stream (read-line))))
					(if (member quest liste)	; si l'élément est dans la liste
						quest	; on renvoie l'élément
						(progn	; sinon erreur : on redemande à l'utilisateur s'il veut continuer
							(print "Erreur. Reessayer ?")
							(setq quest (oui_non))
							(if quest	;si oui alors
								(choix_list liste)	; nouvelle tentative
								(return-from choix_list))	;sinon fin
						)
					)
				)
			;sinon on sort
				(progn
					(print "Desole, nous n'avons pas trouve cet element.")				
					(return-from choix_list)
				)
			)
		)
		nil
	)
)

(defun cherche_lettre_ingredient_BR ()	;TESTE ET APPROUVE
	; Retourne une liste de tous les ingredients de la BR commençant par une lettre
	; Demande à l'utilisateur de taper la 1ère lettre de l'ingredient
		; Si ok alors
			; dolist sur la BR
				; si lettre trouvé alors on ajoute l'ingredient sauf s'il est déjà présent
			; return result
	(print "Veuillez taper la premiere lettre de l'ingredient :")

	(let
		((lettre nil) (result nil))
		
		(setq lettre (string-upcase (read-line)))
		(loop while (not (eq (length lettre) 1)) do; tant que la réponse n'est pas correcte
			(print "Erreur. Veuillez saisir une lettre uniquement.")
			(setq lettre (string-upcase (read-line)))	; Reessaye
		)

		(dolist (recette_i *BR*)
			; recette_i=(nom_de_la_recette nb_personne (ingredient (...)) (categorie ...) (temps ...)) 
			(dolist (ingredient_i (cdr (assoc 'ingredients (cddr recette_i))))
			; ingredient_i= (ingredient quantite)
				(if (equal (char lettre 0) (char (symbol-name (car ingredient_i)) 0))
					(if (not (member (car ingredient_i) result))
						(push (car ingredient_i) result)
					)
				)
			)
		)
		result
	)
)

(defun choixIngredient ()
	; Demande à l'utilisateur tous les ingredients et leurs quantités à l'utilisateur
	; Demande à chaque etape la confirmation
		; en cherchant les ingrédients dans la BR commençant par une certaine lettre
		; puis les affiches
		; demande la quantité de l'ingrédient choisi
		; renvoie la liste (ingredient quantite); nil sinon
	(print "Quel ingredient avez-vous ?")

	(let 
		((list_ingr nil) (quest nil) (result_ingr nil) (result_qte nil) (result nil))

		(setq list_ingr (cherche_lettre_ingredient_BR));on cherche les ingredients dans BR
		;list_ingr contient la liste des ingredients qui commencent par la lettre voulue

		(if (null (car list_ingr))
		;si aucun ingrédient n'a été trouvé
			(progn
				(print "Aucun ingredient trouve")
				(print "Voulez-vous reessayer ? ")	;on demande une nouvelle tentative 
				(if (oui_non)	;si oui alors
					(choixIngredient)	;on redemande à l'utilisateur l'ingredient cherché
					(return-from choixIngredient)	;sinon on quitte
				)
			)

		; sinon, il y a des ingredients et on les affiche
			(progn
				(print "Veuillez choisir un ingredient : ")
				(setq result_ingr (choix_list list_ingr))	;demande quel ingredient de la liste

				(if result_ingr	; l'ingrédient a été choisi et est conforme
					(progn
						(setq result_qte (choixQuantite))
						(print "Confirmez-vous posseder cet ingredient et cette quantite ?") ; confirmation avant ajout BF
						(princ result_ingr) (princ " ") (princ result_qte)
						(if (oui_non)	; si oui alors
							(progn
								(setq result (list result_ingr result_qte))						
								(pushBF result)	;ajout dans BF
							)
						; sinon demande nouvelle tentative de saisie
							(progn
								(print "Voulez-vous reessayer ?")
								(if (oui_non)
									(choixIngredient)
									(return-from choixIngredient)
								)
							)
						)
					)
					; Cas ou pas d'ingredient valide donné
					()
				)
			)
		)
		(print "Voulez-vous ajouter un nouvel ingredient ?")
		(if (oui_non)
			(choixIngredient)
			(return-from choixIngredient)
			)
	)
)

(defun pushBF (fait)	;TESTE ET APPROUVE
	; Ajoute un fait ($x n) à la BF
	(if (listp fait) ; si le fait est une liste
		(if (eq (length fait) 2)	; de taille 2
			; test si deja present dans la BF
			(progn
				(dolist (i *BF*)
					(if (equal i fait)
						(progn
							(princ "Erreur. Le fait ") (princ fait) (princ " est deja dans la base de fait.")
							(return-from pushBF)	;fait deja present => on sort de la fonction
						)
					)
				)	; sinon le fait n'est pas encore present
				(push fait *BF*)	; donc on l'ajoute
			)
			(print "Erreur. Ce fait n'est pas conforme.")
		)
		(print "Erreur. Ce fait n'est pas une liste.")
	)
)

(defun get_attribut (liste attribut)
	(if (null liste)
		nil
		(cadr (assoc attribut liste))
	)
)

(defun tri_categ (list_recette categorie)
	(let 
		((result nil))

		(dolist (i list_recette result)
			(if (equal (string-upcase (cadr (assoc 'categorie (cddr i)))) (string-upcase categorie))
				(push i result)
				)
		)
	)
)

(defun tri_temps (list_recette temps_max)
	(let 
		((result nil))

		(dolist (i list_recette result)
			(if (<= (cadr (assoc 'temps (cddr i))) temps_max)
				(push i result)
				)
		)
	)
)

(defun tri_ingr (list_recette list_ingr)
	(let 
		((ingredient_ness_et_dispo nil)
			(result nil))
		(dolist (i list_recette)	;i=(nom_de_la_recette nb_personne (ingredient (...)) (categorie ...) (temps ...))
			(dolist (j (cdr (assoc 'ingredients (cddr i)))); j=((ingredient1 quantite1) (...) (ingredientn quantiten)...)
				(dolist (k list_ingr); k=((ingr1 quantite1) (ingr2 quantite2) (...))
					(if (and (equal (car k) (car j)) (not (member (car k) ingredient_ness_et_dispo)))
						(if (>= (cadr k) (cadr j)); Test de la quantite
						 	(push (car k) ingredient_ness_et_dispo)
						 )
					)
				)
			)

				; Est ce que j'ai tous les ingredients ?
				(if (eq (length ingredient_ness_et_dispo) (length (cdr (assoc 'ingredients (cddr i)))))
					(push i result)
					)
				(setq ingredient_ness_et_dispo nil)
				)
		result
		
	)
)


(defun get_ingr (liste)
	(let 
		((result nil))
		(dolist (i liste result)
			(if (not (equal (char (symbol-name (car i)) 0) (char "$" 0)))
				(push i result)
			)
		)
	)
)


(defun print_result (result)

(let 
	((nb_result (length result))
	(choice 0))

	
	(cond
		((or (eq 0 nb_result) (eq NIL nb_result)) (print "Nous n'avons pas trouvé de recette correspondant à vos critères."))
		((eq 1 nb_result) (print "Recette trouvée : ")
				(print result))
		(t 
			(print "Nous avons trouvé plusieurs recettes : ")


			(loop while (or (not (>= choice 1)) (not (<= choice 3))) do

					(print "Préferez-vous :")
					(print "1. Une recette rapide ?")
					(print "2. Economiser vos ingrédients ?")
					(print "3. Peu importe.")
					(setq choice (parse-integer (read-line)))
			)			
			(cond
				((eq choice 1)
					(print (min_temps result)))
				((eq choice 2)
					(print (min_ingredient result)))
				((eq choice 3)
					(print (car result)))
			)
		); Fin plusieurs recettes trouves
		)
	) ; Fin let
	nil ; La fonction ne renvoi rien
) ; Fin print_result

(defun min_ingredient (list_recette)
	(let ((min 9999) (result nil))
	(dolist (i list_recette result)
		(if (< (length (cdr (assoc 'ingredients (cddr i)))) min)
			(progn 
			(setq min (length (cdr (assoc 'ingredients (cddr i)))))
			(setq result i))
		)
	)


	); fin let
) ; Fin min_ingredient

(defun min_temps (list_recette)
	(let ((min 9999) (result nil))
	(dolist (i list_recette result)
		(if (< (cadr (assoc 'temps (cddr i))) min)
			(progn 
			(setq min (cadr (assoc 'temps (cddr i))))
			(setq result i))
		)
	)
	)
)