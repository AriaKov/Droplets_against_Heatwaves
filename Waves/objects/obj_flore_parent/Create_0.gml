///@desc FLORE

event_inherited();

global_var_to_local();

plant_object = object_get_name(object_index);

can_burn			= true;		//toujours true sauf en SEED
can_propagate_seed	= false;	//toujours false sauf en MATURE
seeds_propagated	= 0;		//Compte le nombre de graines déjà disséminées

first_time_being_hydrated = true; //cf. to count the number of global.plants_hydrated_by_splash


#region SPRITE ♥
	
	//REMARQUES :
	//1) Pour mieux VISUALISER la plantes dans les rooms, le sprite qui lui est assigné est différent de ceux qu'elle utilise.
	//2) Chaque plante a un sprite normal et un sprite burned, qui est le même sans le feuillage.
	
	//COLOR
	color_random = true;
	color_normal	= c_white;
	color_dry		= c_yellow;
	color_burning	= c_red;
	
	if(color_random == true)
	{
			hue			= irandom_range(30, 130);	hue			= irandom_range(60, 130);	//Teinte
			sat			= irandom_range(180, 240);	//Saturation
			val			= irandom_range(50, 200);	//Luminosité
		
		//Très léger
		color_wet		= merge_color( make_color_hsv(hue, sat, val), c_white, 0.6);
		color_dry		= merge_color( make_color_hsv(hue - 30, sat, val), c_white, 0.6);
		color_wet		= merge_color( merge_color( c_blue, c_green, random_range(0.2, 0.8)), c_white, 0.4);
		//color_dry		= merge_color( make_color_hsv(hue - 60, sat, val), c_white, 1);		
		color_dry		= merge_color( merge_color( c_red, c_orange, random(0.7)), c_white, 0.1);

		
			//	hue_difference = ceil(10 + (hue/2));
			//	//hue_difference = ceil(20 + (hue));	//Prise en compte de la teinte actuelle pour ajuster la couleur de brûlé inversement proportionnellement
			//	if((hue - hue_difference) < 0)	{ hue_fire = 255 - hue; }	//Pour repasser de l'autre côté du spectre
			//	else							{ hue_fire = hue - hue_difference; }
			hue_fire = choose(irandom_range(0, 20), irandom_range(230, 255));
			sat_fire = sat;
			val_fire = val - (val/4);
	
		color_burning	= make_color_hsv(hue_fire, sat_fire, val_fire);
		
	//	colors_burned	= [color_burning, c_red, c_orange, c_yellow, c_white];
		

	}
	
	//	color_wet	= c_blue;
	//	color_dry	= c_yellow;
	
		color_normal_amt = 0; //propotionnel a l'humidity (humidity_max - humidity_dry_min)
		color_normal	= merge_color(color_dry, color_wet, color_normal_amt);
		
		color_burned_amt = 0;
		color_burned	= merge_color(color_burning, color_wet, color_burned_amt);	//:-) cool
		
	color	= color_wet;
		
	
	//SPRITE : Assignation automatique :) il faut avoir crée 2 autres sprites : spr_flore_nomdeplante_normal et spr_flore_nomdeplante_burned.
		sprite_normal	= sprite_index;	//Ce sprite là sert juste à visualiser lors du placement
		sprite_normal	= asset_get_index(sprite_get_name(sprite_index) + "_normal");
		sprite_burned	= asset_get_index(sprite_get_name(sprite_index) + "_burned");
		sprite			= sprite_normal;
		sprite_index	= sprite_normal;
	
	//PLANT NAME
		object_name				= object_get_name(object_index);
		object_name_len			= string_length(object_name);	
		//plant_name			= string_delete(object_name, 0, 10);	//pas aussi simple visiblement
		plant_str_first_char	= string_copy(object_name, 11, 1);	
		plant_str_first_char	= string_upper(plant_str_first_char);	//Première lettre en majuscule
		plant_str_last_char		= string_copy(object_name, 12, object_name_len - 1);	//Reste du mot
		plant_name				= plant_str_first_char + plant_str_last_char;
	
	//IMAGE
		image_speed = 0;	//Chaque image du sprite correspondra à une "étape" de croissance, au sein d'un état de croissance (enum).

		//Image au choix
			spr = irandom(image_number - 1);
			//if(spr mod 2 != 0){ spr = choose(spr-1, spr+1); }	//Ne sélectionner que les images paires (pas impaires car ça commence à 0)
			if(spr mod 3 == 1){ spr = choose(spr-1, spr+1); }
			if(spr mod 3 == 2){ spr = choose(spr-2, spr+2); }
		
	//SCALE
		scale = 1;
		image_xscale = choose(-scale, scale);
		image_yscale = scale;
		
		spr_w	= sprite_get_width(sprite_index) * scale;
		spr_h	= sprite_get_height(sprite_index) * scale;

		//Vent au sommet de la plante. ne peut se faire que via draw_pos qui empêche l'image blending.
		//Donc que si normal ? Sachant que burned ==> image blend rouge...
		wind_osc = 0; 
		wind_osc_per = random_range(0.003, 0.001);	//La "vitesse"
		wind_osc_amp = random_range(2, 8);			//La "taille"

