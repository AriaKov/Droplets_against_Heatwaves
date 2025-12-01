///@desc QUESTS & SUB-QUESTS DESCRIPTION

var _grid = ds_quests;

#region TRIGGERS

	//ZOOM
	var _loupe = obj_tool_loupe;
	if(instance_exists(_loupe) == true) && (instance_exists(player) == true)
	{ 
		if(collision_circle(player.x, player.y, 64, _loupe, false, false) != noone)
		{
			if(can_activate_quest_zoom == true){
				activate_new_quest(_grid, QUEST.ZOOM);
				can_activate_quest_zoom = false;
			}
		}
	}
	
	//EVAPORTATION
	if(instance_exists(obj_c_cycle_day_night) == true)	//PRECAUTION
	{
		if(obj_c_cycle_day_night.hours == 16){ 
			with(player)	{ can_evaporate = true; }
			with(droplet)	{ can_evaporate = true; }
		}
	}
	
	//FIRE
	if(instance_exists(obj_pnj_feu_follet) == true)
	{
		if(can_activate_quest_fire == true){
			activate_new_quest(_grid, QUEST.STOP_FIRE);
			can_activate_quest_fire = false;
		}
	}
	
	//RAGE
	if(player.water_state == PLAYER_HUMIDITY.RAGE)
	{
		if(can_activate_quest_rage == true){
		activate_new_quest(_grid, QUEST.RAGE);
		can_activate_quest_rage = false;
		}
	}
	
#endregion


