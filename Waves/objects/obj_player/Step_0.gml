///@desc 

var _timespeed = 1;
fire_img_counter++;
num_of_fire_simultaneously_burning_player = [];

//if(global.pause == true){ image_speed = 0;	exit; }

#region PAUSE --> ALARMS FOOTSTEP & SOUNDS

	if(global.pause == true)
	{
		image_speed = 0;
		if(has_just_been_paused == false)
		{ 
			time_remaining_footstep		= alarm_get(0);		//On sauve le temps restant
			time_remaining_footsound	= alarm_get(1);
		}
		alarm[0]				= time_remaining_footstep;	//On incrémente l'alarme à l'infini pour ne pas l'activer
		alarm[1]				= time_remaining_footsound;
		has_just_been_paused	= true; 
		
		exit;
	}
	else
	{
		if(has_just_been_paused == true)
		{
			alarm[0]				= time_remaining_footstep;
			alarm[1]				= time_remaining_footsound;
			has_just_been_paused	= false;
		}
	}

#endregion


//if		soumis_aux_variations_du_temps == true	{	_timespeed = global.time_speed; }	//SI SOUMIS AUX VITESSES DU TEMPS
//else if soumis_aux_variations_du_temps == false {	_timespeed = 1; }	//Identique dans tous les cas

			leg_img_counter++;

			//Distance de chaque membre par rapport au centre horizontal (x).
			leg_esp_x	= (drop_ray / 2);
			leg_esp_y	= drop_ray - sqrt( sqr(drop_ray) - sqr(leg_esp_x) );
			arm_esp		= drop_ray;
			


#region MOVE STATES 

	if(move_state == PLAYER_MOVE_STATE.IDLE)
	{
		move_state_str	= "IDLE";
		sprite_index	= sprite_idle;
		arm				= arm_idle;
		leg				= leg_idle;
	}
	if(move_state == PLAYER_MOVE_STATE.MOVE)
	{
		move_state_str	= "MOVE";
		sprite_index	= sprite_move;
		arm				= arm_chill;
		leg				= leg_move;
		
		switch(dir)
			{
				case 0:		facing = FACING.RIGHT;		facing_str = "R";		image_xscale = scale;	break;
				case 45:	facing = FACING.UP_RIGHT;	facing_str = "UR";		image_xscale = scale;	break;
				case 90:	facing = FACING.UP;			facing_str = "U";		break;
				case 135:	facing = FACING.UP_LEFT;	facing_str = "UL";		image_xscale = -scale;	break;
				case 180:	facing = FACING.LEFT;		facing_str = "L";		image_xscale = -scale; 	break;
				case 225:	facing = FACING.DOWN_LEFT;	facing_str = "DL";		image_xscale = -scale; 	break;
				case 270:	facing = FACING.DOWN;		facing_str = "D";		break;
				case 315:	facing = FACING.DOWN_RIGHT;	facing_str = "DR";		image_xscale = scale;	break;
			}
	}

#endregion


#region HUMIDITY TRIGGERS

	if (humidity >= humidity_wet_min)
	{
		water_state = PLAYER_HUMIDITY.WET;	
	}
	else if (humidity < humidity_dry_min)
	{
		water_state = PLAYER_HUMIDITY.RAGE;	
	}
	else { water_state = PLAYER_HUMIDITY.DRY;  }

#endregion



#region SLEEP = TIME ACCELERATION
	
	if(water_state != PLAYER_HUMIDITY.RAGE) 
	{
		//Dormir : rester immobile près du PNJ_Ronflex_HOUR, et accélérer le temps.
		if(collision_circle(x, y, ray_action/2, obj_pnj_ronflex_hours, false, false))
	//	&& (input_keyboard_or_gamepad_check(global.key_absorbe, global.gp_absorbe))
		{
			face_img = face_img_sleep;
			
			time_speed_fast();
		}
		else	//Plus de collision
		{			
			time_speed_normal();
		}
	
		//Dormir : rester immobile près du PNJ_Ronflex_DAY, et INCREMENTER LES JOURS pour favoriser la croissance des plantes
		if(collision_circle(x, y, ray_action/2, obj_pnj_ronflex_days, false, false))
	//	&& (input_keyboard_or_gamepad_check(global.key_absorbe, global.gp_absorbe))
		{
	//		days_increment();
		}
		else	//Plus de collision
		{
	//		days_normal();
		}
	//	show_debug_message("___________________________");
	}

#endregion


	if(can_change_face_img == true){ face_img = face_img_neutral; } //Reset


