///@desc DEBUT DE LA PIECE

//DEBUG : faire grandir les plantes "à la main"
//if(room != rm_test)
{
	can_artificially_make_plants_grow = true;
}
artificial_plants_growing_counter = 0;


global.room_w = room_width;
global.room_h = room_height;

gamepad_vibrations_off();

global.pause = false;
window_set_fullscreen(global.fullscreen);

#region COLLISIONS
	
	if(room != rm_init)
	{
		if(layer_exists("Tiles_water") == true)	{ global.tilemap_water = layer_tilemap_get_id("Tiles_water"); }
		else									{ global.tilemap_water = noone; }
	}

#endregion

//if(room = rm_map_medium)
{
//	instance_deactivate_object(obj_player);	
}

///////////////////////////
//Pour "donner de l'âge" aux plantes et les faire de reproduire avant le début du jeu.
/*
with(obj_flore_parent)
{
	repeat(irandom(days_to_finish_mature))
	{
		event_perform(ev_alarm, 0);	
	}
}