#endregion 


#region STATS

	switch(plant_size)
	{
		case 0:
			seed_num		= 3;	//Nombre max de graines propageable en même temps
			seed_num_total	= 5;	//Nombre max de graines propageable dans toute sa vie
			seed_proba_init = 100;	//Proba de propager x graine à un moment donné
			seed_ray		= cell * 4;	//Rayon de propagation
			num_plants_min	= 1;	//Nombre de plante dans la room en dessous (<=1) duquel la proba de propagation devient 100%.
			num_plants_max	= 150;	//Nombre de plante dans la room : si dépassé, la proba de propagation égale 0.
				num_plants_max	= 100;
			ray_coll		= 16;	//Rayon de collision (lors de la propagation)
			ray_coll		= 32;
			
			humidity_max	= 30;	//Humidity max 

		break;
		case 1:
			seed_num		= 1;
			seed_num_total	= 2;
			seed_proba_init = 100;
			seed_ray		= cell * 7;
			num_plants_min	= 1;
			num_plants_max	= 100;	num_plants_max	= 80;
			ray_coll		= 80;
		
			humidity_max	= 50;

		break;
		case 2:
			seed_num		= 1;
			seed_num_total	= 5;
			seed_proba_init = 100;
			seed_ray		= cell * 15;
			num_plants_min	= 1;
			num_plants_max	= 50;	
			ray_coll		= 64;
		
			humidity_max	= 100;

		break;
		case 3:
			seed_num		= 1;
			seed_num_total	= 5;
			seed_proba_init = 100;
			seed_ray		= cell * 20;
			num_plants_min	= 1;
			num_plants_max	= 10;
			ray_coll		= 128;
		
			humidity_max	= 120;

		break;
	}
		
	seed_proba_init = seed_proba;
	num_plants		= instance_number(object_index);
		
	timer = 0; //Pour intense sparkling
	
#endregion


