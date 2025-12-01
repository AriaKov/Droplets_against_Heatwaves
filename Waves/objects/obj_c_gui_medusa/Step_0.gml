

if(instance_exists(player) == false) { exit; }

/*


can_talk = player.dialogue_possible;
if(can_talk)
{
	alpha_talk = 1;
}
else
{
	alpha_talk = alpha_min;
}


if(room == rm_cheminee_01)
{
	if(instance_exists(firewall) && instance_exists(player))
	{
		global.distance_to_firewall = firewall.y - global.player.y;
		distance_to_firewall		= floor(global.distance_to_firewall / 20);	//Arbitraire :-)
	}
	
	//Distance parcourue depuis le bas de la room
	global.escape_distance	= room_height - global.player.y;
	escape_distance			= floor(global.escape_distance / 20);
	
	global.escape_distance_max	= max(global.escape_distance_max, escape_distance);
}


if(instance_exists(obj_textbox))
{
	state = SHOW_UI.DIALOGUE;	
}


#region ACTIONS

	switch(global.action)
	{
		case ACTION.PETRIFY:	global.action_str = "Petrify";	action_color = COL.ORANGE;	break;
		case ACTION.LOOK:		global.action_str = "Look";		action_color = COL.PINK;	break;
		case ACTION.TALK:		global.action_str = "Talk";		action_color = merge_color(COL.WHITE, COL.BLUE, 0.2);	break;
	}
	
#endregion


//Transparence du bouton d'action (space bar)
	if(player.can_petrify == false)
	{
		if(can_change_alpha){ 	alpha_action = alpha_min; can_change_alpha = false; }
	
		if(alpha_action < alpha_max)
		{
			alpha_action += 0.01;
		}
	}
	else 
	{
		alpha_action		= alpha_max; 
		can_change_alpha	= true;
	}
	alpha_action = clamp(alpha_action, 0, 1);

//Fondu transparent des boutons, qui s'effacent lorsque player bouge
	if(player.state == PLAYER_STATE.IDLE)
	if(player.state == PLAYER_STATE.IDLE)
	{
		if(can_change_alpha_gui){ alarm[1] = alpha_gui_latency;	can_change_alpha_gui = false; }
		
		if(alpha_gui_become_opaque)
		{
			//Devient visible
			if(alpha_gui < alpha_gui_max)
			{ 
				alpha_gui += alpha_gui_change_speed;
			}
		}
	}
	else
	{
		//S'efface
		if(alpha_gui >= alpha_gui_min)
		{ 
			alpha_gui -= alpha_gui_change_speed;
		}
		
		can_change_alpha_gui	= true;
		alpha_gui_become_opaque = false;
	}



if(global.gameover)
{
	state = SHOW_UI.GAMEOVER;
	
	show_hud = false;
	
	//NAVIGATION DE RESTART
	if(keyboard_check_pressed(global.key_petrify))
	{
		if(show_button_try_again == false)
		{
			//Recommencer ? Retour au menu ? Retour dans les pensées en N&B de la Gorgone ?	
			show_button_try_again = true;
		}
		else // Si les boutons sont déjà apparents
		{ 
			room_restart();
		}
	}
	if(keyboard_check_pressed(global.key_pause)) && show_button_try_again
	{
		game_restart();
	}
	
	//Fondu augmentant : couleur et transparence
	if(color_gameover_amount < 1)
	{
		color_gameover_amount += 0.005;
		color_gameover = merge_color(merge_color(COL.WHITE, COL.BLUESEE, color_gameover_amount), merge_color(COL.RED, COL.BLACK, 0.5), color_gameover_amount);
	}
	if(alpha_gameover < 0.8)
	{
		alpha_gameover += 0.005;
	}
	// else { with(obj_c_shadows){ shadow_active = true; } } //Pour N&B :-)
	
	
	//Le HUD s'efface progressivement
	if(alpha_gui >= 0)
	{ 
		alpha_gui -= alpha_gui_change_speed;
	}
	if(alpha_action >= 0)
	{
		alpha_action -= alpha_gui_change_speed;
	}
}
else { color_gameover_amount = 0; alpha_gameover = 0; } //Reset


//PAUSE
if(global.pause)
{
//	obj_darkness.darkness_active = true;
	
//	if(can_spawn_darkness)
	{
//		spawn_random_object_on_grid(obj_darkness, 1);
//		can_spawn_darkness = false;
	}
}
else
{
//	can_spawn_darkness = true;
	
//	obj_darkness.darkness_active = true;
}

