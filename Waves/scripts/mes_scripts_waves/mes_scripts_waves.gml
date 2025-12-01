
#region //////////////////////////// HUMIDITY EFFECTS

	///@desc HEATWAVES. ABSORPTION (humidity += _speed)
	///@arg _speed Absorption speed. (Défaut : absorption_speed)
	function water_absorption(_speed = absorption_speed)
	{	
		if(global.pause == false){ humidity += _speed; }
	}
	
	///@desc HEATWAVES. WATERING PLANT (humidity -= _speed)
	///@arg _speed Watering speed. (Défaut : watering_speed)
	function watering(_speed = watering_speed)
	{
		//Diminution proportionnelle au NOMBRE de plantes ? ou au TEMPS passé à leurs contacts ?
		if(global.pause == false){	humidity -= _speed; }
	}
	
	///@desc HEATWAVES. BURNING (humidity -= _speed)
	///@arg _speed Burning speed. (Défaut : burning_speed)
	function burning(_speed = burning_speed)
	{
		if(global.pause == false){	humidity -= _speed; }
			
		//Effet "hit" ?	
		//with(obj_c_camera){ shake_camera = true; }
	}
	
	
	///@desc HEATWAVES. Modifie le taux d'évaporation par frame, selon la phase de la journée.
	///@desc (Fonctionne avec obj_c_cycle_day_night). Utilisable par n'importe quel obj ayant un taux d'humidity (player, flore).
	///@arg _speed_init Evaporation speed init. (Défaut : evaporation_speed_init)
	function evaporation(_speed_init = evaporation_speed_init)
	{
		if(global.pause == false) //&& (global.time_acceleration == false)
	//	&& (obj_c_gui.state != UI.START) && (obj_c_gui.state != UI.MENU) 
		{
			if(instance_exists(obj_c_cycle_day_night))
			{
			//	if(obj_c_cycle_day_night.state != TIME.ACCELERATED)
				{
					switch(obj_c_cycle_day_night.phase)	//Modification en fonction du moment de la journée
					{
						case "Night":
							evaporation_speed = 0;						break;

						case "Sunrise":
						//	evaporation_speed = -1 * _speed_init/2;		break;	//Morning dew (rosée du matin)
							evaporation_speed = 0;						break;
						
						case "Sunset":
							//humidity -= evaporation_speed/2;
							evaporation_speed = _speed_init/2;			break;
				
						case "Day":
							//humidity -= evaporation_speed;
							evaporation_speed = _speed_init;			break;
					}
				}
			}
			humidity -= evaporation_speed;
			
			if(object_index == obj_player){
			show_debug_message(string(object_get_name(object_index)) + " : evaporation() > evaporation_speed : " + string(evaporation_speed));
			}
		}	
	}

#endregion



///@arg {real} _proba Probability (chances = 1 / _proba). Défaut : 10
function flore_sparkling_if_well_hydrated(_proba = 10)
{
	if(humidity >= humidity_max - 10)
	{
		//	intense_sparkling_on_object(obj_flore_parent, "Instances", obj_effect_new_seed, 1, 0, 0, 0, COL.YGREEN, 8);	//trop intense
		var _hasard = irandom(_proba);
		if(_hasard == 0)
		{
			intense_sparkling_on_object(obj_flore_parent, "Instances", obj_effect_new_seed, 2, 0, 0, 0, COL.YGREEN, 8);
		}
	}
}



	///@desc PLAYER : Collision with plant. Met le feu à l'objet en argument.
	///@arg _plant_to_set_in_fire Plante à incendier. (Défaut : other)
	function set_fire(_plant_to_set_in_fire = other)
	{
		//_plant_to_set_in_fire.plant_state = FIRE_STATE.BURNING;
		_plant_to_set_in_fire.humidity = 0;
	}


#region RAGE EFFECTS

	///@desc Screen shake (+ gamepad vibration dans le cas d'une vibration constante)
	function player_rage_effects_start_step()
	{
		//if(global.pause == false)
		{
			humidity = rage_max;
		}
		
		with(obj_c_camera)
		{
		//	shake_camera		= true;	//warning epilepsy...
			can_shake_camera	= false;
			//Durée indéterminée (c'est can_shake_camera qui permet à obj_camera d'activer l'alarme de fin).
		}
		//Je ne mets pas ça ici car j'ai besoin d'actualiser amount pour faire une vibration décroissante.
		//gamepad_vibration_on(0, rage_vibration_amount, rage_vibration_amount, panic_duration);

		//FEU PERSONNEL QUI SUIT PLAYER
		//	instance_activate_object(personal_fire);	//Activer : dans STEP, le faire suivre Player
	}


	///@desc A placer dans l'ALARM de fin de Rage. 
	function player_rage_effects_end()
{
	with(obj_c_camera)
	{
		shake_camera		= false;
		can_shake_camera	= true;
	}
	gamepad_vibrations_off();
	rage_vibration_amount	= rage_vibration_amount_init; //Réinit
	
	
	//FEU PERSONNEL QUI SUIT PLAYER
	//	instance_deactivate_object(personal_fire);	//Désactiver
	//	personal_fire.x = -500;						//hide
	//	personal_fire.y = -500;
}