#region COLLISIONS
	
	//WATER : can't propagate
		if(layer_exists("Tiles_water") == true)	{ tilemap_water = layer_tilemap_get_id("Tiles_water"); } else { tilemap_water = noone; }
	
	//COLLISIONS
		if(layer_exists("Tiles_way") == true)	{ tilemap_way = layer_tilemap_get_id("Tiles_way"); } else { tilemap_way = noone; }
		
		collisionnables = [tilemap_way, obj_collision_parent, obj_rock, obj_water_parent, obj_player, obj_pnj_parent, tilemap_water];
		//A part l'eau, les chemins et les personnages, aucune restriction de biome pour la propagation.
	/*	
	switch(biome)
	{
		case "normal":	
			break;	
		
		case "beach":	//Ne peux se propager que sur le sable
			if(layer_exists("Tiles_grass") == true)		{ tilemap_grass		= layer_tilemap_get_id("Tiles_grass");	
				collisionnables = array_push(collisionnables, tilemap_grass); } //	else { tilemap_grass = noone; }
			if(layer_exists("Tiles_forest") == true)	{ tilemap_forest	= layer_tilemap_get_id("Tiles_forest"); 
				collisionnables = array_push(collisionnables, tilemap_forest); } //	else { tilemap_forest = noone; }
		//	collisionnables = [tilemap_way, obj_collision_parent, obj_player, obj_pnj_parent, tilemap_water, obj_water_parent, tilemap_grass];
			
			break;	
		
		case "normal":	//Ne peux se propager que dans la prairie ou la foret
			if(layer_exists("Tiles_sand") == true)	{ tilemap_sand	= layer_tilemap_get_id("Tiles_sand");
			collisionnables = array_push(collisionnables, tilemap_sand);
			}
		//	}	else { tilemap_sand = noone; }
		//	collisionnables = [tilemap_way, obj_collision_parent, obj_player, obj_pnj_parent, tilemap_water, obj_water_parent, tilemap_sand]
			break;	
		
		case "forest":	//Ne peux se propager que dans la forêt
	//		if(layer_exists("Tiles_sand") == true)	{ tilemap_sand	= layer_tilemap_get_id("Tiles_sand"); }		else { tilemap_sand = noone; }
	//		if(layer_exists("Tiles_grass") == true)	{ tilemap_grass = layer_tilemap_get_id("Tiles_grass"); }	else { tilemap_grass = noone; }
		//	collisionnables = [tilemap_way, obj_collision_parent, obj_player, obj_pnj_parent, tilemap_water, obj_water_parent, tilemap_sand, tilemap_grass];
	//		collisionnables = array_push(collisionnables, tilemap_sand, tilemap_grass);
			break;	
	}*/
	
	//	collisionnables = [tilemap_way, obj_collision_parent, obj_player, obj_pnj_parent, tilemap_water, obj_water_parent];	
	ray_coll = 8; //marge de collision
	
#endregion
		

#region HUMIDITY


//	humidity_seuil		= 0;	//Point de basculement vers FIRE_STATE.BURNING

	//humidity_max		= 100;	//Depends on the size
	humidity_wet_min	= 10;	//Quantité minimale de réserve. Pour avoir un moment de latence avant de cramer.
	humidity_dry_min	= 0;	//Passage de DRY à BURNING
//	humidity_min		= 0;	
	
	humidity			= humidity_max;
	
	//Eclaboussures
		can_absorb_splah		= true;	//Peut absorber des éclaboussures, sauf quand vient d'en recevoir
		timer_splash			= 0.5 * global.game_speed;
		splash_humidity_gain	= 5;
		splash_humidity_gain	= 15;
	

	//HYPOTHESE : vitesses comme pour player
	//Vitesses (humidity)
		absorption_speed		= 0.5;	//0.3	// humidity ++ au contact de l'eau (+ input)
		evaporation_speed_init	= 0.01;	//0.04;	//0.02	// humidity ++ naturellement et surtout le jour
		evaporation_speed		= evaporation_speed_init;
		//Différente le jour et la nuit ? :D ou que la nuit ! --> géré dans le script evaporation()
	
		watering_speed		= 0.05;	// humidity ++
		burning_speed		= 0.06;	// humidity -- au contact du feu
		burning_speed		= 0.2;
	
