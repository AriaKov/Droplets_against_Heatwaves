///@desc FOOTSTEPS


if(global.pause == true) exit;

//show_message("Particle !");

#region FOOTSTEPS

	if(water_state == PLAYER_HUMIDITY.RAGE)
	{
		var _r = 4;
		var _randx = random_range(-_r, _r);
		var _randy = random_range(-_r, _r);
		var _trace = instance_create_layer(x + _randx, y + _randy, "Instances", particle_footstep);
			_trace.image_blend = color_rage;
	}
	else
	{
		if(move_x != 0) || (move_y != 0)
		{
			var _r = 4;
			var _randx = random_range(-_r, _r);
			var _randy = random_range(-_r, _r);
			var _trace = instance_create_layer(x + _randx, y + _randy, "Instances", particle_footstep);
				//_trace.time_destroy = irandom_range(10, 20);
		}
	}
	//dans STEP ça donne un super effet "marcher sur le feu" <3 

#endregion

#region EVAPORATION PSHHH...
	
	if(water_state == PLAYER_HUMIDITY.DRY)
	{
		player_effects_evaporation(drop_ray*2, 8);
	}
	
#endregion

alarm[0] = footstep_timer;

