///@desc METEO & EVENTS selon l'heure
// Fonctionne avec Cycle Day Night.
// Permet de centraliser (+ séparer de cycle_day_night)
// tous les évènements qui doivent se jouer à des moments précis, comme :
// - Météo (activation de layer_background + gestion de leurs alpha)
// - Création d'instance ou activation de spawner


	//TESTS
		effect_fx = fx_create("_effect_gaussian_blur");
		effect_fx = fx_create("_effect_glow");			//<3 mais trop large

		effect_fx = fx_create("_filter_screenshake");

		effect_fx = fx_create("_filter_outline");		//<3

		effect_fx = fx_create("_filter_distort");
		effect_fx = fx_create("_filter_pixelate");
		effect_fx = fx_create("_filter_underwater");	//<3
		effect_fx = fx_create("_filter_heathaze");		//<3


player				= obj_player;
object_cycle		= obj_c_cycle_day_night;

can_set_event_fire	= true;	//Se joue vers midi
can_set_event_day	= true;	//Autre event

can_set_event_hourly	= true;	//Toutes les heures


//DECLENCHEUR D'INCENDIES
	feu_follet			= obj_pnj_feu_follet;

//BRUME
	meteo_brume			= false;
	can_activate_brume	= true;
	proba_brume			= 1;	//1 => 1 sur 2	//irandom(proba)

	alpha_brume_max		= 0.9;
	alpha_brume			= 0;	//Alpha actuel
	alpha_brume_wanted	= 0;	//Alpha voulu
	alpha_brume_inc		= 0.01;

//RAIN
	meteo_rain			= false;
	can_activate_rain	= true;
	proba_rain			= 2;	//irandom(proba)
	
	//Particules ?
	//Etteind le feu ?