#endregion

	
#region FIRE
		
	//BURNING = while in fire. BURNED = recover from fire.
	enum FIRE_STATE { NORMAL, WET, DRY, BURNING, BURNED, DEAD }
	fire_state				= FIRE_STATE.WET;
	fire_state_str			= "WET";
	previous_state			= fire_state;
	
	can_actualise_state_based_on_humidity = true; //Sauf en burning
	
	//cf. PLANTULE
	//Etapes (fire_STAGE) à l'intérieur de l'état BURNED
		fire_stage_colors	= [c_red, c_orange, c_yellow, c_white];
		//colors_burned		= [c_red, c_orange, c_yellow, c_white];
		fire_stage			= 0;	//Devient 0 quand brûle, puis acroit progressivement jusqu'à la fin de l'array, ensuite NORMAL.
		fire_stage_max		= array_length(fire_stage_colors) - 1;
	
	fire_duration		= 0;
	fire_duration_max	= 30 * global.game_speed;
	death_probability	= 0;	//Based on fire_duration_timer
	death_proba_highest	= 0;	//highest = irandom(low number)
	death_proba_lowest	= 10;	

	
	//Taille du feu : en fonction de plant_size
	fires_obj	= [obj_fire_small, obj_fire_medium, obj_fire_medium, obj_fire_big];		fire_obj	= fires_obj[plant_size];
	fires_spr	= [spr_fire_small, spr_fire_medium, spr_fire_medium, spr_fire_big];		fire_spr	= fires_spr[plant_size]
	
	//Image
		fire_speed			= 15;
		fire_speed			= random_range(14, 16);
		fire_img_counter	= 0;
		
	//ray_fire_propagation	= cell * scale * 2;	//Proportionnel à la taille (scale)
	//ray_fire_propagation	= spr_w * scale * 1.5;
	ray_fire_propagation	= cell*2 * scale * 1.5;
	
	
	burning_speed		= 0.01;
	burning_speed		= 0.1;
	
	
		//BURNING STATE (cf. RAGE state of player)
		burn_max			= -100;	//= HUMIDITY MINIMALE ABSOLUE. Au début de l'incendie, humidity tombe à burn_max.	
		//burn_max devrait s'appeler en tte logique humidity_burning_min
		humidity_burned_min	= -50;
		burn_decay			= 0.02;	//Réduction naturelle de la rage (donc augmentation de l'humidité)
		can_start_burn		= true;	//Ne déclenche l'event qu'1 fois au début du state.
	
	
	can_start_wet = true;
	can_start_dry = true;
	
			//cf. PLANTULE
		//	can_be_set_in_fire = true;	
			//resistance_time = 0.5 * global.game_speed + (plant_size/2);	
		//	resistance_time = 0.5 * global.game_speed;	//Avant de s'embraser
		//	resistance_time = 1;						//1 donne un effet immédiat


//	image_blend = c_white;	//Si normal, rouge si brule
	
	
	//ALARMES
		//Numéro des alarmes
			alarm_propagation			= 3;
			alarm_spark					= 4;
			
		//Alarme pour la propagation 
		alarm_propagation_can_be_set	= true;
		propagation_timer				= random_range(1, 3) * global.game_speed;
	
		//Alarme pour les étincelles
		alarm_spark_can_be_set			= true;
		spark_timer						= random_range(2, 5) * global.game_speed;
		
		//DEATH
		alarm_death_can_be_set			= true;
		death_timer						= random_range(30, 60) * global.game_speed;
	
#endregion


