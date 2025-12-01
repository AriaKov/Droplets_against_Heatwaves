///@desc SPAWN


//if(infinite == true)
{
	instance_create_layer(x, y, "Instances", obj_to_spawn);
	
	latency		= latency_seconds_if_infinite * global.game_speed + rd_latency;
	alarm[0]	= latency;
}


