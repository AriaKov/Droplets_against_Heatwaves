///@desc LATENCE

move_wrap(true, true, 100);

if(keyboard_check_pressed(ord("P"))){ pnj_state = STATE.FOLLOW; show_debug_message("PNJ_RIMBAMBELLE : FOLLOW"); }
if(keyboard_check_pressed(ord("M"))){ pnj_state = STATE.FREE;	show_debug_message("PNJ_RIMBAMBELLE : FREE")}


	if(pnj_state == STATE.FREE)
	{
		pnj_state_str = "FREE";
	}
	if(pnj_state == STATE.FOLLOW)
	{
		pnj_state_str = "FOLLOW";
	}	
		
///// COMPORTEMENT AVEC LATENCE
//alarm[0] = irandom(20);
	//if(can_activate_alarm == true)
	{
	//	latency				= irandom(20);
	//	alarm[0]			= latency;
	//	can_activate_alarm	= false;
	}