#region GROWTH
	
	//ATTENTION : growth_stage (ou state anciennement) est l'étape globale de croissance
	//Stage quant à elle est l'étape précise, et est déterminée par le nombre d'image du sprite.
	enum AGE { SEED, YOUNG, MATURE, OLD };
	growth_stage			= AGE.SEED;
	growth_stage_str		= "SEED";
	//growth_stage = choose(AGE.SEED, AGE.YOUNG, AGE.MATURE, AGE.OLD);
	
	
	//Chaque jour qui passe incrémente days. Il y a (days_in_stage) jours dans 1 stage.
	//Un STAGE == une IMAGE du sprite, donc il y a autant de stage que d'image_number.
	//Mais il faut AU MOINS 4 images, pour faire touts les stades de croissance (seed, young, mature, old)
	//Toutes les images en + vont s'intercaler dans AGE.YOUNG, en doublant, triplant,... la durée de ce stage.
	// image 0							== AGE.SEED					
	// image (de 1 à image_number -2)	== AGE.YOUNG	can_burn	
	// image (image_number -2)			== AGE.MATURE	can_burn	can_propagate_seed
	// image (image_number -1)			== AGE.OLD		can_burn	
	
	// A la création des instances lors du spawn, toutes les plantes vont avoir un age au hasard (sauf seed).
	// days = irandom_range(1, image_number -1); 
	// si days == 1, stage = 1. 
	// si days == 5 et qu'on a 7 images, stage = (image_number-2)

	//(En excluant la 1ere image) 1 image = 1 stage. TOUTES LES VAR "img_min", "img_seed"... 
	//POURRAIENT ËTRE REMPLACEES PAR "stage_min", "stage_seed"...
	
	//Le nombre d'images donne le nombre de stages (de juvénile)
		img_total	= image_number;	//(On ne compte pas l'img "mature" doublon) --> en fait il n'y en a plus
		img_min		= 0;
		img_max		= img_total - 1;		//== au sprite "old"
	
	//Choix d'un stage au pif
		img_init	= irandom_range(1, img_max);	//STADE INITIAL RANDOMISE (excepté seed)
		img_init = 0;
		img			= img_init;
		image_index = img;
		
	//Assignation des images aux stages de croissance
		img_seed	= 0;	//Pas 0 car on veut ignorer l'image plante mature (en position 0) qui sert juste à la conception du jeu !
		img_young	= 1;
		img_mature	= image_number - 2;	//avant dernier
		img_old		= image_number - 1;	//dernier
	
	//Nombre total d'images pour le stade AGE.YOUNG
		if(img_total > 4) //S'il y a + de 4 images à considérer... 
		{ 
			img_young_number = img_total - 3; //On soustrait les 3 autres images (seed, mature, old)
			//show_message(string(plant_object) + " : il y a " + string(img_young_number) + " images dans le  stade YOUNG");
		}
		else { 
			img_young_number = 1;
			//show_message(string(plant_object) + " : il y a 1 image dans le  stade YOUNG");
		}
	
	//Duration of each growth stage
		rd = irandom(1);	//random days duration
		//Combien de jours passés dans chacun des stages ? En fonction de plant_size (0, 1, 2, ou 3)
		//Pour rappel, il y a 1 seul stage dans les states 0, 2, et 3.
		//Donc le state 1 répète la même durée pour tous ses stages. (??)
		//seed(1), young(1), mature(2), old(3)
		all_durations_stages = [
			[1 + rd,	1,		3 + rd,		1 + rd],	//plant_size = 0 (small = herbacée) (le dernier chiffre est toujours celui de old)
			[3 + rd,	3,		8 + rd,		2 + rd],	//plant_size = 1 (medium = arbuste)
			[4 + rd,	5,		10 + rd,	3 + rd],	//plant_size = 2 (big = arbre)
			[5 + rd,	8,		20 + rd,	10 + rd]	//plant_size = 3 (giant plant)
			];
		all_durations_stages = [
			[1 + rd,		1,		2 + rd,		2 + rd],	//plant_size = 0 (small = herbacée) (le dernier chiffre est toujours celui de old)
			[1 + rd,		2,		4 + rd,		3 + rd],	//plant_size = 1 (medium = arbuste)
			[1 + rd,		5,		8 + rd,		4 + rd],	//plant_size = 2 (big = arbre)
			[5 + rd,		8,		20 + rd,	10 + rd]	//plant_size = 3 (giant plant)
			];
		durations		= all_durations_stages[plant_size];
		duration_stage	= durations[growth_stage];
		//Ex : une plante de taille 2 et dans son growth_stage 1 aura une duration_stage de 5.


	//Days number to go to each growth stage
	duration_of_seed_stage		= durations[AGE.SEED];
	duration_of_young_stage		= (durations[AGE.YOUNG] * img_young_number);
	duration_of_mature_stage	= durations[AGE.MATURE];	
	duration_of_old_stage		= durations[AGE.OLD];	
	
	days_to_finish_seed			= duration_of_seed_stage;
	days_to_finish_young		= days_to_finish_seed + duration_of_young_stage;
	days_to_finish_mature		= days_to_finish_young + duration_of_mature_stage;
	//days_to_finish_old		= days_to_finish_mature + duration_of_old_stage;

	
	//Nombre d'états de croissance max
	//	stage_max = image_number - 1 - 1;	
		
	//Growth stage initial randomisé que lors de spawn de début de room (sinon, lorsqu'on sème, on voit la frame random pendant 1 fraction de seconde)
	//	stage_init		= irandom_range(1, stage_max - 2);	//STADE INITIAL RANDOMISE (excepté seed et old) //PK PAS jjuste -1 ?
		//stage_init		= 0;	
	//	stage			= stage_init;		//Stade actuel de développement
	//	image_index		= stage;			//Stade actuel impacte l'image_index
		
		//A QUOI CORRESPONDENT EXACTEMENT LES STAGES ? --> aux IMAGES du sprite
		//Il n'y a qu'un seul stage par growth_stage, SAUF dans le stade AGE.MATURE.
		
	//Number of days
		days			= 0;	//Age total de la plante, en jours, depuis son semis (même fictif, si l'instance vient d'être crée)
		
		all_days_max	= [
			30,			//small
			45,			//medium
			100,		//big
			300,	];	//giant
		days_max		= all_days_max[plant_size];	//Age max de la plante, après quoi disparait.
		
		days_max		= durations[AGE.SEED] + (durations[AGE.YOUNG] * (img_max - 3)) + durations[AGE.MATURE] + durations[AGE.OLD];
		days			= irandom_range(1, days_max); //Age initial aléatoire
		
		days_in_stage	= 0;	//Nombre de jours passés dans un stage. Réinitialise à chaque début de stage.
								//days_in_stage se balade dans duration_stage
								
		//Lors de la création de l'instance, on randomise stage, ce qui fait que chaque plante à un growth_stage différent.
		//Le nombre de jours de vie est ensuite mis à jour, ainsi que le growth_stage.
		
		
		if(days <= days_to_finish_seed)										{ growth_stage = AGE.SEED;		img = img_seed; }
		if(days > days_to_finish_seed) && (days <= days_to_finish_young)	{ growth_stage = AGE.YOUNG;		img = floor((days - durations[AGE.SEED]) div durations[AGE.YOUNG]) + 1; }
		if(days > days_to_finish_young) && (days <= days_to_finish_mature)	{ growth_stage = AGE.MATURE;	img = img_mature; }
		if(days > days_to_finish_mature)									{ growth_stage = AGE.OLD;		img = img_old;	}
		//TRIGGERS
			//C'EST img QUI DETERMINE L'AGE (anciennement la STATE)
		//	if(img == img_min)							{ growth_stage = AGE.SEED; }
		//	if(img >= img_min) && (img < img_mature)	{ growth_stage = AGE.YOUNG; }
		//	if(img == img_mature)						{ growth_stage = AGE.MATURE; }
		//	if(img == img_old)							{ growth_stage = AGE.OLD; }
		
