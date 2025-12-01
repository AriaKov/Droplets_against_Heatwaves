///@desc PARTICULES


if (global.pause == true) exit;

if ( move_x != 0 || move_y != 0 )
{
	var _r = 2; 
	var _randx = irandom_range(-_r, _r);
	var _randy = irandom_range(-_r, _r);
	var _trace = instance_create_layer(x + _randx, y + _randy, layer, obj_trainee_point);
		//_trace.time_destroy = irandom_range(10, 20);
	
	alarm[9] = particules_timer / global.time_speed;
}


//dans STEP ça donne un super effet "marcher sur le feu" <3 

else
{
	alarm[9] = particules_timer / global.time_speed;
	exit;
}

