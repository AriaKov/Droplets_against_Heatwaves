
#region GAMEPLAY ONLY

	///@desc Planter une graine de plante, qui snappe sur une grille, à la position du player ou de la souris. (action = SEEDLING)
	///@desc Incrémente -- la quantité de la plante dans la grille global.grid_plants, et dans global.seeds.
	///@arg _specie Plante (object) dont on veut planter la graine. (Défaut : obj_flore_growing_lys)
	///@arg {real} _quantity	Quantité à planter. (Défaut : 1)
	///@arg {real} _cellsize Taille de cellule de la grille pour l'ancrage à la grille. (Défaut : 8)
	///@arg _ref_x Référence x pour le placement (obj_player.x, / mouse_x). (Défaut : mouse_y)
	///@arg _ref_y Référence x pour le placement (obj_player.x, / mouse_x). (Défaut : mouse_y)
	function plant_seed(argument0 = obj_flore_lys, argument1 = 1, argument2 = 8, argument3 = mouse_x, argument4 = mouse_y)
	{
		show_debug_message(" d e b u t   d e   l a   p l a n t a t i o n");
		var _specie		= argument0;	//obj_flore_growing_...
		var _quantity	= argument1;	//optionnel (défaut : 1)
		var _cellsize	= argument2;	//Taille de la grille sur lequel on veut snapper la graine
		var _ref_x		= argument3;	//obj_player.x	ou	mouse_x
		var _ref_y		= argument4;	//obj_player.y	ou	mouse_x	(facultatif)

		//var _obj = obj_flore_growing_cactus;
		//var _specie = string(_obj.plant_name);
	
		if(instance_exists(obj_c_grid_flore) == true)
		{
			var _grid = global.flore_grid;		//CF. O_GRID_FLORE (ancien nom) (ou obj_c_grid_flore)
		
			if(ds_grid_value_exists(_grid, 0, 0, 100, 100, _specie) == true)
			{
				//Position x, y de la valeur (nom de la plante) dans la grille
				var _xpos = ds_grid_value_x(_grid, 0, 0, 100, 100, _specie);
				var _ypos = ds_grid_value_y(_grid, 0, 0, 100, 100, _specie);
				
				if(_grid[# 0, _ypos] > 0)	//S'il en reste
				{
					//DECREMENT -1 DE LA QUANTITE
					_grid[# 0, _ypos] -= _quantity;
					_grid[# 0, _ypos] = clamp(_grid[# 0, _ypos], 0, 100000);

					//PLANT A SEED
					repeat(_quantity)
					{
						instance_create_layer(
							//_ref_x - (_ref_x mod _cellsize),
							//_ref_y - (_ref_y mod _cellsize),
							_ref_x + random_range(-2, 2),
							_ref_y + random_range(-2, 2),
							"Instances",
							_specie);	
					}
		
					//SOUND
					var _rand = irandom( array_length(soundbank_chute_pierre) - 1);
					sound_pickup_seed = soundbank_chute_pierre[_rand];
					if(audio_is_playing(sound_pickup_seed) == false){ audio_play_sound(sound_pickup_seed, 1, false); }
	
					//EFFECT
					//instance_create_layer(x, y, "Instances", obj_effect_tool_found);			 //Anime effet
					var _indic = instance_create_layer(x, y, "Effects", obj_effect_seed_pickup); //Anime texte : Nom de la plante / quantité
						_indic.texte = ( "Plantation : " + _specie );
				}
			}
		}	
	}

	///@desc Donne (se débarrasse) d'une graine de plante, et incrémente la demande de plante du PNJ a qui on l'a donné.
	///@desc Incrémente -- la quantité de la plante dans la grille global.grid_plants, et dans global.seeds. 
	///@arg _specie Plante (object) que l'on veut donner. (Défaut : obj_flore_lys)
	///@arg {real} _quantity	Quantité à donner. (Défaut : 1)

	function give_seed(_specie = obj_flore_lys, _quantity = 1)
	{
		show_debug_message(" d e b u t   d  u   d o n   d e   p l a n t e");
	
		if(instance_exists(obj_c_grid_flore) == true)
		{
			if(storage_by_grid == true)
			{
				var _grid = global.grid_seeds;		//CF. O_GRID_FLORE (ancien nom) (ou obj_c_grid_flore)
		
				if(ds_grid_value_exists(_grid, 0, 0, 100, 100, _specie) == true)
				{
					//Position x, y de la valeur (nom de la plante) dans la grille
					var _xpos = ds_grid_value_x(_grid, 0, 0, 100, 100, _specie);
					var _ypos = ds_grid_value_y(_grid, 0, 0, 100, 100, _specie);
				
					if(_grid[# 0, _ypos] > 0)	//S'il en reste
					{
						//DECREMENT -1 DE LA QUANTITE
						_grid[# 0, _ypos] -= _quantity;
						_grid[# 0, _ypos] = clamp(_grid[# 0, _ypos], 0, 100000);
					}
				}
			}
			else 
			{
				//LES QUANTITES SONT STOCKEES DANS DES VARIABLES SEPAREES
				
				global.seed_daisy -= _quantity;
				
			}
						
			global.seeds -= _quantity;
		
			//SOUND
			var _rand = irandom( array_length(soundbank_chute_pierre) - 1);
			sound_pickup_seed = soundbank_chute_pierre[_rand];
			if(audio_is_playing(sound_pickup_seed) == false){ audio_play_sound(sound_pickup_seed, 1, false); }
	
			//EFFECT
			//instance_create_layer(x, y, "Instances", obj_effect_tool_found);			 //Anime effet
			var _indic = instance_create_layer(x, y, "Effects", obj_effect_seed_pickup); //Anime texte : Nom de la plante / quantité
				_indic.texte = ( "You offered " + string(_quantity) + " " + _specie );
					
					
			//PASSAGE A LA DEMANDE SUIVANTE DU PNJ
			with(obj_pnj_fourmi)
			{
				state = FOURMI.NORMAL;	
				event_user(0);	//Passage à la plante demandée suivante.
				//Toutefois il faudra attendre que le PNJ soit de nouveau en state ASKING pour : 1) voir la demande et 2) y répondre.
			}
		}	
	}


	///@desc Récolter une graine de plante, à la position du player ou de la souris. (action == PICKUP)
	///@desc Incrémente ++ la quantité de la plante dans la grille global.grid_plants. 
	///@arg _specie	Nom de la plante (object)
	///@arg {real} _quantity	Quantité récoltée. (Défaut : 1)
	function pickup_seed(_specie, _quantity = 1)
	{
		//show_debug_message(" d e b u t   d u   p i c k u p");
		show_debug_message("pickup_seed() > "); 
		// _specie : obj_flore_growing_...
		// _quantity : optionnel (défaut : 1)
		
		with(obj_c_grid_flore)
		{ 
			if(storage_by_grid == true)
			{
				var _grid = global.grid_seeds;		//CF. O_GRID_FLORE
		
				if(ds_grid_value_exists(_grid, 0, 0, 100, 100, _specie) == true)
				{
					show_debug_message("pickup_seed() > l'espèce existe dans la grille"); 
				//POSITION x, y OF THE PLANT IN THE GRID
					var _xpos = ds_grid_value_x(_grid, 0, 0, 100, 100, _specie);	//on cherche du début à la fin (100) dans le tableau
					var _ypos = ds_grid_value_y(_grid, 0, 0, 100, 100, _specie);	//c'est ypos qui nous intéresse
			
					//show_debug_message("---PICKUP  _specie = "+string(_specie)+"  Dans la grille : _xpos = "+string(_xpos)+"  ypos = "+string(_ypos));
			
				//INCREMENT DU NOMBRE DE PLANTES RECOLTEES
					_grid[# yy_quantity, _ypos] += _quantity;
		
					show_debug_message("pickup_seed() > l'espèce existe dans la grille > " + string(_grid[# yy_object, _ypos]) + " : " + string(_grid[# yy_quantity, _ypos]));	//Nom : quantité
			
						//Incrémentation de la variable globale qui compte le nombre de graines en stock

				}
				else
				{
					show_debug_message("pickup_seed() > l'espèce N'EXISTE PAS dans la grille");
				}
			}
			else
			{
				//Retrouver la bonne position dans l'array global.graines
			//	repeat()
				{
					
				}
			
			
				var _obj	= global.graines[_p][xx_object];
				var _name	= object_get_name(_obj);
				var _qty	= global.graines[_p][xx_quantity];
			
			}
		}
		
		global.seed += _quantity;

		#region SOUND & EFFECT
		
			var	_soundbank_chute_pierre = [
			snd_chute_pierre_1022_01,
			snd_chute_pierre_1022_02,
			snd_chute_pierre_1022_03,
			snd_chute_pierre_1022_04,
			snd_chute_pierre_1022_05,
			snd_chute_pierre_1022_06,
			snd_chute_pierre_1022_07,
			snd_chute_pierre_1022_08,
			snd_chute_pierre_1022_09,
			snd_chute_pierre_1022_10,
			snd_chute_pierre_1022_11,
			snd_chute_pierre_1022_12,
			snd_chute_pierre_1022_13,
			snd_chute_pierre_1022_14,
			snd_chute_pierre_1022_15,
			snd_chute_pierre_1022_16,
			snd_chute_pierre_1022_17,
			snd_chute_pierre_1022_18,
		];
	
			//SOUND
			var _rand			= irandom(array_length(_soundbank_chute_pierre) - 1);
			sound_pickup_seed	= _soundbank_chute_pierre[_rand];
			if(audio_is_playing(sound_pickup_seed) == false){ audio_play_sound(sound_pickup_seed, 1, false); }
	
			//EFFECT
			//instance_create_layer(x, y, "Instances", obj_effect_tool_found);			 //Anime effet
			var _indic = instance_create_layer(x, y, "Instances", obj_effect_seed_pickup); //Anime texte : Nom de la plante / quantité
				//_indic.texte = ( string(_quantite) + " x " + _specie );
				//_indic.texte = ( string(_grid[# 0, _ypos]) + " +" +string(_quantite) + " " + _specie );
				_indic.texte = ( "+" + string(_quantity) + " " + _specie );
		
		#endregion
		
		
	}

#endregion

	function shaking_init_variables()
	{
		//SHAKING LORS DU PASSAGE DE PLAYER
		can_be_shaked	= true;
		is_shaking		= false; // Indique si l'objet est en train de frémir
		shake_angle		= 0; // L'angle actuel de frémissement
		angle_max		= 8; //10 // L'angle maximum de frémissement
		shake_speed		= 0.5; // Vitesse de frémissement
		shake_duration	= 30; // Durée du frémissement (en frames)
		shake_timer		= 0; // Timer pour le frémissement
		shake_trigger = obj_player_3d_human;
	}


#region SHAKING GRASS AND PLANTS
	
	//Le frémissement des objets au passage de player (ou autre) est codé ainsi : 
	//CREATE --->	shake_create( variables optionnelles );
	//STEP ---->	shake_step();	(utilise shake_is_shaking() et shake_stop())
	//event de collision --> shake_start();
	//autre éventuel ---->	shake_stop();
	
	///@desc Gère le démarrage du frémissement d'un objet (type herbe) (appelé dans un évent de COLLISION).
	///@desc Appeler cette fonction dans le CREATE d'un objet (ex : herbe) à faire frémir au passage d'un/ou + trigger(s).
	///@desc Déclare aussi :  can_be_shaked = true;  is_chaking = false;  shake_timer = 0; 
	///@arg {real} _angle_max	Angle maximum de frémissement (8)
	///@arg {real} _shake_speed	Vitesse de frémissement (0.5)
	///@arg {real} _shake_duration	Durée du frémissement (en frames) (30)
	///@arg _triggers	Liste de tous les objets pouvant trigger le frémissement lors d'une collision avec ([obj_player_3d_human, obj_ball, obj_ennemies...])
	function shake_create(argument0 = 8, argument1 = 0.5, argument2 = 30, argument3 = [obj_player_3d_human, obj_ball_player, obj_enemy_poissonge, obj_enemy_crabe])
	{
		//var _angle_max		= argument0;
		//var _shake_speed	= argument1;
		//var _shake_duration	= argument2;
		//var _triggers		= argument3;	
		//Déclaration des variables pour leur utilisation dans STEP et l'EVENT DE COLLISION AVEC LE(s) TRIGGER(s)
		angle_max		= argument0;
		shake_speed		= argument1;
		shake_duration	= argument2;
		triggers		= argument3;	
		angle_init		= image_angle;
		//var _angle_init		= image_angle; //Choper la variabel actuelle Angle initial (image_angle, ou 0)
	
		//START
		can_be_shaked	= true;	//Si on appelle la fonction, c'est que le shaking est possible
		is_shaking		= true;	// Marquer l'instance comme en frémissement
		shake_timer		= 0;	// Réinitialiser le timer
		shake_angle		= 0;	//Angle actuel de frémissement
	}

	//@desc Appelé par les events de collision
	function shake_start()
	{
		if (is_shaking == false) && (can_be_shaked == true)
		{
		    is_shaking = true; // Commence à frémir
		    shake_timer = shake_duration; // Réinitialise le timer
			can_be_shaked = false;
		}
	}
	
		///@desc Appelé par shake_step(). Jamais utilisée directement.
		function shake_step_is_shaking()
		{
				shake_angle += shake_speed; // Augmente l'angle
				image_angle = angle_init + ( sin(shake_angle) * angle_max ); // Modifie l'angle de l'objet
				shake_timer--;
		}

	///@desc ///@desc Appelé par shake_step(). Réinitialise l'état (l'angle redevient initial)
	function shake_stop()
	{
			is_shaking = false; 
			image_angle = angle_init; // Réinitialiser l'angle
	}
	
	///@desc Code de gestion du shaking, dans STEP. Utilise shake_is_shaking(), shake_stop(). 
	function shake_step()
	{
		if (is_shaking == true)
		{
			if (shake_timer > 0)	{	shake_step_is_shaking(); } //Frémissement		
		    else					{	shake_stop();			} //S'arrête
		}
		else {
			shake_stop();
			//image_angle = angle_init;
		}

		// Si le(s) trigger(s) est toujours en collision, arrêter le frémissement après un certain temps
		if (place_meeting(x, y, triggers)) {
			//is_shaking = false; // Fin du frémissement
			//image_angle = 0;
			//image_angle = angle_init; // Réinitialiser l'angle
			alarm[3] = 30;	//Y mettre : shake_stop();
		} 
		if (!place_meeting(x, y, triggers)) { can_be_shaked = true; }
	}


/////nope
	///@desc Gère le démarrage du frémissement d'un objet (type herbe) (appelé dans un évent de COLLISION)
	function start_shaking_0(_inst = self)
	{
		//SHAKING LORS DU PASSAGE DE PLAYER
		can_be_shaked	= true;
		is_shaking		= false; // Indique si l'objet est en train de frémir
		shake_angle		= 0; // L'angle actuel de frémissement
		max_shake		= 8; //10 // L'angle maximum de frémissement
		shake_speed		= 0.5; // Vitesse de frémissement
		shake_duration	= 30; // Durée du frémissement (en frames)
		shake_timer		= 0; // Timer pour le frémissement
		shake_trigger = obj_player_3d_human;
		
	    _inst.is_shaking = true; // Marquer l'instance comme en frémissement
	    _inst.shake_timer = 0; // Réinitialiser le timer
	    _inst.original_angle = _inst.image_angle; // Sauvegarder l'angle d'origine
	}

	///@desc Gère l'oscillation d'une instance (appelé dans STEP)
	function update_shaking_0(_inst = self)
	{
	    if (_inst.is_shaking == true)
		{
	        _inst.shake_timer += 1; // Incrémenter le timer
        
	        // Oscillation de l'angle
	        _inst.image_angle = _inst.original_angle + sin(_inst.shake_timer * 0.1) * 10; // Oscille entre -10 et +10 degrés

	        // Arrêter le frémissement après un certain temps
	        if (_inst.shake_timer > 60) { // 60 étapes = environ 1 seconde
	            _inst.is_shaking = false; // Arrêter le frémissement
	            _inst.image_angle = _inst.original_angle; // Réinitialiser l'angle
	        }
	    }
	}


#endregion


///@desc Actionne la métamorphose du global.player (self?) vers un autre objet (en argument).
///@arg actual_obj	Objet actuel (et qui est == global.player)
///@arg new_obj		Nouvel objet qui deviendra global.player.
function metamorphose_player(argument0, argument1)
{
	var _actual_player	= argument0;
	var _new_player		= argument1;
	var _x = _actual_player.x;
	var _y = _actual_player.y;
	
	if (layer_exists("Instances") == false) { layer_create(0, "Instances"); }
	var _new = instance_create_layer(_x, _y, "Instances", _new_player);
	global.player = _new;	//Notament pour la caméra
	
	instance_destroy(_actual_player);
}

///@desc Spawn x nombre d'instance dans y nombre de groupe(s), de rayon z.
///@arg _inst	
///@arg {real} _groups_number
///@arg {real} _groups_ray
///@arg {real} _inst_per_groupe
///@arg {real} _margin Marge aux bords de la room.
///@arg _collisionnables	
function spawn_groups_in_room(_inst, _groups_number = 10, _groups_ray = 10, _inst_per_groupe = 10, _margin = 16, _collisionnables = [tilemap, obj_flore_parent, obj_collision_parent, obj_player])
{

	for(var _n = 0; _n < _groups_number; _n++)	//Autant de groupes d'instances
	{
		//CARACTERSTIQUES DE CHAQUE GROUPE
		//Initialiser un point autour duquel faire apparaitre les instances
		var _groupex = irandom_range(_margin, room_width - _margin);
		var _groupey = irandom_range(_margin, room_height - _margin);


		for(var _o = 0; _o < _inst_per_groupe; _o++)	//Autant d'instances par groupe
		{

			//Même si on calcule une POSITION, on va utiliser des vecteurs.
			var _dir = irandom_range(0, 360);	//Direction aléatoire autour du centre du groupe.
	
			//La distance au centre du groupe doit être au maximum égale à perimetre_du_groupe.
			var _dist = irandom(_groups_ray);
	
			var _x = _groupex + lengthdir_x(_dist, _dir);
			var _y = _groupey + lengthdir_y(_dist, _dir);
			
			
			//Eviter de créeer des instances trop proches les unes des autres
			if collision_circle(_x, _y, 4, _inst, false, false) 
			{
				var _remaining_loop = 60;
				var _new_dir = irandom_range(0, 360); //Effet secondaire : on permet aux instances de sortir du rayon du groupe.
				
				while ( collision_circle(_x, _y, 4, _inst, false, false) && (_remaining_loop > 0) )
				{
					_x += lengthdir_x(1, _new_dir);	//à mon avis c'es très foireux en termes de performance, car potentiellement il bouge dans tous les sens plusieurs fois avant de trouvr son emplacement.
					_y += lengthdir_x(1, _new_dir);
				
					//_dist = irandom(_groups_ray);
					//_x = _groupex + lengthdir_x(_dist, _dir);
					//_y = _groupey + lengthdir_y(_dist, _dir);
					_remaining_loop--;
				}
			}

			//CREATION DE L'INSTANCE
			if (layer_exists("Instances") == false) { layer_create("Instances"); }
			instance_create_layer(_x, _y, "Instances", _inst);
		}
	}
}


#region GAMEPLAY & OTHER

	///@desc Recherche l'index de la colonne en fonction du nom de la caractéristique, dans global.grid_plants.
	///@desc Permet d'accéder aux caractéristiques sans avoir à se soucier de l'index de la colonne. Utilisable par n'importe quel objet.
	///@desc Retourne le numéro de la colonne, si existe, sinon -1.
	///@arg {string} _characteristic_name Caractéristique recherchée (sous la forme "plant_name", "plant_size", etc.)
	function get_column_index(_characteristic_name)
	{
		//au lieu de mettre directement ds_w : 
		for(var _c = 0; _c < ds_grid_width(global.grid_plants); _c++)
		{
			if (global.grid_plants[# _c, 0] == _characteristic_name)
			{
			    return _c;	//Retourne l'index de la colonne.
			}
		}
		return -1;			//Retourne -1 si la caractéristique n'est pas trouvée.
	}

#endregion


#region ONLY TO CODE

	#region POUR REMPLIR L'ARRAY TOUTES_PLANTES AUTOMATIQUEMENT (pas concluant)

		//NON
		/// @description Vérifie si une valeur existe dans un tableau (true/false).
		/// @param _array Le tableau à vérifier
		/// @param _value La valeur à rechercher
		/// @return true si la valeur existe, sinon false
		function array_contains_simple(_array, _value)	//_simple, car la fonction existe déjà
		{
		    for (var _i = 0; _i < array_length(_array); _i++)
			{
		        if (_array[_i] == _value)
				{
		            return true; // La valeur existe déjà dans le tableau
		        }
		    }
		    return false; // La valeur n'existe pas
		}

		//NON
		///@desc Ajoute des instances (en 1 seul exemplaire) d'un objet parent dans un array (= toutes_plantes)
		/// @param _obj_parent	L'objet parent dont on veut trouver tous les enfants.
		/// @param _array	L'array dans lequel mettre les enfants (sans redondance)
		function add_all_child_instance_once_in_array(_obj_parent, _array = toutes_plantes)
		{
		    var _instance_count = instance_number(_obj_parent); // Compter le nombre d'instances de l'objet parent
	
		    for(var _i = 0; _i < _instance_count; _i++)
			{
		        var _inst = instance_find(_obj_parent, _i); // Trouver l'instance

		        //Vérifier si l'instance est déjà dans l'array
		        if(array_contains(_array, _inst.id) == false)
				{
		            array_push(_array, _inst.id); // Ajouter l'instance à l'array
		        }
		    }
		}

		//NON
		///@desc Ajoute automatiquement dans un array : tous les objets enfants d'un parent, à partir de la liste d'actifs, sans avoir besoin de placer les instances dans la room.
		///@arg _array Array dans lequel mettre tous les enfants (en 1 seul exemplaire). (Défaut : toutes_plantes)
		///@arg	_obj_parent Parent dont on veut les enfants. (Défaut : obj_flore_growing_parent)
		function add_all_childs_in_array(_array = toutes_plantes, _obj_parent = obj_flore_parent)
		{
		    var _object_count = object_count; // Compte le total des objets dans le projet (NE MARCHE PAS DANS GM) (??)
		
		    for (var _i = 0; _i < object_count; _i++)
			{
		        var _obj = object_find(_i); // Trouver chaque objet par son index (??)

		        // Vérifier si cet objet est un enfant du parent spécifié
		        if (_obj != _obj_parent) && (_obj_parent[_obj] == _obj_parent)
				{
		            // Vérifier si l'objet est déjà dans l'array
		            if (array_contains(_array, _obj) == false)
					{
		                array_push(_array, _obj); // Ajouter l'objet à l'array
		            }
		        }
		    }
		}
	
	#endregion


	//FONCTIONNE MAIS JE ME ME SERS PLUS D'UNE GRILLE POUR LES CHARACTERISTICS, MAIS D'UN STRUCT
	///@desc Remplit la grille global.grid_plants avec les caractéristiques. (METHODE DRY (Don't Repeat Yourself)).
	///@desc Utilise la fonction get_column_index(). Utile uniquement pour le CREATE de obj_c_grid_flore, et remplace tous les repeat(grid_h)...
	///@arg {string} characteristic_name	Caractéristique recherchée (sous la forme "plant_name", "plant_size", etc.)
	///@arg characteristic_value	Valeur de la caractéristique pour cette plante, à entrer dans le tableau.
	function fill_grid_with_characteristic(_characteristic_name, _characteristic_value)
	{
		//_characteristic_name : On en a pas besoin sous cette forme, on veut l'index de la colonne correspondante

		var _c = get_column_index(_characteristic_name); //Obtenir l'index de la colonne
	
		if (_c == -1) return; // Si la caractéristique n'existe pas, sortez
		//sinon...
		for (var _p = 1; _p < grid_h; _p++) 		//Commence à 1 pour ignorer la ligne des noms des caractéristiques
		{
			if (instance_exists(toutes_plantes[_p]) == true)
			{
			    global.grid_plants[# _c, p] = _characteristic_value(toutes_plantes[_p]);
			}
		}
	}

	/// @description Remplit une caractéristique d'une plante donnée à partir de l'objet plante
	/// @param _plant_id L'identifiant de la plante
	/// @param _characteristic Le nom de la caractéristique à remplir
	/// @return La valeur de la caractéristique demandée
	function fill_struct_with_characteristic(_plant_id, _characteristic)
	{
		//var _plant_id = argument0;
	
	    // Assurer que l'ID de plante est valide
	    if (_plant_id < array_length(toutes_plantes)) 
		{
	        var _plant_instance = toutes_plantes[_plant_id];

	        if (instance_exists(_plant_instance))
			{
	            // Retourner la valeur de la caractéristique depuis l'instance de plante
	            return _plant_instance[_characteristic];
	        } else 
			{
	            show_error("Instance de plante non trouvée pour l'ID : " + string(_plant_id), true);
	            return undefined; // Retourner undefined si l'instance n'existe pas
	        }
	    } else 
		{
	        show_error("ID de plante invalide : " + string(_plant_id), true);
	        return undefined; // Retourner undefined si l'ID est invalide
	    }
	}

#endregion		