#endregion

///@desc When water touches fire.
///@arg {real} _ybuff Décalage vertical (en fonction du sprite idéalement) Défaut : -16
function fire_effects_evaporation(_ybuff = -16)
{
	var _x = x;
	var _y = y - _ybuff;
	var _smoke = instance_create_layer(_x, _y, "Instances", obj_effect_evaporation);

	with(obj_c_music)
	{
		sound_evaporation_gain		= random_range(0.05, 0.1);
		sound_evaporation_pitch		= random_range(0.8, 1.2);
		audio_play_sound(sound_evaporation, 1, false, sound_evaporation_gain, 0, sound_evaporation_pitch);
	}
}

///@desc When Player is almost totally dehydrated (DRY state).
///@arg {real} _ybuff Décalage vertical (en fonction du sprite idéalement) Défaut : -16
///@arg {real} _rand Marge de décalage aléatoire possible en x et y. Défaut : 8
function player_effects_evaporation(_ybuff = -16, _rand = 8)
{
	var _x = x + random_range(- _rand, _rand);;
	var _y = y - _ybuff + random_range(- _rand, _rand);
	var _smoke = instance_create_layer(_x, _y, "Instances", obj_effect_evaporation);

	with(obj_c_music)
	{
		sound_player_dehydration_gain		= random_range(0.05, 0.1);
		sound_player_dehydration_pitch		= random_range(0.8, 1.2);
		if(audio_is_playing(sound_player_dehydration) == false){
		audio_play_sound(sound_player_dehydration, 1, false, sound_player_dehydration_gain, 0, sound_player_dehydration_pitch);
		}
	}
}


#region DESTRUCTION

	///////BREAK THINGS WHEN IN RAGE
	function break_plant_effect()
	{
		//PARTICLES
			var _r = random_range(-12, 12);
			var _x = x + _r;
			var _y = y + _r;
	
			//Au niveau du tronc
			var _rd = irandom(20);
			if(_rd == 0){
				repeat(irandom(3)){
					var _trunk = instance_create_layer(_x, _y - 16, "Instances", obj_effect_broken_piece);
						_trunk.image_blend = merge_color(c_red, c_black, 0.5);
				}
			}	
			//Au niveau de la canopée
			_rd = irandom(10);
			if(_rd == 0){
				repeat(irandom(3)){
					var _h = random_range(64, 16);
					var _leaves = instance_create_layer(_x, _y - _h, "Instances", obj_effect_broken_piece);
						_leaves.image_blend = merge_color(c_green, color, 0.6);
				}
				//Sound
				with(obj_c_music)
				{
					s = irandom(array_length(sounds_wood_crack) - 1);
					sound_wood_crack = sounds_wood_crack[s];
					sound_wood_crack_gain = random_range(0.1, 0.2);
					sound_wood_crack_pitch = random_range(0.8, 1.2);
					if(audio_is_playing(sound_wood_crack) == false){ audio_play_sound(sound_wood_crack, 1, false, sound_wood_crack_gain, 0, sound_wood_crack_pitch); }
				}
			}	
	}

	function break_object_effect(_color)
	{
			//PARTICLES
			var _r = random_range(-12, 12);
			var _x = x + _r;
			var _y = y + _r;
	
			//Au milieu du sprite
			var _rd = irandom(10);
			if(_rd == 0){
				repeat(irandom(5)){	
					var _particle = instance_create_layer(_x, _y - 16, "Instances", obj_effect_broken_piece);
						_particle.image_blend = _color;
				}
				//Sound
				with(obj_c_music)
				{
					s = irandom(array_length(sounds_rock_crack) - 1);
					sound_rock_crack		= sounds_rock_crack[s];
					sound_rock_crack_gain	= random_range(0.3, 0.4);
					sound_rock_crack_pitch	= random_range(0.8, 1.2);
					if(audio_is_playing(sound_rock_crack) == false){ audio_play_sound(sound_rock_crack, 1, false, sound_rock_crack_gain, 0, sound_rock_crack_pitch); }
				}
			}	
	}


	///@desc Called by rocks when destroyed.
	function destroy_rock_effect(_color = image_blend)
	{
			//PARTICLES
			var _sprite_w = sprite_width;
			var _r = random_range(-_sprite_w/2, _sprite_w/2);
			var _x = x + _r;
			var _y = y + _r;
	
			repeat(irandom_range(5, 12))
			{	
				var _particle = instance_create_layer(_x, _y - 16, "Instances", obj_effect_broken_rock);
					_particle.image_blend = _color;
			}
	}

