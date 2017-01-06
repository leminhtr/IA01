;Total : 39 recettes

; dans un dolist (i *BR*) : 
	; La recette est i =(nom_de_la_recette nb_personne (ingredient (...)) (categorie ...) (temps ...)) 
	; La categorie, le temps et la liste des ingrédients s'obtient par (cddr i) = ((ingredient (...)) (categorie ...) (temps ...))
	; La liste des ingrédients  s'obtient par (assoc 'ingredients (cddr i)) = (INGREDIENTS (ingredient1 quantite1) (...) (ingredientn quantiten))
	; La liste des ingrédients seuls s'obtient par (cdr (assoc 'ingredients (cddr i))) = (INGREDIENTS (ingredient1 quantite1) (...) (ingredientn quantiten)...)
	; La categorie s'obtient par (assoc 'categorie (cddr i)) = (categorie nom_categorie)
	; La categorie seule s'obtient par (cdr (assoc 'categorie (cddr i))) = (categorie nom_categorie)
	; Le temps s'obtient par  (assoc 'temps (cddr i)) = (temps temps_minute)
	; Le temps seul s'obtient par (cdr (assoc 'temps (cddr i)) = (temps temps_minute)

; Les unités de quantité utilisé sont : Quantité simple (nombre de ...), gramme, mL

; Une recette est défini par la structure suivante :

; (nom_de_la_recette nb_personne
; 	(ingredients
; 		(ingredient1 quantite1)
; 		(ingredient2 quantite2)
; 		()
; 	)
; 	(categorie nom_categorie)
; 	(temps temps_minute)
; )



