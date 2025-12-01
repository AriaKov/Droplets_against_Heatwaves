///@desc DS GRID CREATE

global_var_to_local();


//Hypothèse : stockage avec ds_grid (global.grid) ou autant de variables que de plantes ?
//méthode - propre mais fonctionnelle...
storage_by_grid			= false;


#region GRILLE DES GRAINES POUR L'INVENTAIRE (non)
/*
	//	quantité (c0)	nom (c1)
	//	...				"..."		(_i = 0)
	//	...				"..."		(_i = 1)

	seeds_height = 10;
	global.seeds = ds_grid_create(2, seeds_height);
	ds_grid_clear(global.seeds, 10);

	var _c = 0; var _i = 0;
	//Remplissage de la colonne des quantités : à 0 (déjà fait avec clear)
	//repeat(seeds_height - 1){ global.seeds[# _c, _i++] = 0; }

	_c = 1;
	global.seeds[# _c, _i++] = "Arbre maison";
	global.seeds[# _c, _i++] = "Tree";
	global.seeds[# _c, _i++] = "Bouleau";
	global.seeds[# _c, _i++] = "Bush";
	global.seeds[# _c, _i++] = "Cactus";
	global.seeds[# _c, _i++] = "Lys";

	//Lors d'un pickup on aura : global.seeds[# 0, _specie] += 1;
*/
#endregion

	
#region LISTE DE TOUTES LES PLANTES (sous forme d'objets, triés par ordre alphabétique)

//La bonne vieille méthode à la mano est peut-être la plus optimale en terme de performances (tant que je n'ajoute pas des enfants en cours de route)
	all_plants_array = [
		obj_flore_arbremaison,
			
		obj_flore_bouleau, 
			
		obj_flore_bush, 
		obj_flore_cactus,
			
		obj_flore_daisy,
		obj_flore_grass,
		obj_flore_herb,
		obj_flore_jonc,
		obj_flore_lys,
		obj_flore_rose,
		];
	//Je vais les trier à la main ICI dans cet array, par taille (plant_size) et ordre alphabetique.
	plants_number = array_length(all_plants_array);	//nombre de plantes (différentes)
	plant = all_plants_array[0];
			
	//Pour éviter d'avoir à mettre à jour manuellement la liste d'objets de plantes chaque fois que vous ajoutez une nouvelle plante dans votre jeu,
	//vous pouvez utiliser une approche dynamique qui recherche automatiquement tous les objets enfants d'un parent spécifique.
	//Cela peut être réalisé en utilisant des fonctions de recherche d'instances dans GameMaker.
	//1. Utiliser instance_find avec un Filtre
	//Vous pouvez créer une fonction qui parcourt tous les objets dans le navigateur d'actifs et qui vérifie
	//si chaque objet est un enfant d'un parent spécifique. 


	#region TRI PAR ORDRE ALPHABETIQUE
	
		//array_sort(toutes_plantes, true);	//Tri par ordre... alphabetique ?
		//Ca trie mais on ne sait pas selon quelle règle --> le mieux est d'importer une fonction de tri alphabétique.
		
		//PS : array_sort trie effectivement les éléments d'un tableau, mais cela ne fonctionne que si les éléments sont de type simple
		//(nombres ou chaînes de caractères). Ici, toutes_plantes contient des objets, et le tri ne s'applique pas directement à ces objets. Si vous souhaitez trier par le nom de la plante,
		//On doit d'abord extraire les noms dans un tableau séparé et ensuite trier ce tableau. Donc :
	/*
		noms_plantes = [];	//1) Créer un tableau de noms de plantes
	
		for(t = 0; t < array_length(all_plants_array); t++) {
			array_push(noms_plantes, toutes_plantes[t].plant_name);	//2) Ajouter le nom des plantes dans l'array
		}
		array_sort(noms_plantes, true);	//3) Trier par nom

		toutes_plantes_triees = [];	//4) Réorganiser le tableau d'objets en fonction des noms triés
			
		for(i = 0; i < array_length(noms_plantes); i++) {
			for(j = 0; j < array_length(all_plants_array); j++) {
			    if(toutes_plantes_triees[j].plant_name == noms_plantes[i]) {
			        array_push(toutes_plantes_triees, toutes_plantes[j]);
			        break;
			    }
			}
		}
			
		toutes_plantes = toutes_plantes_triees; //5) Remplacer l'ancien tableau par le tableau trié
	*/
	#endregion
		
