; Demande à l'utilisateur toutes les informations dont on a besoin pour constituer la base de fait
(defun askUser ()
  ; Demande la catégorie voulue
  (choixCategorie)
  ; Demande les ingrédients disponibles
  (choixIngredient)
)

(defun choixCategorie ()
	; Type de plat
	(print "Que souhaitez-vous cuisiner ?")
	(print "1. Une entree")
	(print "2. Un plat")
	(print "3. Un dessert")
	(print "")
	
	(let ((choice (parse-integer (read-line))))
		(cond
			((eq choice 1)
				(ajoutCategorie '((+categorie entree))))
			((eq choice 2)
				(ajoutCategorie '((+categorie plat))))
			((eq choice 3)
				(ajoutCategorie '((+categorie dessert))))
			(T
				(ajoutCategorie '((+categorie plat))))
		)
	)

	)


(defun ajoutCategorie (cat)
  (if  (assoc '+categorie cat)
       (setq *Categorie* (cdr(assoc '+categorie cat)))
       
       )
  
  )

(defun choixIngredient ()

  )
