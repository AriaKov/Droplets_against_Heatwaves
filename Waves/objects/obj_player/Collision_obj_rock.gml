///@desc


if(water_state == PLAYER_HUMIDITY.RAGE)
{
	with(other)
	{
		break_object_effect(image_blend);
		
		if(can_break == true)
		{
			if(break_level +1 > break_level_max){ instance_destroy(); }
			else {	
				break_level++;
				
				shake_camera_shortly();
				}
			
			can_break = false;
			alarm[1] = break_latency;
		}
	}
}









