///@desc PARENT DE TOUS LES TYPES DE FEU
//automatic_destruction (l'inverse de infinite = ne s'éteind jamais (Ex: les torches))
// Dans le cas contraire une alarme les éteind au bout d'un moment
// size = taille du feu, de 1 (petite torche) à 3 (grand feu)


//INCENDIE : la durée de vie du feu est-elle liée à son combustible (plante) ? 
//Ou dépent-t-elle du feu elle même ? 1ere réponse.


global_var_to_local();

global.fires_number++;

	//Hypothèse de la jauge
		humidity_max	= 100;
		humidity_min	= 0;
		humidity		= humidity_min;
		humidity_gain	= 0.01;
		//Quand l'humidity arrive à 100, le feu s'éteind.
	
		//Eclaboussures
		can_absorb_splah		= true;	//Peut absorber des éclaboussures, sauf quand vient d'en recevoir
		timer_splash			= 0.1 * global.game_speed;
		splash_humidity_gain	= 10;	//Quantité absorbée au contact d'une goutte
		splash_humidity_gain	= 20;
		
	if(layer_exists("Tiles_water") == true)	{ tilemap_water = layer_tilemap_get_id("Tiles_water"); } else { tilemap_water = noone; }
	
if(automatic_destruction == true)	//Destruction automatique
{
	//Hypothèse du timer
	//	alarm[10]		= random_range(5, 10) * global.game_speed;
		//En cas de pause, on sauvegarde le temps restant
	//	has_just_been_paused	= false;	//Pour ne redémarrer l'alarme qu'une fois après la pause
	//	time_remaining			= alarm_get(10);
	

}


#region RANDOMISATION DES FLAMMES

	scale			= 1;
	image_xscale	= choose(-scale, scale);
	image_yscale	= scale;

	rand			= 0.3;
	rand_speed		= 1 + random_range(-rand, rand);
	image_speed		= rand_speed;

	image_index		= irandom(image_number - 1);	//Commencer à n'importe quelle image

#endregion



