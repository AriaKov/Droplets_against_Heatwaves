///@desc LYS DE FEU
//Appelé par l'event 1

//var _x = obj_human_3d.x;
//var _y = obj_human_3d.y;
///HAHA C POUR CA QUE CA BUG

var _x = x;
var _y = y;
instance_create_layer(_x, _y, "Instances", obj_flore_growing_lys);

/*
var _rand = irandom(100);
if _rand <= 10	//si rand compris entre 0 et la proba (qui est en %)
{
	//Faire apparaitre une Lys de Feu dans les cendres
	//spawn_object_on_surface_sprite(obj_flore_growing_lys, tilemap, "Instances", cell/2, true, -cell*6, -cell*6);
	instance_create_layer(random_range(0, cell*20), random_range(0, cell*20), "Instances", obj_flore_growing_lys);
}