#region HUMIDITY STATES

	if(water_state == PLAYER_HUMIDITY.DRY) || (water_state == PLAYER_HUMIDITY.WET)
	{	
		//Vitesse inversement proportionnelle à l'humidité (taille de la goutte), sauf en RAGE
		move_speed = lerp(move_speed_dry, move_speed_wet, humidity/100);
		
		
		
			#region C H A N G E M E N T   A L E A T O I R E   D ' E M P L A C E M E N T   S I   C O L L I S I O N

			//	if(avoid_others == true)	//FAIRE UN MEILLEUR SYSTEM DE COLLISIONS !
				{
					var _collision	= place_meeting(x, y, collisionnables);	//déviation sur y
					var _coll_horizontale	= place_meeting(x, y, collisionnables);	//déviation sur y
					var _coll_verticale		= place_meeting(x, y, collisionnables);	//déviation sur x
		
					var _remaining_loops = 1000;
					var _decalage_x = 1;	//20	//0.1
					var _decalage_y = 1;	//20	//0.1

					while(_collision == true) && (_remaining_loops > 0)
					{
						x = random_range(x - _decalage_x, x + _decalage_x);
						y = random_range(y - _decalage_y, y + _decalage_y);
						_remaining_loops -= 1;
					}
				}
	
			#endregion

				/*
				if(_coll_horizontale == true){
				//	while(_coll_horizontale == true){
						x += sign(move_x);
				//	}
				}
				if(move_y != 0){
					if(_coll_verticale == true){
						//while(_coll_verticale == true){
				//		if(place_meeting(x, y, collisionnables) == false){
							y += sign(move_y);
				//		}
					}
				}*/
	}


	if(water_state == PLAYER_HUMIDITY.WET) //Porte la droplet et peut éteindre le feu
	//Nouvelle version : la droplet peut disperser de l'eau, en dessous elle a toujours une bulle mais elle est sur ses réserves.
	{
		water_state_str		= "WET";	//show_debug_message("WET");
		can_be_controlled	= true;	
		color				= color_normal;	
				
			//Réinit	
			can_start_rage	= true;
			can_change_dir	= true;
			
			if(can_evaporate == true){ 	evaporation(); }
	}

	if(water_state == PLAYER_HUMIDITY.DRY)
	//Nouvelle version : la droplet n'est pas vraiment "sèche", mais elle ne peut pas splasher.
	{	
		water_state_str		= "DRY";	//show_debug_message("DRY");
		can_be_controlled	= true;
		face_img			= face_img_stress;
		
			//color				= color_normal;
			var _col_amt		= humidity/humidity_wet_min;
			//show_debug_message("h : " + string(humidity) + ", amt : " + string(_col_amt));
			color				= lerp(color_rage, color_normal, _col_amt);
		//	c_lerping_hue	= lerp(c_rage_hue, c_normal_hue, _col_amt);	
		//	c_lerping_val	= lerp(c_rage_val, c_normal_val, _col_amt);
		//	color			= make_color_hsv(c_lerping_hue, c_normal_sat, c_lerping_val);
		
		
			//Réinit
			can_start_rage	= true;
			can_change_dir	= true;		
			
			if(can_evaporate == true){ 	evaporation(); } //Also when dry, to "force" player to become enraged !	
	}
	
	if(water_state == PLAYER_HUMIDITY.RAGE)
	{
		//Augmenter la durée de la RAGE en fonction du nombre d'items détruits ? Ou de feu propagé ?
		water_state_str		= "RAGE";	//show_debug_message("RAGE");
		can_be_controlled	= true;
		color				= color_rage;
		face_img			= face_img_splash;
		
		
	//Début de la rage incontrôlée
		if(can_start_rage == true)
		{ 
			//show_message("can_start_rage !");
			player_rage_effects_start_step();
		
		 //Hypothèse du timer
			//alarm[8] = panic_duration;
			with(obj_c_gui) { event_perform(ev_alarm, 5); }	//Déclenche la montée de la rage_bar
			can_start_rage = false;
		}
	
	//Hypothèse de l'incrément
		humidity += rage_decay;		//show_debug_message("R A G E : humidity += rage_decay = " + string(humidity));
		if(humidity >= humidity_dry_min)
		{
			event_perform(ev_alarm, 8);	
		}
		
	//Vibrations
		gamepad_vibration_on(0, rage_vibration_amount);
		rage_vibration_amount -= rage_vibration_decay;
		
		
					//PROPAGATION DU FEU
				//	if(instance_exists(personal_fire) == true)
					{
				//		personal_fire.x = x;
				//		personal_fire.y = y;
					}
						
					//Mini feux	
						//if(instance_exists(_personal_fire) == false)
						if(collision_circle(x, y, 32, obj_fire_small, false, true) == noone)
						{
						//		var _personal_fire = instance_create_layer(x, y, "Instances", obj_fire_small);
						//		_personal_fire.x = x;
						//		_personal_fire.y = y;
						}	
					//EFFECT au sol
							intense_sparkling_on_object(obj_player, layer, obj_effect_scintillement, 0.1);
							//var _inst = instance_create_layer(x, y, "Instances", obj_effect_scintillement);
							//_inst.image_blend = merge_color(COL.RED, COL.ORANGE, random(1));
							//_inst.image_blend = COL.ORANGE;
							
					
		
		
			if( move_x != 0 || move_y != 0 )
			{
				var _r = 2; 
				var _randx = irandom_range(-_r, _r);
				var _randy = irandom_range(-_r, _r);
				var _trace = instance_create_layer(x + _randx, y + _randy, layer, obj_effect_new_seed);
			}



		#region MOUVEMENT INCONTROLE
		
			//Vitesse décroissante
			//move_speed_rage -= move_speed_rage_decay;
			
			//	move_x = sin(0.005 * current_time) * 10;
			//	move_y = sin(0.007 * current_time) * 20;


			if(can_change_dir == true){ alarm[7] = can_change_dir_timer; can_change_dir = false; }
		
			move_x = lengthdir_x(move_speed_rage, dir);
			move_y = lengthdir_y(move_speed_rage, dir);
		//	move_x += sin(0.005 * current_time) * 1;
		//	move_y += sin(0.005 * current_time) * 1;
		
			#region COLLISIONS
				var _coll_hor	= place_meeting(x + move_x, y, collisionnables);	//déviation sur y
				var _coll_ver	= place_meeting(x, y + move_y, collisionnables);	//déviation sur x
				//var _coll_hor	= place_meeting(x + move_x, y, collisionnables) || place_meeting(x, y, collisionnables);
				//var _coll_ver		= place_meeting(x, y + move_y, collisionnables) || place_meeting(x, y, collisionnables);
				
				if(move_x != 0)
				{
					if(_coll_hor == true)
					{
						if(place_meeting(x + move_x, y, collisionnables) == false)	//...si pas de collision devant...
						{
						//	x += sign(move_x); 			//...on avance d'un pixel.
						}	
						alarm[7] = 1;
					//	move_x = 0;						//...sinon on s'arrête.
					}
				}

				if(move_y != 0)
				{
					if(_coll_ver == true)
					{
						if(place_meeting(x, y + move_y, collisionnables) == false)	//...si pas de collision devant...
						{
						//	y += sign(move_y); 			//...on avance d'un pixel.
						}
						alarm[7] = 1;
					//	move_y = 0;						//...sinon on s'arrête.
					}
				}
		
			#endregion

			x += move_x;	//? attention aux collision quand retour à normal !
			y += move_y;
			
		#endregion
	}

