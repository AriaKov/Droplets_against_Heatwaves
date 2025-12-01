///@desc PLAYER
//A la base j'avais un perso (humaine ? brindille ? biche ? oiseau ?...) qui portait une goutte d'eau autour / sur son corps,
//Mais de fil en aiguille la bulle d'eau a pris un visage, et maintenant je pense ne faire qu'un perso bulle d'eau autonome.
//Je crois qu'ne fin de compte : 
// 
//					<-----RAGE----------->	<---DRY--->		<-------WET--(can splash)-------->
//	(variables)		rage_max																humidity_max
//	(humidity)		-50						0			10									100					
//	(humidity %)							0% >>>										>>> 100%			
//	(rage %)		100% 	rage_decay>>>	0%		
//En état de rage, on a une nouvelle jauge de rage, qui diminue au fil du temps.
//et qui : +++ légèrement lors de destruction, propagation d'incendie
//		   --- lors de contact avec l'eau.
//C'est donc à peu près une jauge d'humidité, je peux garder humidity comme variable (rage = 1/humidity)
//Au début de la rage, humidity tombe à -30 et ++ progressivement, donc le contact avec l'eau apaise + vite.
	
	global_var_to_local();
	
/*

	ray_action			= 32;
	
	//FEU QUI EST SUR PLAYER EN STATE RAGE
	fire			= obj_fire_player;	//ne s'autodétruit pas
	personal_fire	= instance_create_layer(-500, -500, "Instances", fire);
	instance_deactivate_object(personal_fire);
	
	
#region HUMIDITY // FIRE

	enum PLAYER_HUMIDITY { RAGE, DRY, WET }
	water_state		= PLAYER_HUMIDITY.DRY;
	water_state_str = "DRY";
	
	humidity			= 50;	//ATTENTION doit être constante de room en room --> global.humidity
	humidity			= global.humidity;
	resistance			= 0;	//Quantité minimale d'humidité pour pouvoir splash.
								//En négatif, permet aussi une latence avant de devenir enragée.
	humidity_min		= - resistance;
	humidity_max		= 100;
	
	rage_max			= -30;	//Au début de la rage, humidity tombe à rage_max.	
	
	
	//Vitesses (humidity)
		absorption_speed	= 0.3;	absorption_speed		= 0.5;	// humidity ++ au contact de l'eau (+ input)
		evaporation_speed	= 0.02;	evaporation_speed_init	= 0.04;	// humidity -- naturellement le jour et ++ à l'aube
		evaporation_speed	= evaporation_speed_init;
	
		watering_speed		= 0.05;		//humidity -- au contact des plantes
		burning_speed		= 0.06;		//humidity -- au contact du feu

	duration_absobtion_max	= 4 * global.game_speed;
	duration_resistance_max	= 2 * global.game_speed;

	
	//Splash
		splash_droplets_num		= 50;	//Nombre de gouttes créées lors d'un splash
		splash_humidity_loss	= 5;	//Quantité d'eau perdue lors d'un splash

	//RAGE
	//Gamepad Vibration
		rage_vibration_amount_init	= 1;
		rage_vibration_amount		= rage_vibration_amount_init;
		rage_vibration_decay		= 0.001;
	
	
#endregion

#region SPRITE
	
	sprite_idle	= spr_pnj_flammeche;
	sprite_move = sprite_idle;
	mask_index	= spr_pnj_leaves;
	
	//image_speed = 0;
	scale		= 1;
	
			head_y		= 16; //Hauteur de la tête par rapport à l'origine
	
	//Jambes
		leg_idle		= spr_droplet_leg_idle;
		leg_move		= spr_droplet_leg_move;
		leg				= leg_idle;
		leg_h			= sprite_get_height(leg);
		leg_img_counter	= 0;	//Je dois incrémenter à la main car je draw manuellement.
		leg_speed_idle	= 6;	//cf. IMAGE_SPEED
		leg_speed_dance	= irandom_range(12, 16);
		leg_speed		= leg_speed_idle;
		
	//Bras
		arm_idle		= spr_droplet_arm_idle;
		arm_chill		= spr_droplet_arm_chill;
		arm_dance		= spr_droplet_arm_dance;
		arm				= arm_idle;
		arm_speed		= 8;
		
	//Droplet = La goutte d'eau que porte player dans l'état WET
		drop_ray_max	= 64;
		drop_ray_min	= 8;
		drop_ray		= drop_ray_min;

			//Hauteur de la tête (centre de l'ellipse) par rapport à l'origine
			head_y		= leg_h + drop_ray - 1; //-... car c'est une courbe, il faut une marge pour la jonction des jambes

		drop_x			= x;
		//drop_y		= y - head_y - drop_ray;
		drop_y			= y - drop_ray - leg_h + 4;
		//Ces valeurs peuvent osciller doucement (ellispe --> rayon h et v différents, aux sinus inversés)
		drop_rayx		= drop_ray;
		drop_rayy		= drop_ray;
		drop_ray_amp	= 0.005;
		drop_ray_per	= 1;
	
	
		//Distance de chaque membre par rapport au centre horizontal (x).
			leg_esp_x	= (drop_ray / 2);	//En fonction de la taille de la goutelette :)
			leg_esp_y	= drop_ray - sqrt( sqr(drop_ray) - sqr(leg_esp_x) );
			//sqr = carré, sqrt = racine carrée
			//Cette formule vient de Pythagore : rayon2 = a2 + b2
			//avec a = esp_x = r/2, et b = racine(r2 - a2)
			//L'objectif est de trouver esp_y, qui est la différence entre r et b. 
			//Donc esp_y = r - racine( r2 - (esp_x)2 ).
			
			arm_esp		= drop_ray;
			
	
	//Visage de la goutte d'eau //Droplet facial expression
		face				= spr_player_water_face;
		face_img			= 0; //Change d'expression en fonction des états et actions
		can_change_face_img = true;
		//Lorsqu'on fait un splash, l'expression reste + longtemps qu'une seule frame
		
		
		color_normal	= COL.WATER;
		color_rage		= merge_color(COL.RED, COL.ORANGE, 0.5);
		color			= color_normal;
		face_color		= COL.WATER;
	
#endregion

#region MOVE
	
	enum PLAYER_MOVE_STATE { IDLE, MOVE }
	move_state		= PLAYER_MOVE_STATE.IDLE;
	move_state_str	= "IDLE";
	
	
	can_move = true;	//!!!! Ajout de cette var pour créer une sorte d'état FREEZE contrôlé par QUEST_SYSTEM !!!!
						//false uniquement pendant les cinématiques !
	
	can_be_controlled	= false; //Sauf quand pète un plomb
	move_x			= 0;
	move_y			= 0;
	move_speed_dry	= 1.5;	//En tant normal, lorsque DRY
	move_speed_wet	= 1.2;	//Quand rempli d'eau, lorsque WET au max
	move_speed		= move_speed_dry;
	dir				= 0;
	
		//En mode panique totale enflamée:
	move_speed_rage_init	= move_speed_dry + 0.2;
	move_speed_rage			= move_speed_rage_init;
	move_speed_rage_decay	= 0.01;
	
	can_change_dir = true;
	can_change_dir_timer = random_range(1, 3) * global.game_speed;
		
		can_set_endrage_alarm = true;
		panic_duration = 12 * global.game_speed;
	
	
	enum FACING { RIGHT, UP_RIGHT, UP, UP_LEFT, LEFT, DOWN_LEFT, DOWN, DOWN_RIGHT }
	facing = FACING.DOWN;
	facing_str = "D";
	
	
		/*
		//Je veux un facing dans les diagonales, et ce même quand player est idle.
		latest_inputs		= [global.key_d, global.key_r];	//Array des 2 derniers inputs
		latest_inputs_len	= 2;	//On ne regarde que les 2 dernières valeurs, on supprime les autres au fur et à mesure
		last_input			= array_pop(latest_inputs);	//La dernière valeur de l'array
	
		//INPUT
		//Si différent des deux valeurs de
	
		//à chaque input :
		array_push(latest_inputs, input)
		if(latest_inputs > latest_inputs_len){
			array_resize(latest_inputs, latest_inputs_len); }
		*/
		
#endregion

#region COLLISION

	//tuto pour tiles collisions : https://www.youtube.com/watch?v=UyKdQQ3UR_0&t=1113s
	tilemap = noone;
//	if layer_exists(global.tiles_collision){ tilemap = layer_tilemap_get_id(global.tiles_collision); }
//	else { tilemap = noone; } 
	collisionnables = [tilemap, obj_collision_parent];
	ray_coll = 8; //marge de collision
	
#endregion

#region PARTICULES QUAND MOVE
	
	//Au timer
	particules_timer = 0.25 / 2 * global.game_speed;
	alarm[8] = particules_timer / global.time_speed;
	
	//Constantes
	constantes_particules_au_sol = false;
	
#endregion.


//Pour le ronflex
timer = 0;