#endregion
	
if(storage_by_grid == true)		//GRILLE GLOBALE
{
	#region DS_GRID DES PLANTES : OBJ, QUANTITY, NAME, SPRITE
	
		//Indices des colonnes
		i = 0;	yy_object		= i;
		i++;	yy_quantity		= i;
		i++;	yy_plant_name	= i;
		i++;	yy_sprite		= i;
	
		//Création de la grille
		grid_w			= i;				//largeur = nombre de caractéristiques (colonnes)
		grid_h			= plants_number;	//hauteur = nombre d'espèces plantes (lignes)
	
			show_debug_message("///// GRID_SEEDS  w : " + string(grid_w) + "  h : " + string(grid_h));
	
		global.grid_seeds = ds_grid_create(grid_w, grid_h);
		ds_grid_clear(global.grid_seeds, 0);	
	
	
		p = 0; //Index de ligne de la plante

		// REMPLISSAGE DE LA GRILLE AVEC LES VALEURS DANS LES VARIABLES
		for(p = 0; p < grid_h; p++) {			//Le strict minimum
			if(instance_exists(all_plants_array[p])) {
			global.grid_seeds[# yy_object, p]		= all_plants_array[p];	//Objet
			//global.grid_seeds[# yy_object, p]		= string(all_plants_array[p].object_index);
			global.grid_seeds[# yy_quantity, p]		= 0;										//Quantity initiale
			//var _obj								= global.grid_seeds[# yy_object, p];
			global.grid_seeds[# yy_plant_name, p]	= string(all_plants_array[p].plant_name);		//Name
			global.grid_seeds[# yy_sprite, p]		= string(all_plants_array[p].sprite_normal);	//Sprite de la seed
		
			show_debug_message("///// ///// GRID_SEEDS : " + string(grid_w) + "  h : " + string(grid_h));
			}
		}
	
		grid = global.grid_seeds;
		//Lors d'un pickup on aura : global.seeds[# yy_quantity, _specie] += 1;
	
	
			//			0			1		2		3			4			5		6			7			8
			//y (p = 0) quantité	nom		obj		description	sprite	seed_ray	seed_proba	seed_num	size
			//	(p = 1)	...			"Arbre"		...		"..."		...		...			...			...			...
			//	(p = 2)	...			"Lys"		...		"..."		...		...			...			...			...
	
			//			0			1		2				
			//y (p = 0) quantité	nom		obj		
			//	(p = 1)	...			"Arbre"		...			
			//	(p = 2)	...			"Lys"		...			

	#endregion
}


if(storage_by_grid == false)	//VARIABLES GLOBALES
{
	qty_init = 0;
	global.seed_daisy	= qty_init;
	global.seed_grass	= qty_init;
	global.seed_herb	= qty_init;
	global.seed_jonc	= qty_init;
	global.seed_lys		= qty_init;
	global.seed_rose	= qty_init;
	
	global.graines = [
		// [ ][0] = xx_object	[ ][1] = xx_quantity
		[  obj_flore_daisy,		global.seed_daisy	],	// [0][ ]
		[  obj_flore_grass,		global.seed_grass	],	// [1][ ]
		[  obj_flore_herb,		global.seed_herb	],	// [2][ ]
		[  obj_flore_jonc,		global.seed_jonc	],
		[  obj_flore_lys,		global.seed_lys		],
		[  obj_flore_rose,		global.seed_rose	],
		[  obj_flore_daisy,		global.seed_daisy	],
		];
	xx_object	= 0;
	xx_quantity = 1;
//	exemple_obj			= graines[4][xx_object];
//	exemple_quantity	= graines[4][xx_quantity];
//	show_message(string(exemple_quantity));
	//Admettons. Je cherche la quantité de Lys. je veut le yy.
	
}

