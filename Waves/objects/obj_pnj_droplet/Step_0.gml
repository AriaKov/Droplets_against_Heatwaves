///@desc 

	mx = display_mouse_get_x();
	my = display_mouse_get_y();
	
	
	leg_img_counter++;
	
		humidity = clamp(humidity, humidity_dry_min, humidity_max);
		
		if(humidity <= humidity_dry_min){ instance_destroy(); }	//DESTROY & METAMORPHOSE
			
			
		//Gouttelette proportionnelle à la quantité d'eau absorbée
		drop_ray = lerp(drop_ray_min, drop_ray_max, humidity/100);
		drop_ray = clamp(drop_ray, drop_ray_min, drop_ray_max);
		
		drop_y		= y - drop_ray - leg_h + 4
		
			//Distance de chaque membre par rapport au centre horizontal (x).
			leg_esp		= (drop_ray / 2) - 2;	//En fonction de la taille de la goutelette :)
			arm_esp		= drop_ray;
			
			//Distance de chaque membre par rapport au centre horizontal (x).
			leg_esp_x	= (drop_ray / 2);
			leg_esp_y	= drop_ray - sqrt( sqr(drop_ray) - sqr(leg_esp_x) );
			arm_esp		= drop_ray;
			
			
	//Actualisation de valeurs
	//	drop_x		= x;
	//	drop_y		= y - head_y;
		//Ces valeurs pourraient osciller doucement
		drop_rayx	= drop_ray + sin(drop_ray_per * current_time) * drop_ray_amp;
		drop_rayy	= drop_ray - sin(drop_ray_per * current_time) * drop_ray_amp;
	
	

if(global.pause == true){ exit; }

//Lente oscillation de "la tête goutte" pour suivre le mouvement des jambes
	//drop_y += sin(0.0005 * current_time) * 0.08;
	//drop_y += sin(0.0009 * current_time) * 0.08;
	//drop_y += sin(0.002 * current_time) * 0.08;	//la per commence à devenir pas mal mais encore un peu lent
	//drop_y += sin(0.003 * current_time) * 0.08;	//encore mieux
	
	//	sin_simulator(drop_y_per, drop_y_amp);
	//	if(keyboard_check_pressed(ord("E"))) drop_y_per += 0.001;
	//	if(keyboard_check_pressed(ord("R"))) drop_y_per -= 0.001;
	//	if(keyboard_check_pressed(ord("T"))) drop_y_amp += 0.1;
	//	if(keyboard_check_pressed(ord("Y"))) drop_y_amp -= 0.1;
	
	drop_y += sin(drop_y_per * current_time) * drop_y_amp;
	//drop_y = clamp(drop_y, drop_y_min, drop_y_max);
	
	if(can_evaporate == true) { evaporation(); }
	
#region STATES HUMIDITY
				
	if(state == PNJ_DANCING_STATE.IDLE)
	{
		state_str		= "IDLE";
		face_img		= face_img_neutral;
		arm				= arm_idle;
		leg_speed		= leg_speed_idle;
	
		counter++;	//Attendre
	
		//TRANSITION TRIGGER : 1 chance sur 2 de dancer
			if(counter >= (global.game_speed * random_range(2, 5)))
			{
				var _change = choose(0, 1);
				switch(_change)
				{
					case 0: state	= PNJ_DANCING_STATE.DANCE;	break;
					case 1:										break;
				}
				counter = 0;
			}
	}

	if(state == PNJ_DANCING_STATE.DANCE)
	{
		state_str		= "DANCE";
		face_img		= face_img_sleep;
		arm				= arm_dance;
		leg_speed		= leg_speed_dance;
	
		counter++;	//Attendre
	
			//TRANSITION TRIGGER
			if(counter >= (global.game_speed * random_range(3, 4))) 
			{
				var _change = choose(0, 1);
				switch(_change)
				{
					case 0: state	= PNJ_DANCING_STATE.IDLE;	break;
					case 1: 									break;
				}
				counter = 0;
			}
	}
	if(state == PNJ_DANCING_STATE.DRY)
	{
		state_str		= "DANCE";
		face_img		= face_img_stress;
	}
		

#endregion


#region FACIAL EXPRESSION

	if(instance_exists(player)) && (collision_circle(x, y, ray_alert, player, false, false))
	{
		if(player.water_state != PLAYER_HUMIDITY.RAGE)	{ face_img = face_img_big_smile; }
		else											{ face_img = face_img_stress; }
	}
	
#endregion