#region ACTIVER DEBUT DES QUETES si elles sont inactives (Debug)
	if(global.debug == true)
	{
		if keyboard_check_pressed(vk_numpad0) { if(_grid[# 1, 0] == -1) { _grid[# 1, 0] = 0; }}
		if keyboard_check_pressed(vk_numpad1) { if(_grid[# 1, 1] == -1) { _grid[# 1, 1] = 0; }}
		if keyboard_check_pressed(vk_numpad2) { if(_grid[# 1, 2] == -1) { _grid[# 1, 2] = 0; }}
		if keyboard_check_pressed(vk_numpad3) { if(_grid[# 1, 3] == -1) { _grid[# 1, 3] = 0; }}
		if keyboard_check_pressed(vk_numpad4) { if(_grid[# 1, 4] == -1) { _grid[# 1, 4] = 0; }}
	}
#endregion


#region QUESTS & SUB-QUESTS DESCRIPTION

var _i = 0; repeat(ds_quests_number)
{
	#region QUESTS
	switch(_i)	//Selon le numéro de la quête (selon l'ordre dans quest_array)
	{
		//_i équivaut à l'enum = la quête en cours, par exemple _i = 0 =  QUEST.MENU = la quête 0.
		//Attention cet enum ne sert QU'A CA : pas de state, car les quêtes se chevauchent possiblement.

		#region CINEMATIQUE D'ENTREE DE JEU
		case QUEST.MENU:
			var _stage	= _grid[# 1, _i];
			switch(_stage)
			{
				case -1:
				break;
				
				case 0:
					if(input_keyboard_or_gamepad_check_pressed(global.key_absorbe, global.gp_absorbe) == true)
					|| (input_keyboard_or_gamepad_check_pressed(global.key_pause, global.gp_pause) == true)
					//|| (keyboard_check_pressed(vk_anykey) == true)
					{
						with(obj_c_gui)
						{
							state	= UI.MENU;
						}
						with(obj_c_camera){ mode = CAMMODE.MOVE_TO_TARGET_SMOOTH; }	
						
						next_subquest(_grid, _i);
					}
					
				break;
				
				case 1:	//Si le titre apparaît, la caméra rejoint player
					with(obj_c_gui)
					{
						if(show_title_abc == true) // || (input_to_shortcut_cinematic() == true)
						{
							instance_activate_object(player);
								//if(player.can_move == true){ show_message("can_move"); }
						
							with(obj_c_camera){ mode = CAMMODE.MOVE_TO_TARGET_SMOOTH; }	
							//Va automatiquement faire un travelling vers target (player)
							//Ensuite, une fois que la caméra a rejoint player, le titre s'efface progressivement	
							
							with(obj_c_music){ audio_play_sound(music_fairy, 1, false, music_fairy_gain); }
							
							//set_appropriate_text_in_gui(_grid, _i, _stage);
							next_subquest(_grid, _i);
						}
						
						if(input_to_shortcut_cinematic() == true)
						{
							instance_activate_object(player);
							with(obj_c_camera){ mode = CAMMODE.MOVE_TO_TARGET_SMOOTH; }	
							with(obj_c_camera)
							{
								cx = target_x;
								cy = target_y;
							}
							with(obj_c_gui)
							{
								title_alpha = 0;
							}
									with(obj_c_music){ audio_play_sound(music_fairy, 1, false, music_fairy_gain); }
									next_subquest(_grid, _i);
						}
					}
				break;
				
				case 2:	//Puis le titre disparait progressivement
					with(obj_c_camera)
					{
						//Revenir à FOLLOW OBJECT une fois la cible atteinte
						if(cx == target_x) || (cy == target_y)	//Selon le moyen employé j'utilise ou pas les target_x,y
						|| (dist < 2)	//Oui mais ça c'est la distance en 2d, or ici comme le cadre est vertical, 
						//la distance sur y va fausser car elle n'est jamais comblée à cause des limites de la room
						|| (point_distance(cx, 0, target_x, 0) < 2)		//Ok (ne considérer que l'horizontale)
						{ 
						//	mode = CAMMODE.FOLLOW_OBJECT;	//Reset ? ou rester dans un truc fluide :)
							
							with(obj_c_gui)
							{
								title_is_fading_out = true;
								
								global.flore_dead = 0;	//Init after the artificial growing in the begining of the room
								
								next_subquest(_grid, _i);
							}
						}
					}	
					if(input_to_shortcut_cinematic() == true)
					{
						with(obj_c_camera)
						{
							cx = target_x;
							cy = target_y;
						}
						with(obj_c_gui)
						{
							title_alpha = 0;
						}
						next_subquest(_grid, _i);
					}
				break;
				
				case 3:
					with(obj_c_gui)
					{
						if(title_alpha <= 0)
						|| (input_to_shortcut_cinematic() == true)
						{
							//Le titre a disparu, on passe à l'affichage classique en jeu (le HUD)
							state = UI.HUD;
							
							with(obj_player){ can_move = true; }	//QUEST_SYSTEM est le seul à contrôler ça
							
							with(obj_c_cycle_day_night){ time_pause = false; }
							
							with(obj_c_gui){ text = ""; }
							
							set_appropriate_text_in_gui(_grid, _i, _stage);
							next_subquest(_grid, _i);	//Toujours passer au cas suivant même si fin de quête
							
							activate_new_quest(_grid, QUEST.TUTO);
						}

					}
				break;
				
				case 4:
				break;
			}
		break;
		#endregion
				
		#region TUTO
		case QUEST.TUTO:
			_stage	= _grid[# 1, _i];
			switch(_stage)
			{
				case -1:
				break;
				
				case 0:	
				//	set_appropriate_text_in_gui(_grid, _i, _stage -1);	
					//stage -1 car dans le script on +1 pour afficher le suivant (l'action suivante à faire)
					//Mais ici j'ai besoin de le mettre sinon text = "".

					if keyboard_check_pressed(global.key_r) 
					|| keyboard_check_pressed(global.key_l) 
					|| keyboard_check_pressed(global.key_u)
					|| keyboard_check_pressed(global.key_d) 
					|| gamepad_button_check_pressed(0, global.gp_h)
					|| gamepad_button_check_pressed(0, global.gp_v)
					{
						set_appropriate_text_in_gui(_grid, _i, _stage);
						next_subquest(_grid, _i);
					}
				break;
				
				case 1:
					if input_keyboard_or_gamepad_check_pressed(global.key_pause, global.gp_pause)
					{
						set_appropriate_text_in_gui(_grid, _i, _stage);
						//with(obj_c_gui){ text = ""; }
						next_subquest(_grid, _i);
					}
				break;
				
				case 2:
					if input_keyboard_or_gamepad_check_pressed(global.key_pause, global.gp_pause)
					{
						set_appropriate_text_in_gui(_grid, _i, _stage);
						next_subquest(_grid, _i);
						
					}
				break;
				
				case 3:	
				with(player)
				{
					if(input_keyboard_or_gamepad_check_pressed(global.key_zoom, global.gp_zoom) == true)
					{
						//with(obj_c_gui){ text = ""; }
						set_appropriate_text_in_gui(_grid, _i, _stage);
						hide_textbar_after_a_moment(5);
						
												{ can_evaporate = true; }
						with(obj_pnj_droplet)	{ can_evaporate = true; }
						
						next_subquest(_grid, _i);
						
					//	activate_new_quest(_grid, QUEST.ABSORB_WATER);
					}
				}				
				break;
				
				case 4:
				break;
			}
		break;
		#endregion	
		
		#region ABSORB WATER
		case(QUEST.ABSORB_WATER):
			//VERIFICATION DE L'ETAT DE LA QUETE (-1, 0, 1)
			//switch(ds_quests[# _i, 1]) //ça c'est si w et h étaient comme je l'aura fait... Mais Friendly Cosmonaut les inverse.
			_stage	= _grid[# 1, _i];	//Etat de la quête 
	
			switch(_stage)	//DESCRIPTION DES SUB-QUESTS
			{
				case -1:	//QUETE NON PROPOSEE
				break;
				
				case 0:		//DESCRIPTION DE LA SUB-QUETE 0
				with(player)
				{
					var _source = instance_place(x, y, obj_watersource); //instance_place permet de récolter la valeur de  l'instance pour l'utiliser
				//	var _tiles_water = global.tilemap_water;
					if (_source != noone) //s'il y a collision...
					|| (place_meeting(x, y, tilemap_water) == true)
					{
					//	with(_source)
						{
							set_appropriate_text_in_gui(_grid, _i, _stage);
							next_subquest(_grid, _i);
						}
					}
				}
				break;
				
				case 1:		//DESCRIPTION DE LA SUB-QUETE 1
				with(player)
				{
					if(humidity >= humidity_max)
					{
						set_appropriate_text_in_gui(_grid, _i, _stage);
						next_subquest(_grid, _i);
					}
				}
				break;
				
				case 2:		//DESCRIPTION DE LA SUB-QUETE 2
				with(player)
				{
					if(input_keyboard_or_gamepad_check_pressed(global.key_splash, global.gp_splash))
					{
						set_appropriate_text_in_gui(_grid, _i, _stage);
						hide_textbar_after_a_moment(5);
						
												{ can_evaporate = true; }
						with(obj_pnj_droplet)	{ can_evaporate = true; }
						
						activate_new_quest(_grid, QUEST.HYDRATE_PLANT);
						
						next_subquest(_grid, _i);
					}
				}				
				break;
				
				case 3:	
				break;
			}
			
		break;
		#endregion
		
		#region ZOOM
		case QUEST.ZOOM:
		_stage	= _grid[# 1, _i];
			switch(_stage)
			{
				case -1:	//QUETE NON PROPOSEE
				break;
				
				case 0:
				if(global.found_tool_loupe == true)
				{
					set_appropriate_text_in_gui(_grid, _i, _stage);
					next_subquest(_grid, _i);
				}
				break;
				
				case 1:	
				with(player)
				{
					if(input_keyboard_or_gamepad_check_pressed(global.key_zoom, global.gp_zoom) == true)
					{
						with(obj_c_gui){ text = ""; }
						
						//Active la quête STOP FIRE
						//var _quest_to_activate = QUEST.STOP_FIRE;
						//if(_grid[# 1, _quest_to_activate] == -1) { _grid[# 1, _quest_to_activate] = 0; }
					//	activate_new_quest(_grid, QUEST.STOP_FIRE);
						
						next_subquest(_grid, _i);
					}
				}				
				break;
				
				case 2:
				break;
			}
		break;
		#endregion
		
		#region ARBORIST
		case QUEST.ARBORIST:
			_stage	= _grid[# 1, _i];
			switch(_stage)
			{
				case -1:	//QUETE NON PROPOSEE
				break;
				
				case 0:	
					with(player)
					{
						var _seed = collision_circle(x, y, ray_action, obj_flore_parent, false, false); //collision_circle permet de récolter la valeur de  l'instance pour l'utiliser
						if(_seed != noone) //s'il y a collision...
						{
							//Save the id of that seed
							with(_seed)
							{
								if(growth_stage == GROWTHSTAGE.SEED)
								{
								//	image_blend = c_blue; 
								
								set_appropriate_text_in_gui(_grid, _i, _stage);
								next_subquest(_grid, _i);	
								}
							}
						}
					}
				break;
				
				case 1:
					if(global.seeds == 1) //On a réussit à pickup 1 graine !
					{
						set_appropriate_text_in_gui(_grid, _i, _stage);
						next_subquest(_grid, _i);	
					}
				break;	
			}
		break;
		#endregion
		
		#region STOP FIRE
		case(QUEST.STOP_FIRE):
			_stage	= _grid[# 1, _i];
			switch(_stage)
			{
				case -1:
				break;	

				case 0:	
					with(splash)
					{
						if(place_meeting(x, y, obj_flore_bouleau) == true)
						{
							
						}
					}
					with(player)
					{
					//	var _inst = instance_place(x, y, obj_trigger_fire);
					//	if (_inst != noone) //s'il y a collision...
						var _fire = obj_fire_parent;
					//	if(instance_exists(_fire) == true)
						{
					//		var _fire_near = collision_circle(x, y, ray_action, _fire);
							//if(distance_to_object(_fire) <= ray_action))
					//		if(_fire_near != noone)
							{
					//			set_appropriate_text_in_gui(_grid, _i);
					//			next_subquest(_grid, _i);
							}
						}
					}	
					if(instance_exists(obj_fire_parent) == true)
					{
				//		set_appropriate_text_in_gui(_grid, _i);
				//		hide_textbar_after_a_moment();
						next_subquest(_grid, _i);
					}
				break;
				
				case 1:	
					if(global.fires_stopped == 1)
					{
					//	set_appropriate_text_in_gui(_grid, _i);
						hide_textbar_after_a_moment();
						next_subquest(_grid, _i);
					}				
				break;
				
				case 2:	
					if(global.fires_stopped == 100)
					{
					//	set_appropriate_text_in_gui(_grid, _i);
						hide_textbar_after_a_moment();
						next_subquest(_grid, _i);
					}				
				break;
				
				case 3:
				break;
			}
			
		break;
		#endregion

		#region HYDRATE_PLANT
		case QUEST.HYDRATE_PLANT:
			switch(_grid[# 1, _i])
			{
				case -1:	//QUETE NON PROPOSEE
				break;
				
				case 0:
					if(global.plants_hydrated_by_splash >= 10)
					{
				//		set_appropriate_text_in_gui(_grid, _i);
						next_subquest(_grid, _i);
					}
				break;
					
				case 1:	
					if(global.plants_hydrated_by_splash >= 100)
					{
				//		set_appropriate_text_in_gui(_grid, _i);
				//		hide_textbar_after_a_moment();
						next_subquest(_grid, _i);
					}
				break;
				
				case 2:
					if((global.plants_hydrated_by_splash * 2) >= instance_number(obj_flore_parent))
					{
					//	set_appropriate_text_in_gui(_grid, _i);
					//	hide_textbar_after_a_moment();
						next_subquest(_grid, _i);
						
						//Active le spawn d'ennemis feu follet !
					//	with(obj_c_spawner_flame_enemy){ active = true; }
						instance_create_layer(-200, -200, "Controllers", obj_c_spawner_flame_enemy);
						
					}		
				break;
				
				case 3:
					next_subquest(_grid, _i);
				break;
				
				case 4:
					
						with(obj_player)		{ can_evaporate = true; }
						with(obj_pnj_droplet)	{ can_evaporate = true; }
						
					activate_new_quest(_grid, QUEST.STOP_FIRE);
					next_subquest(_grid, _i);
				break;

				case 5:
				break;
				
			}
		break;
		#endregion


		#region ...
		case 10:
			switch(_grid[# 1, _i])
			{
				case -1:	//QUETE NON PROPOSEE
				break;
				
				case 0:	
				break;
				
				case 1:
				break;	
			}
		break;
		#endregion

/*

		#region PAINT THINGS
		case(QUEST.PAINT):
			
			//VERIFICATION DE L'ETAT DE LA QUETE (-1, 0, 1)
			//switch(ds_quests[# _i, 1]) //ça c'est si w et h étaient comme je l'aura fait... Mais Friendly Cosmonaut les inverse.
			
			//var _my_red_tree = noone;		show_debug_message(string(_my_red_tree));
			
			var _stage	= _grid[# 1, _i];	//Etat de la quête 
	
			switch(_stage)	//DESCRIPTION DES SUB-QUESTS
			{
				case -1:	//QUETE NON PROPOSEE
				break;
				
				case 0:		//DESCRIPTION DE LA SUB-QUETE 0
				with(player)
				{
					var _inst = instance_place(x, y, obj_flore_parent); //instance_place permet de récolter la valeur de  l'instance pour l'utiliser
					if (_inst != noone) //s'il y a collision...
					{
						//Save the id of that tree
						global._my_red_tree = _inst;	show_debug_message("_my_red_tree = " + string(global._my_red_tree));
							
						with(_inst)
						{
							image_blend = c_yellow; 
							
							next_subquest(_grid, _i);	//Fin de la sub-quête et passage à la suivante
							//_grid[# 1, _i] += 1;		show_debug_message("SUBQUEST ACHIEVED : QUEST.PAINT - 0");
						}
					}
				}
				break;
				
				case 1:		//DESCRIPTION DE LA SUB-QUETE 1
				with(player)
				{
					var _inst = instance_place(x, y, obj_flore_parent); //instance_place permet de récolter la valeur de  l'instance pour l'utiliser
					if (_inst != noone and _inst != global._my_red_tree) //s'il y a collision...
					{
						with(_inst)
						{
							image_blend = c_blue; 
								
							//Fin de la sub-quête et passage à la suivante
							_grid[# 1, _i] += 1;		show_debug_message("SUBQUEST ACHIEVED : QUEST.PAINT - 1");
						}
					}
				}
				break;
				
				case 2:		//DESCRIPTION DE LA SUB-QUETE 2
				with(player)
				{
					var _inst = instance_place(x, y, obj_watersource); //instance_place permet de récolter la valeur de  l'instance pour l'utiliser
					if (_inst != noone) //s'il y a collision...
					{
						with(_inst)
						{
							image_blend = c_fuchsia; 
								
							//Fin de la sub-quête et passage à la suivante
							_grid[# 1, _i] += 1;		show_debug_message("SUBQUEST ACHIEVED : QUEST.PAINT - 2");
							
							
						}
					}
				}
				break;
				
				case 3:
				break;
			}
			
		break;
		#endregion
		
		#region PICKUP ITEMS
		case(QUEST.PICKUP_ITEMS):
			
			switch(_grid[# 1, _i])	//Etat de la quête 
			{
				case -1:	break;	//QUETE NON PROPOSEE
				
				case 0:		
				
					with(player)
					{
						var _inst = instance_place(x, y, obj_mob); //instance_place permet de récolter la valeur de  l'instance pour l'utiliser
						if (_inst != noone) //s'il y a collision...
						{
							//Remplir l'array (dans le cas de Plantule, le seed pickup se fait avec un tableau)
							//array_push(global.item_array, 1);
							global.items++;
							show_debug_message("");
							
							with(_inst)
							{
								instance_destroy();
							
								//if(array_length(global.item_array) >= 10)
								if(global.items >= 10)
								{
								//Fin de la sub-quête et passage à la suivante
								_grid[# 1, _i] += 1;		show_debug_message("SUBQUEST ACHIEVED : QUEST.ITEMS - 0");
							
								
								}
							}
						}
					}
					
				break;
				
				case 1:
				
					with(player)
					{
						var _inst = instance_place(x, y, obj_pnj_parent); //instance_place permet de récolter la valeur de l'instance pour l'utiliser
						if (_inst != noone) //s'il y a collision...
						{
							global.item_array = [];
							
							next_subquest(_grid, _i);
						
						
						//	#region CLAMP
						//		var _stage = _grid[# 1, _i];
						//		var _stage_nb = array_length(_grid[# 2, _i])
						//		_stage = clamp(_stage, 0, _stage_nb - 1);
						//		//_grid[# 1, _i] = clamp(_grid[# 1, _i], 0, array_length(_grid[# 2, _i][_grid[# 1, _i]]));
						//	#endregion
							
						}
					}
					
				break;
				
			}
				
			
		break;
		#endregion
		
		#region KILL BOSS
		case(QUEST.KILL_BOSS):
			
			switch(_grid[# 1, _i])	//Etat de la quête 
			{
				case -1:	break;	//QUETE NON PROPOSEE
				
				case 0:		//Doit trouver l'épée
				
					with(player)
					{
						var _inst = instance_place(x, y, obj_weapon_sword); //instance_place permet de récolter la valeur de  l'instance pour l'utiliser
						if (_inst != noone) //s'il y a collision...
						{
							//Remplir l'array (dans le cas de Plantule, le seed pickup se fait avec un tableau)
							//array_push(global.item_array, 1);
							found_weapon = true;
							show_debug_message("");
							
							with(_inst)
							{
								instance_destroy();
						
								//Fin de la sub-quête et passage à la suivante
								_grid[# 1, _i] += 1;		show_debug_message("SUBQUEST ACHIEVED : QUEST.ITEMS - 0");
							
							}
						}
					}
					
				break;


				case 1:	//Doit trouver le monstre
				
					with(player)
					{
						var _inst = obj_enemy;
						if collision_circle(x, y, 80, _inst, false, false)
						//var _inst = instance_place(x, y, obj_enemy); //instance_place permet de récolter la valeur de  l'instance pour l'utiliser
						//if (_inst != noone) //s'il y a collision...
						{
							//Remplir l'array (dans le cas de Plantule, le seed pickup se fait avec un tableau)
							//array_push(global.item_array, 1);
							monster_killed = true;
							show_debug_message("");
						
								//Fin de la sub-quête et passage à la suivante
								_grid[# 1, _i] += 1;		show_debug_message("SUBQUEST ACHIEVED : QUEST.ITEMS - 0");
							
							
						}
					}
					
				break;
				
				
				case 2:	//Doit tuer le monstre
				
					with(player)
					{
						var _inst = instance_place(x, y, obj_enemy); //instance_place permet de récolter la valeur de  l'instance pour l'utiliser
						if (_inst != noone) //s'il y a collision...
						{
							//Remplir l'array (dans le cas de Plantule, le seed pickup se fait avec un tableau)
							//array_push(global.item_array, 1);
							monster_killed = true;
							show_debug_message("");
							
							with(_inst)
							{
								instance_destroy();
						
								//Fin de la sub-quête et passage à la suivante
								_grid[# 1, _i] += 1;		show_debug_message("SUBQUEST ACHIEVED : QUEST.ITEMS - 0");
							
							}
						}
					}
					
				break;
				
				case 3:	//Doit retourner parler au PNJ
				
					with(player)
					{
						var _inst = instance_place(x, y, obj_pnj); //instance_place permet de récolter la valeur de  l'instance pour l'utiliser
						if (_inst != noone) //s'il y a collision...
						{
							
							with(_inst)
							{
								image_blend = c_green;	
							}
						
							show_debug_message("");
							
							//Fin de la sub-quête et passage à la suivante
							_grid[# 1, _i] += 1;		show_debug_message("SUBQUEST ACHIEVED : QUEST.KILL_BOSS - 1");
						
						}
					}
					
				break;
				
			}
			
		break;
		#endregion
		
		//Ce systeme est pratique mais si on veut ajouter une sub-quest il faut décaler tous les case 1: , case 2: ,...!
		
		#region HYDRATE MEDOUCE
		case(QUEST.HYDRATE_MEDOUCE):
			
			switch(_grid[# 1, _i])	//Etat de la quête 
			{
				case -1:	break;	//QUETE NON PROPOSEE
				
				case 0:		//Doit porter la méduse
				
					with(player)
					{
						var _inst = instance_place(x, y, obj_meduse); //instance_place permet de récolter la valeur de  l'instance pour l'utiliser
						if (_inst != noone) //s'il y a collision...
						{
							//Porter la méduse
							show_debug_message("");
							
							with(_inst)
							{
								carried_by_player = true;
						
								//Fin de la sub-quête et passage à la suivante
								_grid[# 1, _i] += 1;	//show_debug_message("SUBQUEST " + string(_grid[# 1, _i]) + "ACHIEVED : QUEST.ITEMS - 0");
							}
						}
					}
					
				break;


				case 1:	//Ammener la méduse à une flaque d'eau
				
					with(player)
					{
						//var _inst = obj_flaque;
						//if collision_circle(x, y, 0, _inst, false, false)
						var _inst = instance_place(x, y, obj_flaque); //instance_place permet de récolter la valeur de l'instance pour l'utiliser
						if (_inst != noone) //s'il y a collision...
						{
							with(obj_meduse)
							{
								carried_by_player = false;
								var _len = distance_to_point(_inst.x, _inst.y);
							//	var _dir = point_direction(x, y, _inst.x, _inst.y);
							//	x += lengthdir_x(_len, _dir) * move_speed;
							//	y += lengthdir_y(_len, _dir) * move_speed;
								move_towards_point(_inst.x, _inst.y, move_speed);
								
								if (_len < 32)
								{
									move_speed = 0;
									show_debug_message("");
						
									//Fin de la sub-quête et passage à la suivante
									_grid[# 1, _i] += 1;		show_debug_message("SUBQUEST ACHIEVED : QUEST.ITEMS - 0");
								}
							}
						}
					}
					
				break;
				
			}
			
		break;
		#endregion
	*/

	}
	#endregion

	_i++;
}

#endregion


