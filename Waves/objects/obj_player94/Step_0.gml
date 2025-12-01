///@desc 

	
if(global.pause == true){ image_speed = 0;	exit; }

var _timespeed = 1;
//if		soumis_aux_variations_du_temps == true	{	_timespeed = global.time_speed; }	//SI SOUMIS AUX VITESSES DU TEMPS
//else if soumis_aux_variations_du_temps == false {	_timespeed = 1; }	//Identique dans tous les cas


			leg_img_counter++;

			//Distance de chaque membre par rapport au centre horizontal (x).
			leg_esp_x	= (drop_ray / 2);
			leg_esp_y	= drop_ray - sqrt( sqr(drop_ray) - sqr(leg_esp_x) );
			arm_esp		= drop_ray;
			
			
move_speed = lerp(move_speed_dry, move_speed_wet, humidity/100);





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

	if (humidity > 10)
	{
		water_state = PLAYER_HUMIDITY.WET;	
	}
	else if (humidity <= - resistance) //10 étant la "résistance au feu"
	{
		water_state = PLAYER_HUMIDITY.RAGE;	
	}
	else { water_state = PLAYER_HUMIDITY.DRY;  }

#endregion


#region HUMIDITY STATES

	if(water_state == PLAYER_HUMIDITY.DRY)
	//Nouvelle version : la droplet n'est pas vraiment "sèche", mais elle ne peut pas splasher.
	{	
		water_state_str		= "DRY";	//show_debug_message("DRY");
		color				= color_normal;
		can_be_controlled	= true;
		
			//Réinit
			can_set_endrage_alarm	= true;
			can_change_dir			= true;
	}
	
	
	if(water_state == PLAYER_HUMIDITY.WET) //Porte la droplet et peut éteindre le feu
	//Nouvelle version : la droplet peut disperser de l'eau, en dessous elle a toujours une bulle mais elle est sur ses réserves.
	{
		water_state_str		= "WET";	//show_debug_message("WET");
		color				= color_normal;
		can_be_controlled	= true;		
		
			//Réinit	
			can_set_endrage_alarm	= true;
			can_change_dir			= true;
			
		evaporation();
	}
	
	
	if(water_state == PLAYER_HUMIDITY.RAGE)
	{
		//Augmenter la durée de la RAGE en fonction du nombre d'items détruits ? Ou de feu propagé ?
		water_state_str		= "RAGE";	//show_debug_message("RAGE");
		color				= color_rage;
		
		face_img			= 2;
		
		can_be_controlled	= true;
		
					
		//Durée limitée de la rage incontrôlée
		if(can_set_endrage_alarm == true)
		{ 
			player_rage_effects_step();
			
			alarm[8] = panic_duration; 
			with(obj_c_gui) { event_perform(ev_alarm, 5); }	//Déclenche la montée de la rage_bar
			can_set_endrage_alarm = false;
		}
		
		gamepad_vibration_on(0, rage_vibration_amount);
		rage_vibration_amount -= rage_vibration_decay;
		
		
					//PROPAGATION DU FEU
						personal_fire.x = x;
						personal_fire.y = y;
						
					//Mini feux	
						//if(instance_exists(_personal_fire) == false)
						if(collision_circle(x, y, 32, obj_fire_small, false, true) == noone)
						{
								var _personal_fire = instance_create_layer(x, y, "Instances", obj_fire_small);
						//		_personal_fire.x = x;
						//		_personal_fire.y = y;
						}	
					//EFFECT au sol
							intense_sparkling_on_object(obj_player, layer, obj_effect_scintillement, 0.1);
							//var _inst = instance_create_layer(x, y, "Instances", obj_effect_scintillement);
							//_inst.image_blend = merge_color(COL.RED, COL.ORANGE, random(1));
							//_inst.image_blend = COL.ORANGE;
							
					
		
		
		//	if ( move_x != 0 || move_y != 0 )
			{
				var _r = 2; 
				var _randx = irandom_range(-_r, _r);
				var _randy = irandom_range(-_r, _r);
				var _trace = instance_create_layer(x + _randx, y + _randy, layer, obj_trainee_point);
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

			x += move_x;
			y += move_y;
			
		#endregion
	}



#endregion


#region DROPLET // humidity
	
	humidity = clamp(humidity, humidity_min, humidity_max);

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
	if(room == rm_map_medium){
		x = clamp(x, 640 + _marg_x, global.room_w - _marg_x);
		y = clamp(y, 0 + _marg_y, global.room_h - _marg_y);	
	}
	else
	{
		x = clamp(x, 0 + _marg_x, global.room_w - _marg_x);
		y = clamp(y, 0 + _marg_y, global.room_h - _marg_y);
	}
	
	
	
	if(move_x == 0) && (move_y == 0){	move_state = PLAYER_MOVE_STATE.IDLE; }
	if(move_x != 0) || (move_y != 0){ 	move_state = PLAYER_MOVE_STATE.MOVE; }
	
	
#endregion


if(can_change_face_img == true){ face_img = 0; }


#region SPLASH = ECLABOUSSER

	if(input_keyboard_or_gamepad_check_pressed(global.key_splash, global.gp_splash))
	{
		if(water_state == PLAYER_HUMIDITY.WET)
		{
			//Eclabousse et perd un peu d'eau
				splash_droplets_num = irandom_range(40, 50);
				repeat(splash_droplets_num)
				{
					instance_create_depth(drop_x, drop_y, depth, obj_splash);
				}
				humidity -= splash_humidity_loss;
				
				show_debug_message(" s p l a s h  ! " + string(splash_droplets_num) + " * " + string(splash_humidity_loss));
			
			
			//Droplet facial expression
				arm					= arm_dance;
				face_img			= 2;
				alarm[2]			= 10; //ici pas besoin de if(can_change_face_img) car ça se passe en 1 frame (check_pressed)
				can_change_face_img = false;
		}
		if(water_state == PLAYER_HUMIDITY.DRY)
		{
			//Secoue simplement les branches ?	
		}
	}

#endregion


#region SLEEP = TIME ACCELERATION

	
	if(water_state != PLAYER_HUMIDITY.RAGE) 
	{
		//Dormir : rester immobile près du PNJ_Ronflex_HOUR, et accélérer le temps.
		if(collision_circle(x, y, ray_action/2, obj_pnj_ronflex_hours, false, false))
		&& (input_keyboard_or_gamepad_check(global.key_absorbe, global.gp_absorbe))
		{
			time_speed_fast();
		}
		else	//Plus de collision
		{
			time_speed_normal();
		}
	
		//Dormir : rester immobile près du PNJ_Ronflex_DAY, et INCREMENTER LES JOURS pour favoriser la croissance des plantes
		if(collision_circle(x, y, ray_action/2, obj_pnj_ronflex_days, false, false))
		&& (input_keyboard_or_gamepad_check(global.key_absorbe, global.gp_absorbe))
		{
			days_increment();
		}
		else	//Plus de collision
		{
			days_normal();
		}
		show_debug_message("___________________________");
	}


#endregion


	//Gouttelette proportionnelle à la quantité d'eau absorbée
		if(water_state == PLAYER_HUMIDITY.WET)
		{
	drop_ray = lerp(drop_ray_min, drop_ray_max, humidity/100);
		}
		else { drop_ray = drop_ray_min; }
	drop_ray = clamp(drop_ray, drop_ray_min, drop_ray_max);
	
	
	
	//Actualisation de valeurs
	//Droplet = Goutte d'eau portée lorsque HUMIDITY.WET
		drop_x		= x;
		//drop_y	= y - head_y;
		//drop_y	= y - head_y - drop_ray;
		drop_y		= y - drop_ray - leg_h + 4
		//Ces valeurs pourraient osciller doucement
		drop_rayx	= drop_ray + sin(drop_ray_amp * current_time) * drop_ray_per;
		drop_rayy	= drop_ray - sin(drop_ray_amp * current_time) * drop_ray_per;



