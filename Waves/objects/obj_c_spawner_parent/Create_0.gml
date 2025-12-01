///@desc 

if(active == false) exit;

gui_w = global.gui_w;
gui_h = global.gui_h;
room_w = room_width;
room_h = room_height;

//obj_to_spawn		= obj_plant_parent;
//number_to_spawn		= 50;
distance_to_others	= 16;
margx				= 128;
margy				= margx;

if(one_shot == true)
{
	spawn_object_randomly_on_grid(obj_to_spawn, 200, number_to_spawn);
}
else
{
	//Crée une instance régulièrement, en DEHORS du champs de vision (ou pas) de la caméra
	//L'animal aura une direction initiale qui l'epproche de player.
	margin			= 32;	//Marges extérieures
	margin			= 0;
	latency			= (latency_sec + random(3)) * global.game_speed;	
	alarm[1]		= latency;
	count			= 0;
}

#region COLLISION

	if layer_exists("Tiles_water"){ tilemap_water = layer_tilemap_get_id("Tiles_water"); }
	else { tilemap_water = noone; } 
	collisionnables = [tilemap_water, obj_collision_parent, obj_player];

#endregion

/*
repeat(number_to_spawn)
{
//	var _xx = irandom_range(0, RES.W * RES.SCALE);
//	var _yy = irandom_range(0, RES.H * RES.SCALE);
	var _xx = irandom_range(0 + margx, global.gui_w - margx);
	var _yy = irandom_range(0 + margy, global.gui_h - margy);
	//Condition pour éviter les supperpositions
	//Si on a déjà une plante à cet endroit...
//	while(place_meeting(_xx, _yy, obj_to_spawn) == true)
//	while(instance_place(_xx, _yy, obj_to_spawn) != noone)
	while(collision_circle(_xx, _yy, distance_to_others, obj_to_spawn, false, true))
	{
		_xx = irandom_range(0, RES.W);
		_yy = irandom_range(0, RES.H);
	}
	
	instance_create_layer(_xx, _yy, layer, obj_to_spawn);
}




