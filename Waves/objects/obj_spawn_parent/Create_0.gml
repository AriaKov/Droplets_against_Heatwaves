///@desc LATENCY


//infinite						= true;
//number_max_if_not_infinite	= 50;



if(infinite == true) //Créer des instances régulièrement, à l'infini.
{
	rd_latency	= random(3);
	latency		= latency_seconds_if_infinite * global.game_speed + rd_latency;
	alarm[0]	= latency;
}
else		//Créer toutes les instances d'un coup et se détruire.
{
	repeat(number_max_if_not_infinite)
	{
	//	rd = random_range(-area_if_not_infinite, area_if_not_infinite);
		var _x = x + random_range(-area_if_not_infinite, area_if_not_infinite);
		var _y = y + random_range(-area_if_not_infinite, area_if_not_infinite);
		instance_create_layer(_x, _y, "Instances", obj_to_spawn);	
	}	
	instance_destroy();
}


