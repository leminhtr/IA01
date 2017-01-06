; Demande à l'utilisateur toutes les informations dont on a besoin pour constituer la base de fait
(defun askUser ()
  ; Demande la catégorie voulue
  (choixCategorie)
  ; Demande le temps de cuisine voulue
  (choixTemps)
  ; Demande les ingrédients disponibles
  (choixIngredient)
)

(defun choixCategorie ()
	; Type de plat
	(print "Que souhaitez-vous cuisiner ?")
	(print "1. Une entree")
	(print "2. Un plat")
	(print "3. Un dessert")
	(print "4. Entree ou plat ou dessert")
	
	(let ((choice (parse-integer (read-line))))

		(loop while (and (not (>= choice 1)) (not (<= choice 4))) do
						(print "Veuillez choisir un plat entre :")
						(print "1. Une entree")
						(print "2. Un plat")
						(print "3. Un dessert")
						(print "4. Entree, plat ou dessert")
						(setq choice (parse-integer (read-line)))
		)
		(cond
			((eq choice 1)
				(ajoutCategorie '(($categorie entree))))
			((eq choice 2)
				(ajoutCategorie '(($categorie plat))))
			((eq choice 3)
				(ajoutCategorie '(($categorie dessert))))
			((eq choice 4)
				(ajoutCategorie '(($categorie entree)))
				(ajoutCategorie '(($categorie plat)))
				(ajoutCategorie '(($categorie dessert))))
		)
	)
)


(defun ajoutCategorie (cat)
	(if (assoc '$categorie cat)
		(progn
			(setq *Categorie* (cdr (assoc '$categorie cat)))
			(pushBF cat)
		)
	)
  
)


(defun choixTemps ()
	; Demander temps disponible + ajout
	(print "De combien de temps disposez-vous pour cuisiner (en minute) ?")
	
	(let ((duree (parse-integer (read-line))))

		(loop while (and (not (numberp duree)) (not (> duree 0))) do
						(print "Veuillez saisir un temps numerique positif.")
						(setq duree (parse-integer (read-line))))
		(ajoutTemps (list '$temps duree))
	)
)


(defun ajoutTemps (duree)
	; Ajoute duree à *Temps*, retourne le fait ajouté si possible
  (if  (assoc '$temps duree)
       (progn
       		(setq *Temps* (cdr (assoc '$temps duree)))
       		(pushBF duree)
       	)
  )
)



(defun choixIngredient ()
	(print "Quel ingredient avez-vous ?")

)

(defun pushBF (fait)
	; Ajoute un fait ($x n) à la BF
	(if (listp fait) ; si le fait est une liste
		(if (eq (length fait) 2)	; de taille 2
			; test si deja present dans la BF
			(progn
				(dolist (i *BF*)
					(if (equal i fait)
						(progn
							(print "Erreur. Ce fait est deja dans la base de fait.")
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

(defun chercheIngredientBR (ingredient)
	; cherche si l'ingredient : ingredient existe dans la BF
	; renvoie T si oui, nil sinon
	(let ((bool nil))
		(dolist (i *BR*)
			(if (assoc ingredient (cdr (assoc 'ingredients (cddr i))))	;si l'ingredient existe
				(setq bool t)	; alors true
				nil	; sinon nil
			)
		)
		bool	;return bool
	)
)