(setq *BR*
	'(
		;Entrées
		(cake_jambon_olive 6; ;6personnes
			(ingredients
				(farine 150); g.
				(jambon 200)
				(olive 150)
				(oeuf 4)
				(lait 100); mL
				(levure_chimique 1); sachet
			)
			(categorie entree)
			(temps 65); min.

		)
		(tarte_thon_tomate 6
			(ingredients
				(pate_brisee 1); quantite
				(creme_epaisse 200);mL
				(tomate 3)
				(thon 150);g
				(fromage 50)
				(oeuf 1)
			)
			(categorie entree)
			(temps 35)
		)
		(blinis 4; 4 pers
			(ingredients
				(yaourt 1)
				(oeuf 1)
				(farine 85)
				(levure_chimique 0.5); sachet
			)
			(categorie entree)
			(temps 25)
		)
		(chevre_en_feuillete 4
			(ingredients
				(fromage_chevre 200)
				(pate_feuillete 1)
				(oeuf 1)

			)
			(categorie entree)
			(temps 35)
		)
		(veloute_de_champignon 3
			(ingredients
				(beurre 30)
				(oignon 1)
				(champignon 250)
				(farine 20)
				(eau 250)
				(lait 500)
				(citron 1)
				(creme_fraiche 20)
			)
			(categorie entree)
			(temps 50)
		)
		(quiche_tomate_jambon_chevre 8
			(ingredients
				(pate_brisee 1)
				(jambon 100)
				(tomate 2)
				(fromage_chevre 100)
				(oeuf 2)
				(creme_liquide 100)
				(gruyere 100)
			)
			(categorie entree)
			(temps 50)
		)
		(roulade_saumon_fume_asperges_sauce_crevette_chevre_frais 4
			(ingredients
				(asperge 220)
				(saumon_fume 80); 4 tranches=80g
				(fromage_chevre 200)
				(crevette 100)
				(creme_liquide 200)
			)
			(categorie entree)
			(temps 30)
		)
		(veloute_de_carotte 6
			(ingredients
				(carotte 1000)
				(pomme_de_terre 1)
				(oignon 1)
				(eau 750)
				(beurre 20)
				(sel 10)
				(creme_liquide 200)
			)
			(categorie entree)
			(temps 35)
		)
		(salade_kiwi_tomate 2
			(ingredients
				(kiwi 2)
				(tomate 2)
				(sel 5)
				(huile_olive 20)
			)
			(categorie entree)
			(temps 5)
		)
		(verrines_colorees 7
			(ingredients
				(crouton_ail 50); 1 sachet
				(tomate 3)
				(concombre 1)
			)
			(categorie entree)
			(temps 15)
		)
		(salade_piemontaise 4
			(ingredients
				(tomate 2)
				(oeuf 2)
				(pomme_de_terre 4)
				(jambon 50)
				(cornichon 8)
			)
			(categorie entree)
			(temps 15)
		)
		(palmiers_a_la_tapenade 4
			(ingredients
				(pate_feuillete 1)
				(olive 100)
			)
			(categorie entree)
			(temps 30)
		)
		;Plats
		(filet_mignon_en_croute 6
			(ingredients
				(filet_mignon_porc 2)
				(pate_feuillete 2)
				(jambon 200)
				(gruyere 200)
				(oignon 2)
				(oeuf 2)
			)
			(categorie plats)
			(temps 60)
		)
		(quiche_lorraine 4
			(ingredients
				(pate_brisee 1)
				(lardon 200)
				(beurre 30)
				(oeuf 3)
				(creme_fraiche 200)
				(lait 200)
				(sel 10)

			)
			(categorie plats)
			(temps 60)
		)
		(poulet_basquaise 6
			(ingredients
				(poulet 1500)
				(tomate 8); 1kg
				(poivron 700)
				(oignon 3)
				(ail 3)
				(huile_olive 90)
				(sel 10)
			)
			(categorie plats)
			(temps 60)
		)
		(gratin_dauphinois 6
			(ingredients
				(pomme_de_terre 10)
				(ail 2)
				(creme_fraiche 300)
				(beurre 100)
				(lait 1000)
				(sel 10)
			)
			(categorie plats)
			(temps 85)
		)
		(chili_con_carne 3
			(ingredients
				(oignon 1)
				(ail 1)
				(viande_boeuf 400)
				(haricot_rouge 400)
				(tomate 4)
				(poudre_chili 10)
				(sel 10)
				(huile_olive 30)
			)
			(categorie plats)
			(temps 35)
		)
		(pates_carbonara 4
			(ingredients
				(pates 500)
				(creme_fraiche 500)
				(oeuf 3)
				(sel 5)
				(lardon 250)
				(oignon 1)
			)
			(categorie plats)
			(temps 20)
		)
		(saucisse_lentille 4
			(ingredients
				(lentille 250)
				(saucisse 800)
				(oignon 1)
				(carotte 1)
				(lardon 100)
			)
			(categorie plats)
			(temps 55)
		)
		(poulet_curry_oignon 4
			(ingredients
				(poulet 800)
				(oignon 2)
				(creme_fraiche 100)
				(sel 10)
				(curry 10)
			)
			(categorie plats)
			(temps 20)
		)
		(roti_porc_miel_pomme 4
			(ingredients
				(roti_porc 1)
				(pomme 4)
				(miel 30)
				(echalote 1)
				(sel 10)
			)
			(categorie plats)
			(temps 75)
		)
		(tajine_poulet 4
			(ingredients
				(poulet 800)
				(courgette 2)
				(pomme_de_terre 3)
				(carotte 2)
				(tomate 2)
				(oignon 1)
				(tajine 10)
				(huile_olive 20)
				(eau 200)
			)
			(categorie plats)
			(temps 90)
		)
		(lasagnes 4
			(ingredients
				(pate_lasagne 500)
				(viande_boeuf 250)
				(chair_saucisse 150)
				(tomate 3)
				(puree_tomate 1)
				(oignon 1)
				(carotte 1)
				(huile_olive 20)
				(sel 10)
			)
			(categorie plats)
			(temps 125)
		)
		(gigot_agneau 6
			(ingredients
				(gigot_agneau 1800)
				(ail 1)
				(beurre 100)
				(sel 10)
			)
			(categorie plats)
			(temps 95)
		)
		(riz_curry 4
			(ingredients
				(riz 300)
				(ail 1)
				(curry 20)
				(eau 600)
				(huile_olive 30)
			)
			(categorie plats)
			(temps 30)
		)
		(tartiflette 4
			(ingredients
				(pomme_de_terre 8)
				(lardon 200)
				(oignon 3)
				(reblochon 1)
				(huile_olive 30)
				(ail 1)
				(sel 10)
			)
			(categorie plats)
			(temps 75)
		)
		;Dessert
		(riz_au_lait 5
			(ingredients
				(riz 100)
				(lait 1000)
				(sucre 100)
			)
			(categorie dessert)
			(temps 125)
		)
		(tiramisu 8
			(ingredients
				(oeuf 3)
				(sucre 100)
				(sucre_vanille 1)
				(mascarpone 250)
				(biscuit_cuillere 24)
				(cafe 500);mL
				(cacao 30);g
			)
			(categorie dessert)
			(temps 255)
		)
		(ramequins_au_chocolat 4
			(ingredients
				(chocolat 120)
				(oeuf 3)
				(sucre 80)
				(beurre 35)
				(farine 15)
			)
			(categorie dessert)
			(temps 22)
		)
		(meringue_citron 6
			(ingredients
				(farine 250)
				(beurre 125)
				(sucre 70)
				(oeuf 5)
				(eau 50)
				(sel 5)
				(citron 4)
				(maizena 10)
				(levure_chimique 0.5)
			)
			(categorie dessert)
			(temps 65)
		)
		(gateau_yaourt 4
			(ingredients
				(levure_chimique 0.5)
				(yaourt 1)
				(huile_colza 60)
				(sucre 200)
				(farine 210)
				(oeuf 2)
			)
			(categorie dessert)
			(temps 45)
		)
		(flan_patissier 8
			(ingredients
				(pate_brisee 1)
				(oeuf 4)
				(lait 1000)
				(sucre 150)
				(maizena 90)
			)
			(categorie dessert)
			(temps 60)
		)
		(mousse_chocolat 4
			(ingredients
				(oeuf 3)
				(chocolat 100)
				(sucre_vanille 1)
			)
			(categorie dessert)
			(temps 70)
		)
		(gateau_pomme 8
			(ingredients
				(sucre 220)
				(sucre_vanille 1)
				(oeuf 3)
				(levure_chimique 0.5)
				(farine 125)
				(huile_colza 130)
				(pomme 4)
			)
			(categorie dessert)
			(temps 60)
		)
		(crumble_pomme 6
			(ingredients
				(pomme 6)
				(farine 150)
				(beurre 125)
				(sucre_vanille 1)
			)
			(categorie dessert)
			(temps 55)
		)
		(galette_des_rois 6
			(ingredients
				(pate_feuillete 2)
				(poudre_amande 100)
				(sucre 75)
				(oeuf 2)
				(beurre 50)
			)
			(categorie dessert)
			(temps 55)
		)
		(pancake 4
			(ingredients
				(farine 250)
				(sucre 30)
				(oeuf 2)
				(levure_chimique 1)
				(beurre 65)
				(sel 5)
				(lait 300)
			)
			(categorie dessert)
			(temps 75)
		)
		(fondant_chocolat 8
			(ingredients
				(chocolat 200)
				(beurre 100)
				(sucre 100)
				(oeuf 5)
				(farine 50)
			)
			(categorie dessert)
			(temps 35)
		)
		(tarte_aux_fraises
			(ingredients
				(farine 280)
				(beurre 125)
				(sucre 110)
				(oeuf 3)
				(eau 200)
				(sel 5)
				(lait 250)
				(sucre_vanille 1)
				(fraise 500)
			)
			(categorie dessert)
			(temps 35)
		)


	)
)

 