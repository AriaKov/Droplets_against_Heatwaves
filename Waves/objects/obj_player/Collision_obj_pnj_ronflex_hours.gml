///@desc SLEEP & ACCELERATE TIME

/* //DANS STEP car besoin de définir ce qu'il se passe autour d'un RAYON
//Possibilité de dormir : rester immobile près du PNJ Ronflex, et accélérer le temps.
if(collision_circle(x, y, ray_action, obj_pnj_ronflex, false, false))
//if(input_keyboard_or_gamepad_check(global.key_absorbe, global.gp_absorbe))
{
	with(obj_c_cycle_day_night)
	{
		if(can_accelerate_time == true)
		{
		//	event_user(7);	
			time_increment		= time_increment_max;
			can_accelerate_time = false;
		}
	}
}
else	//Plus de collision
{
	with(obj_c_cycle_day_night)
	{
		//	event_user(7);	
			time_increment		= time_increment_init;
			can_accelerate_time = true;
	}	
}