#endregion


#region SOUNDS

	//SOUNDS FIRE
		sound_fire			= snd_vege_leaf_roseau_de_chine_1__ID_1811__LS;
		sound_fire_gain		= random_range(0.1, 0.2);
		sound_fire_pitch	= random_range(0.9, 1.1);
	
	//SOUNDS OSCILLATION
		sounds		= [
		//	VEGELeaf_Roseau_de_chine_1__ID_1811__LS,
		//	VEGELeaf_Roseau_de_chine_2__ID_1812__LS,
			snd_vege_leaf_roseau_de_chine_3__ID_1813__LS,
		//	VEGELeaf_Roseau_de_chine_4__ID_1814__LS,
		];
		sound_pitch	= random_range(0.8, 1.2);
		sound_gain	= 0.1;
		
	//SOUND SEEDLING
		sound_seedling = snd_chute_pierre_1022_01;
	
#endregion


#region OSCILLATION SI CONTACT (cf. Plantule)

	//C'est cheum haha mais c'est pck à la base j'avais mis toute cette région dans un script,
	//sauf qu'on ne peut déclarer des variables dans un script.

	_triggers = player;
	//_triggers = [global.player, obj_faune_solitaire_parent];
	//if(instance_exists(obj_faune_solitaire_parent)){ _triggers = obj_faune_solitaire_parent; }