#endregion


#region DROPLET // humidity
	
	humidity = clamp(humidity, rage_max, humidity_max);

#endregion 



#region MOVE

	if(global.pause == false) && (can_be_controlled == true) && (can_move == true)
	{
		
		#region INPUTS GAMEPAD / MANETTE
	
			if gamepad_exists()	 //S'il y a un joystick connecté...
			{
				var _manette = global.gamepads[0];
	
				//INPUTS
				//MOVE X ET Y EN FONCTION DU JOYSTICK GAUCHE
				var _h = gamepad_axis_value(_manette, gp_axislh);
				var _v = gamepad_axis_value(_manette, gp_axislv);
		
				//APPLICATION DU MOUVEMENT
				//L'utilisation des joysticks calcule lengthdir_x et y automatiquement, pas besoin de dir.
				move_x = _h * move_speed;	
				move_y = _v * move_speed;
		
				x += move_x;
				y += move_y;
		
				//Utile pour calculer le facing et les sprites quand même.
				var _input_moving = (_h != 0) or (_v != 0);
				if(_input_moving == true) { dir = point_direction(0, 0, _h, _v); }
				//show_debug_message("PLAYER gamepad _h : " + string(_h) + "  _v : " + string(_v) + "  dir : " + string(dir));

				
					if(move_x == 0) && (move_y == 0){	move_state = PLAYER_MOVE_STATE.IDLE; }
					if(move_x != 0) || (move_y != 0){ 	move_state = PLAYER_MOVE_STATE.MOVE; }
	
				#region FACING (découpage du cercle trigo en 8 directions)
	
				//	switch_facing_in_function_of_dir(false);
			
					if(_input_moving == true)
					{
				//		switch_sprites_in_function_of_facing(true);	//MOVE
					}
					else 
					{
				//		switch_sprites_in_function_of_facing(false);	//IDLE
					}
		
				#endregion
			}

		#endregion

		#region KEYBOARD
		
			//INPUTS
			var _input_r = keyboard_check(global.key_r);
			var _input_l = keyboard_check(global.key_l);
			var _input_u = keyboard_check(global.key_u);
			var _input_d = keyboard_check(global.key_d);
		
			var _input_x = _input_r - _input_l;
			var _input_y = _input_d - _input_u;
		
		#endregion
		
		//move_x = _input_x;
		//move_y = _input_y;
		move_x = 0;
		move_y = 0;
		
		//FIXING DIAGONAL ABBERATION 
		if(_input_x != 0 || _input_y != 0)	//Otherwise will move right
		{	
			//DIRECTION (angle alpha Pythagore)
			dir = point_direction(0, 0, _input_x, _input_y);
			//x1 et y1 pourraient == x,y et x2, y2 aux inputs + position
			//mais comme c'est une DIRECTION autant prendre l'origine 0,0.

			//COMPOSANTES DU VECTEUR DIRECTION
			move_x = lengthdir_x(move_speed, dir);
			move_y = lengthdir_y(move_speed, dir);
			//Pour créer des states facing up down right left (utile en début de room par exemple)
			//https://youtu.be/hB8jBj6itUA?si=A3BTUaqyOhP_6lLO&t=1544
		
		#region COLLISIONS AVEC TUILES ET OBJETS :-)
		
		//var _coll_horizontale	= place_meeting(x + lengthdir_x(speed, direction), y, collisionnables);	//déviation sur y
		//var _coll_verticale	= place_meeting(x, y + lengthdir_y(speed, direction), collisionnables);	//déviation sur x
		var _coll_horizontale	= place_meeting(x + move_x, y, collisionnables);	//déviation sur y
		var _coll_verticale		= place_meeting(x, y + move_y, collisionnables);	//déviation sur x
			
		//HORIZONTAL
		if(move_x != 0)	//Si on bouge sur x
		{
			if _coll_horizontale
			//if(place_meeting(x + max(1, move_x), y, collisionnables))	//Si collision anticipée au prochain déplacement à la vitesse move_speed...
			{
				//repeat(abs(move_x))					//Pour le nombre de fois (valeur absolue) que de pixel voulus de déplacement...
				{
					//if(!place_meeting(x + sign(move_x), y, collisionnables))
					if(!place_meeting(x + move_x, y, collisionnables))	//...si pas de collision devant...
					{
						x += sign(move_x); 			//...on avance d'un pixel.
					}
					//else { break; }
				}		
				move_x = 0;							//...sinon on s'arrête.
			}
		}

		//VERTICAL
		if(move_y != 0)	//Si on bouge sur y
		{
			if _coll_verticale
			//if(place_meeting(x, y + max(1, move_y), collisionnables))	//Si collision anticipée au prochain déplacement à la vitesse move_speed...
			{
				//repeat(abs(move_y))					//Pour le nombre de fois (valeur absolue) que de pixel voulus de déplacement...
				{
					//if(!place_meeting(x, y + sign(move_y), collisionnables))	//...si pas de collision devant...
					if(!place_meeting(x, y + move_y, collisionnables))	//...si pas de collision devant...
					{
						y += sign(move_y); 			//...on avance d'un pixel.
					}
					//else { break; }
				}
				move_y = 0;							//...sinon on s'arrête.
			}
		}
		
	#endregion
	
	
		//floor ou ceil permettraient de fixer sur la résolution du jeu... mais avec * global.time_speed, ça bug
		//x += ceil(move_x * move_speed * global.time_speed);
		//y += ceil(move_y * move_speed * global.time_speed);
		x += move_x * move_speed * _timespeed;
		y += move_y * move_speed * _timespeed;

		//x = floor( lerp(x, x + (move_x * move_speed), reactivite));
		//y = floor( lerp(y, y + (move_y * move_speed), reactivite));
		
		}
	}
	
		#region FACING (un peu optionnel)
			
			//switch(dir)
			{
			//	case 0:		facing = FACING.RIGHT;		facing_str = "R";		image_xscale = scale;	break;
			//	case 45:	facing = FACING.UP_RIGHT;	facing_str = "UR";		image_xscale = scale;	break;
			//	case 90:	facing = FACING.UP;			facing_str = "U";		break;
			//	case 135:	facing = FACING.UP_LEFT;	facing_str = "UL";		image_xscale = -scale;	break;
			//	case 180:	facing = FACING.LEFT;		facing_str = "L";		image_xscale = -scale; 	break;
			//	case 225:	facing = FACING.DOWN_LEFT;	facing_str = "DL";		image_xscale = -scale; 	break;
			//	case 270:	facing = FACING.DOWN;		facing_str = "D";		break;
			//	case 315:	facing = FACING.DOWN_RIGHT;	facing_str = "DR";		image_xscale = scale;	break;
			}
			//show_debug_message("Facing : " + string(str));
			
		#endregion
	
	var _marg_x = 10;
	var _marg_y = 16;
	//if(room == rm_start)
	{
	//	x = clamp(x, 640 + _marg_x, global.room_w - _marg_x);
	//	y = clamp(y, 0 + _marg_y, global.room_h - _marg_y);	
	}
	//else
	{
		x = clamp(x, 0 + _marg_x, global.room_w - _marg_x);
		y = clamp(y, 0 + _marg_y, global.room_h - _marg_y);
	}
	
	
	
	if(move_x == 0) && (move_y == 0){	move_state = PLAYER_MOVE_STATE.IDLE; }
	if(move_x != 0) || (move_y != 0){ 	move_state = PLAYER_MOVE_STATE.MOVE; }
	
	
