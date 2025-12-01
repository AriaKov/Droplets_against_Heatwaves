///@desc STATES


mx = display_mouse_get_x();
my = display_mouse_get_y();

	nb_feufollet	= instance_number(obj_pnj_feu_follet);
	nb_droplet		= instance_number(obj_pnj_droplet);
	
//	var _hours;
//	with(obj_c_cycle_day_night){ _hours = hours; }
	//hours = obj_c_cycle_day_night.hours;
	watch_angle = 15 * global.hours; 


//Affichage de l'horloge si on l'a trouvé
	show_roundwatch		= global.found_tool_watch;
	show_loupe			= global.found_tool_loupe;
	show_humidity_bar	= global.found_tool_humidity;

if(global.pause == false){ enter_img = 0; }
if(global.pause == true){ enter_img = 1; }
	
	
	if(room == rm_end)
	{
		//if(end_alpha > 0)
		{
			end_alpha -= 0.0005;	
		}
	}
	
#region Effet apparition des 4 bandeaux lors de l'accélération du temps

	if(instance_exists(obj_c_cycle_day_night) == true)
	{
		if(obj_c_cycle_day_night.state == TIME.ACCELERATED)
		{
			time_acceleration = true;
			
			//sleep_bord = sleep_bord_max;	
			if(abs(sleep_bord_max - sleep_bord) > 0.1)
			{
				sleep_bord = lerp(sleep_bord, sleep_bord_max, sleep_bord_speed);
			}
		} 
		else
		{ 
			time_acceleration = false;
			
			//sleep_bord = 0; 
			if(abs(sleep_bord != 0))
			{
				sleep_bord = lerp(sleep_bord, 0, sleep_bord_speed);
			}
		}
	}
	
	if(global.pause == true)
	{
			//sleep_bord = sleep_bord_max;	
			if(abs(sleep_bord_max + (cell * 1 * scale) - sleep_bord) > 0.1)
			{
				sleep_bord = lerp(sleep_bord, sleep_bord_max + (cell * 1 * scale), sleep_bord_speed);
			}
		} 
		else
		{ 
			//sleep_bord = 0; 
			if(abs(sleep_bord != 0))
			{
				sleep_bord = lerp(sleep_bord, 0, sleep_bord_speed);
			}
		}

	
#endregion

#region Effet "clic" (box qui descend et remonte) au moment du changement de text, géré par QUEST_SYSTEM
	
	///Alarm[4], puis juste après : 
	//if(box_y != box_y_init)
	//while(box_y < box_y_init)	//bon ça ne marche pas mais ça marche sans!
	if(abs(box_y_init - box_y) > 0.1)
	{
		box_y = lerp(box_y, box_y_init, 0.1);
		//Actualisation 
		posy = box_y + (box_h/2);	
	}
	
#endregion

#region Effet "apparition par le bas" de la rage healthbar au moment de la rage.

	///Alarm[4], puis juste après : 
	if(abs(rage_y_final - rage_y) > 0.1)
	{
		rage_y = lerp(rage_y, rage_y_final, 0.1);
	}

#endregion


#region Conditions pour afficher l'info box

	if(text != "") && (instance_exists(player) && player.water_state != PLAYER_HUMIDITY.RAGE)
	{
		//Pour que text s'affiche il faut : qu'il soit différent de "". ET QUE :
		//Qu'il ne provienne pas d'un émetteur particulier, OU
		if (text_comes_from_an_emitter == false) ||
		//Qu'il provienne d'un émetteur et on est suffisament proche de lui.
		((text_comes_from_an_emitter == true) && (instance_exists(text_emitter) == true)
		&& (point_distance(text_emitter.x, text_emitter.y, player.x, player.y) < text_emitter_dist))
		{	
			can_show_info_text = true;
		}
	}
	else 
	{
		can_show_info_text = false;
	}
	
#endregion

#region Conditions pour afficher la barre de RAGE

	if(instance_exists(player) && player.water_state == PLAYER_HUMIDITY.RAGE)
	&& (global.found_rage_bar == true)
	{
		show_rage_bar = true;
	}
	else { show_rage_bar = false; }

#endregion


#region Background red transparent when RAGE

	if(instance_exists(player) == true) && (player.water_state == PLAYER_HUMIDITY.RAGE)
	{
		rage_bg_alpha_goal = rage_bg_alpha_max;
	}
	else { rage_bg_alpha_goal = 0; }
	
	if(abs(rage_bg_alpha_goal - rage_bg_alpha) > 0.01)
	{
		rage_bg_alpha = lerp(rage_bg_alpha, rage_bg_alpha_goal, 0.01);
	}
	
#endregion	
	
	
	//rage_amt	= player.alarm[8];
	
	
if(state == UI.START)
{
	state_str		= "START";
}
	
if(state == UI.MENU)
{
	state_str		= "MENU";
	
	if(show_title_a == true) && (show_title_b == true) && (show_title_c == true){ show_title_abc = true; }

	if(can_iterate_title == true){ alarm[1] = title_latency; can_iterate_title = false; }
	
	if(title_is_fading_out == true){ title_alpha -= title_alpha_decay; }
	//title_is_fading_out est contrôlé par QUEST_SYSTEM.
	//Et quand title_alpha <= 0, QUEST_SYSTEM s'occuppe de changer l'UI en HUD.
}

if(state == UI.HUD)
{
	state_str		= "HUD";
	
	if(global.pause == true){ state = UI.PAUSE; }
}

if(state == UI.PAUSE)
{
	state_str		= "PAUSE";
	
	if(global.pause == false){ state = UI.HUD; }
}




