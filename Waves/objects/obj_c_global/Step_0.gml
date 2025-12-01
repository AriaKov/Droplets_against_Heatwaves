///@desc EVENTS



if(1 == 1)
{
	if(keyboard_check_pressed(vk_delete))	{ game_restart(); }
//	if(keyboard_check_pressed(vk_numpad1))	{ if(room_exists(room_next(room)) == true){ room_goto_next(); }}
//	if(keyboard_check_pressed(vk_numpad2))	{ if(room_exists(room_previous(room)) == true){ room_goto_previous(); }}

//	if(keyboard_check_pressed(ord("G")))	{ with(obj_flore_parent){ event_perform(ev_alarm, 0); }}
	if(mouse_check_button_pressed(mb_right))
	{ 
		//PARTICULE
	//	instance_create_layer(mouse_x, mouse_y, "Instances", obj_fire_small);		
	}
	if(keyboard_check_pressed(ord("F")))	{ 
//		if(instance_exists(obj_flore_parent) == true)
		{ 
//			obj_flore_parent.show_debug = !obj_flore_parent.show_debug; 
//			show_debug_overlay(obj_flore_parent.show_debug);
		}
//		if(instance_exists(obj_fire_parent) == true)
//		{ obj_fire_parent.show_debug = !obj_fire_parent.show_debug;	}
	}
}


#region DEPTH

	//with(all) depth = -y;
	//with(all) depth = -bbox_bottom;	//on veux exclure les éléments du GUI !
	//with(obj_vfx_parent_of_objects_3d) depth = -bbox_bottom;
	
#endregion

#region FULLSCREEN

	if(input_keyboard_or_gamepad_check_pressed(global.key_fullscreen, global.gp_fullscreen)){ 
		global.fullscreen = !global.fullscreen;
		window_set_fullscreen(global.fullscreen); }
	
#endregion

#region TIME SPEED

	//Proportionnel à time_increment dans le cycle jour nuit.
	//Modifié par player lorsque dors --> accélération du temps
	//						normal	accéléré
	// time_increment		6		time_increment_max (200 par ex.)
	// global.time_speed	1		= 1*time_increment_max/time_increment
	if(instance_exists(obj_c_cycle_day_night) == true){ with(obj_c_cycle_day_night) {
		global.time_speed = 1 * time_increment_max / time_increment; }}
		
#endregion

#region PAUSE

//	can_pause_game = (instance_exists(obj_player) == false) || (obj_player.water_state != PLAYER_HUMIDITY.RAGE);
	can_pause_game = (obj_c_gui.state != UI.START) && (obj_c_gui.state != UI.MENU);
	//Si player n'existe pas (travelling, cinématique), on ne peut pas mettre en pause.
	if(can_pause_game == true)
	&& (input_keyboard_or_gamepad_check_pressed(global.key_pause, global.gp_pause) == true)
	{ global.pause = !global.pause; }
	
	if(global.pause == true)
	{
		if(keyboard_check_pressed(vk_delete))	{ game_restart(); }
	}
	
#endregion


#region ARTIFICIAL PLANT GROWTH

	if(can_artificially_make_plants_grow == true)	//DEBUG : faire grandir les plantes "à la main" en début de room
	{
		
		if(current_time mod 2 == 0)	//Toutes les x frames seulement
		{
			with(obj_flore_parent){ event_perform(ev_alarm, 0); }
			artificial_plants_growing_counter++;
		}
		if(artificial_plants_growing_counter >= 50)
		{ 
			can_artificially_make_plants_grow = false; 
			with(obj_c_camera){ desactive_instance_hors_view = true; }
			//global.flore_dead = 0;
		}
	}

		//Les faire grandir régulièrement, indépendament du cycle jour/nuit
	//	if(current_time mod 100 == 0)
		{
	//		//audio_play_sound(snd_chute_pierre_1022_01, 1, false);
	//		with(obj_flore_parent){ event_perform(ev_alarm, 0); }	
		}
	
#endregion