#endregion


#region FACE EXPRESSION


	if(global.time_acceleration == true) && (move_x == 0) && (move_y == 0)
	{
		face_img = face_img_sleep;	//Sleeping
	}

#endregion


#region SPLASH = ECLABOUSSER

	if(input_keyboard_or_gamepad_check_pressed(global.key_splash, global.gp_splash))
	{
		if(water_state == PLAYER_HUMIDITY.WET)
		{
			//Eclabousse et perd un peu d'eau
				splash_droplets_num = irandom_range(splash_droplets_num_min, splash_droplets_num_max);
				repeat(splash_droplets_num)
				{
					instance_create_depth(drop_x, drop_y, depth, obj_splash);
				}
				humidity -= splash_humidity_loss;
				//show_debug_message(" s p l a s h  ! " + string(splash_droplets_num) + " * " + string(splash_humidity_loss));
			
			//Droplet facial expression
			//	arm					= arm_dance;
				face_img			= face_img_splash;
				alarm[2]			= 10; //ici pas besoin de if(can_change_face_img) car ça se passe en 1 frame (check_pressed)
				can_change_face_img = false;
				
			//Sound
			with(obj_c_music)
			{
				sound_splash_gain		= random_range(0.1, 0.2);
				sound_splash_pitch		= random_range(0.8, 1.2);
				audio_play_sound(sound_splash, 1, false, sound_splash_gain, 0, sound_splash_pitch);
			}
		}
		if(water_state == PLAYER_HUMIDITY.DRY)
		{
			//Secoue simplement les branches ?	
		}
	}