//	if(instance_exists(obj_living_beings_parent)){ _triggers = obj_living_beings_parent; }
	if(instance_exists(obj_player))		{ _triggers = obj_player; }
//	if(instance_exists(obj_pnj_parent))	{ _triggers = obj_pnj_parent; }
//	if(instance_exists(obj_player) && instance_exists(obj_pnj_parent)){ _triggers = [obj_player, obj_pnj_parent]; }
	
	//ARBRE DE PARENTALITE
	// obj_vfx						: tous les objets SOLIDES (flore, êtres vivants, objets, particules d'eau, de feu,...)
	//	> obj_flore_parent			: toutes les plantes (IMMOBILES)
	//	> obj_living_beings_parent	: tous les êtres vivants MOBILES (player, pnj, faune, ennemis)
	//		> obj_player			:
	//		> obj_faune_parent		: 
	//		> obj_pnj_parent		: 
	//		> obj_enemy_parent		: 


	_alarm_name = 1;
	_ray = 8;
	_angle_max = irandom_range(5, 35);
	_per_init = 0.01;
	_amp_init = 0.5;
	_duration = 60;

	#region OSCILLATION

		is_shaking			= false;
		can_start_shaking	= true;		//La proximité doit trigger 1 seule fois la plante.
										//Pour être re-trigger, le trigger doit partir puis revenir.
		
		trigger_autonome	= true;		//True : l'objet vérifie lui-même la collision (- optimisé)
										//False : la collision est commandée par obj_c_shake_plants (+ optimisé, mais pas encore focntionnel)
		
		ray			= _ray;			//Rayon d'influence du trigger
		angle_init	= 0;			//Angle de base
		angle		= angle_init;	//Angle actuel (fluctue)
		angle_max	= _angle_max;	//Angle max d'oscillation
	
	duration		= random_range(1,3) * global.game_speed;	//Durée (Temps d'amortissement) de l'oscillation
			
		periode_init	= _per_init;				//Longueur d'onde (diminue)
		periode			= periode_init;		
		amplitude_init	= _amp_init;				//Hauteur d'onde (diminue)
		amplitude		= amplitude_init;	
							
		oscillation_speed = 0;

	#endregion

	#region TRIGGER
	
		trigger	= _triggers;
		//dist	= distance_to_object(trigger);
		
		if(is_array(trigger) == false){	dist	= distance_to_object(trigger); }	//Distance au trigger (cas normal où trigger == player seulement)
			
			//TENTATIVE D'AVOIR AUSSI DES TRIGGERS FAUNE ET PNJ
			if(is_array(trigger) == true)
			{
				show_message("FLORE > CREATE : trigger IS an array (" + string(trigger));
				//var _inst = instance_place(x, y, trigger); //instance_place permet de récolter la valeur de  l'instance pour l'utiliser
				var _inst = instance_nearest(x, y, trigger);	show_message("FLORE > CREATE : instance_nearest = " + string(_inst));
				if (_inst != noone) //s'il y a collision...
				{ 
					trigger = _inst;	//Save the id of that trigger
				}
			}

		dir_x	= sign(trigger.x - x);	//Direction sur x de l'oscillation, en fonction de la position du trigger. (-1 ou 1)
	
	#endregion
	
	//Alarm
	alarm_end_oscillation = _alarm_name;
	
	image_angle = angle;
		
#endregion





///////
//Pour "donner de l'âge" aux plantes et les faire de reproduire avant le début du jeu.
	//repeat(irandom(days_max - 1))
//	repeat(irandom(days_to_finish_mature))
	{
	//	event_perform(ev_alarm, 0);	
	}