#endregion

#region TIME CONTROL (CYCLE DAY NIGHT)

	///@desc PLAYER > STEP. Appelle CYCLE_DAY_NIGHT. Accélère le temps et passe de time_increment à time_increment_max.
	function time_speed_fast()
	{
		with(obj_c_cycle_day_night)
		{
			if(can_accelerate_time == true)
			{
				show_debug_message("time_speed_fast() : t = " + string(time_increment));
			//	event_user(7);	
			//	time_increment		= time_increment_max;	//ACCELERATION
				can_accelerate_time = false;
				state				= TIME.ACCELERATED;
				
				global.time_acceleration = true;
			}
		}
		//Effets autour de player + ronflex
		intense_sparkling_on_object(obj_player, "Instances", obj_effect_sparkle);
	}

	///@desc PLAYER > STEP. Appelle CYCLE_DAY_NIGHT. Remet le temps à la vitesse normale, et passe de time_increment à time_increment_init.
	function time_speed_normal()
	{
		with(obj_c_cycle_day_night)
		{
		//	if(can_accelerate_time == false)
			{
				show_debug_message("time_speed_normal() : t = " + string(time_increment));
			//	event_user(7);	
			//	time_increment		= time_increment_init;	//RETOUR A LA NORMALE
				can_accelerate_time = true;
				state				= TIME.NORMAL;
				
				global.time_acceleration = false;
			}
		}
	}


	///@desc PLAYER > STEP. Appelle CYCLE_DAY_NIGHT. Accélère le temps et passe de time_increment à time_increment_max.
	function days_increment()
	{
		with(obj_c_cycle_day_night)
		{
			if(can_accelerate_time == true)
			{
				show_debug_message("days_increment() : day ++");
				event_user(1);	
			//	state				= TIME.ACCELERATED;
				can_accelerate_time = false;
			}
		}
		//Effets autour de player + ronflex
		intense_sparkling_on_object(obj_player, "Instances", obj_effect_sparkle);
	}
	
	///@desc PLAYER > STEP. Appelle CYCLE_DAY_NIGHT. Remet le temps à la vitesse normale, et passe de time_increment à time_increment_init.
	function days_normal()
	{
		with(obj_c_cycle_day_night)
		{
			if(can_accelerate_time == false)
			{
				show_debug_message("days_normal()");
			//	state				= TIME.NORMAL;
				can_accelerate_time = true;
			}
		}
	}
	
#endregion

////////////////////////////////////
function create_fire()
{
	var _x = obj_spawn_fire.x;
	var _y = obj_spawn_fire.y;
	instance_create_layer(_x, _y, layer, obj_part_fire);
}

	
	//Ne fonctionne pas ......
	///@desc Fonction qui commande à obj_c_camera de shaker l'écran (+/- _amount pixels), pour la durée _duration.
	///@arg {real}	_amount_px Quantité de pixels de débordement. (Défaut : 3)
	///@arg {real}	_duration Durée, en secondes (sera multiplié par global.game_speed). (Défaut : 0.2)
	function shake_camera_shortly(_amount_px = 3, _duration = 0.2)
	{		
		var _duration_time = _duration * global.game_speed;
		
		if(global.pause == false)
		{
			if(instance_exists(obj_c_camera) == true)
			{
				with(obj_c_camera)
				{
					//Remue les coordonnées de la caméra de manière aléatoire
					var _shake_x = cx + random_range(-_amount_px, _amount_px);
					var _shake_y = cy + random_range(-_amount_px, _amount_px);
					camera_set_view_pos(cam, _shake_x, _shake_y); 
		
					//Courte durée
					if(can_shake_camera == true){ alarm[1] = _duration_time; can_shake_camera = false; }
				}
			}
		}		
	}


#region GUI

	//Return true if a certain input has been made
	function input_to_shortcut_cinematic()
	{
		if (input_keyboard_or_gamepad_check_pressed(global.key_absorbe, global.gp_absorbe) == true)
		|| (input_keyboard_or_gamepad_check_pressed(global.key_pause, global.gp_pause) == true)
		|| (keyboard_check_pressed(global.key_absorbe) == true)
		|| (keyboard_check_pressed(global.key_pause) == true)
		{
			//show_message("SHORTCUT");
			return true; 
		}
		else { return false; }
	}
	
#endregion
	
	