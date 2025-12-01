///@desc PNJ FOURMI QUI DEMANDE DES ITEMS

event_inherited();


enum FOURMI { NORMAL, ASKING }
state = FOURMI.ASKING;

player		= obj_player;
ray_action	= 128;
hauteur		= sprite_height;
scale		= 1;

//BULLE DE DEMANDE

	show_details	= false; //Sauf quand player proche

	bulle		= spr_ui_bulle;	//Ancrage centre-bas
	bulle_img_smile = 0;
	bulle_img_ask	= 1;
	bulle_img		= bulle_img_smile;
	bulle_w		= sprite_get_width(bulle);
	bulle_h		= sprite_get_height(bulle);
	bulle_x		= x;	
	bulle_y		= y - hauteur;
	bulle_color = COL.WHITE;	

//PLANTE DEMANDEE

		//Trop bizarre ça ne marche qu'avec bouleau, bush, cactus, daisy, grass,...
		//Ne marche pas avec arbremaison, jonc ...
		
	//plant	= obj_flore_langue_de_feu;	//Ancrage centre de la graine
	all_asking_plants = [
		obj_flore_daisy,
		obj_flore_bush,
		obj_flore_cactus,
		obj_flore_lys,
		];
	p			= 0;	//asking plant index
	plant		= all_asking_plants[p];
	//	show_message("plante demandée : " + string(object_get_name(plant)));
	plant_spr	= plant.sprite_index;	
	//	show_message("plante demandée : " + string(object_get_name(plant)) + " (spr : " + string(plant_spr) + ")");
//	plant_size	= plant.plant_size;
	plant_size = 2;
	//	show_message("plante demandée : " + string(object_get_name(plant)) + " (size : " + string(plant_size) + ")");
	plant_img	= 0;
	plant_img_speed		= 1; //sera multiplié par global.game_speed
	plant_img_counter	= 0;
	plant_x		= bulle_x;
	plant_y		= bulle_y - (bulle_h/2);

	//Changement de la taille de la bulle en fonction de la taille de la plante
	bulle_img_plant	= plant_size + 3;	//Si taille == 1, image = 1




