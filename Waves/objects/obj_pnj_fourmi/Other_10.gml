///@desc NEW ASKING
//Event_user 0 appelé par le script give_seed(), appelé par player lors d'une collision qui respecte les conditions de ce pnj.

//Nouvelle plante demandée
//	plant		= choose(obj_flore_daisy, obj_flore_cactus, obj_flore_tree_dark, obj_flore_arbremaison);
//	plant		= obj_flore_daisy;
//	plant		= obj_flore_grass;

p++;
if(p > array_length(all_asking_plants) - 1) exit;

plant		= all_asking_plants[p];
	//	show_message("nouvelle plante demandée : " + string(object_get_name(plant)));
plant_spr	= plant.sprite_index;
	//	show_message("nouvelle plante demandée : " + string(object_get_name(plant)) + " (spr : " + string(plant_spr) + ")");
//plant_size	= plant.plant_size;
	plant_size = 2;
	//	show_message("nouvelle plante demandée : " + string(object_get_name(plant)) + " (size : " + string(plant_size) + ")");

//Changement de la taille de la bulle en fonction de la taille de la plante
bulle_img_plant	= plant_size + 3;	//Si taille == 1, image = 1

//Actualisation
//	bulle_w		= sprite_get_width(bulle);
//	bulle_h		= sprite_get_height(bulle);