#endregion


	//Gouttelette proportionnelle à la quantité d'eau absorbée
	//	if(water_state == PLAYER_HUMIDITY.WET)
		{
			drop_ray = lerp(drop_ray_min, drop_ray_max, humidity/100);
		}
	//	else { drop_ray = drop_ray_min; }
		drop_ray = clamp(drop_ray, drop_ray_min, drop_ray_max);
	
	
	//We can also drink in the water tilemap
		if(place_meeting(x, y, tilemap_water) == true)
		{
			event_user(4);
		}



if(collision_circle(x, y, ray_action * 2, obj_teleport, false, false) == true)
{
	with(obj_teleport)
	{
		//Indication de direction
		show_indicator = true;	
	}
}
else
{
	with(obj_teleport)
	{
		//Indication de direction
	//	show_indicator = false;	
	}
}

	
	//Actualisation de valeurs
	//Droplet = Goutte d'eau portée lorsque HUMIDITY.WET
		drop_x		= x;
		//drop_y	= y - head_y;
		//drop_y	= y - head_y - drop_ray;
		drop_y		= y - drop_ray - leg_h + 4
		//Ces valeurs pourraient osciller doucement
		drop_rayx	= drop_ray + sin(drop_ray_amp * current_time) * drop_ray_per;
		drop_rayy	= drop_ray - sin(drop_ray_amp * current_time) * drop_ray_per;



