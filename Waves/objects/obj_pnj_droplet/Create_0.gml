///@desc PNJ Goutte d'eau IMMOBILE, qui dance ou pas.

global_var_to_local();
	
enum PNJ_DANCING_STATE { IDLE, DANCE, DRY }
state		= PNJ_DANCING_STATE.IDLE;
state		= choose(PNJ_DANCING_STATE.IDLE, PNJ_DANCING_STATE.DANCE);
state_str	= "IDLE";

counter		= 0;
player		= obj_player;
ray_alert	= random_range(24, 32);

#region SPRITE

	sprite_idle		= spr_faune_squirrel_idle;
	sprite_dancing	= spr_faune_squirrel_idle;
	sprite_index	= sprite_idle;
	

	//Jambes
		leg				= spr_droplet_leg_idle;
		leg_h			= sprite_get_height(leg);
		leg_img_counter	= 0;	//Je dois incrémenter à la main car je draw manuellement.
		leg_speed_idle	= 6;	//cf. IMAGE_SPEED
		leg_speed_dance	= irandom_range(12, 16);
		leg_speed		= leg_speed_idle;
		
	//Bras
		arm_dance		= spr_droplet_arm_dance;
		arm_chill		= spr_droplet_arm_chill;
		arm_idle		= spr_droplet_arm_idle;
		arm				= arm_idle;
		arm_speed		= irandom_range(6, 12);
		
	//Droplet
		drop_ray_max	= 24;	drop_ray_max	= 16;	//SIZE		
		drop_ray_min	= 8;	//SIZE
		drop_ray		= drop_ray_min;		//drop_ray = random_range(4, 32);
		if(big == true){ drop_ray = 32; }
				
			//Hauteur de la tête (centre de l'ellipse) par rapport à l'origine
			head_y		= leg_h + drop_ray - 1; //-... car c'est une courbe, il faut une marge pour la jonction des jambes
												
												
		drop_x			= x;
		drop_y			= y - head_y;
			
			//Juste pour clamper
			drop_y_min = drop_y -2;
			drop_y_max = drop_y +2;
				
					//Oscillation de drop_y
					drop_y_per = 0.003 + random_range(-0.0005, 0.0005);
					drop_y_amp = 0.1 + random_range(-0.005, 0.005);
		
		//Ces valeurs peuvent osciller doucement (ellispe --> rayon h et v différents, aux sinus inversés)
		drop_rayx		= drop_ray;
		drop_rayy		= drop_ray;
		drop_ray_per	= random_range(0.004, 0.005);	// * (16/drop_ray);
		drop_ray_amp	= random_range(0.7, 1) / (16/drop_ray);
			
			//Distance de chaque membre par rapport au centre horizontal (x).
			leg_esp		= (drop_ray / 2) - 2;	//En fonction de la taille de la goutelette :)
			arm_esp		= drop_ray;
			
	//Visage & Expressions faciales
		face				= spr_droplet_face;
		f = 0;
		face_img_neutral	= f;	f++;
		face_img_smile		= f;	f++;
		face_img_big_smile	= f;	f++;
		face_img_stress		= f;	f++;
		face_img_drink		= f;	f++;
		face_img_splash		= f;	f++;
		face_img_sleep		= f;	f++;
		face_img_ambiguous	= f;	f++;
		face_img			= face_img_neutral; 
		face_color			= COL.WATER;
	
	
#endregion


	
	humidity_max		= 100;
	humidity_wet_min	= 10;	//Quantité minimale d'humidité pour pouvoir splash. Pour avoir un moment sans splash avant RAGE.
	humidity_dry_min	= 0;	//Passage de DRY à RAGE
	humidity			= random_range(50, 80);
		
		can_evaporate = false; //True after the 1st quest
		
		absorption_speed		= 0.5;	// humidity ++ au contact de l'eau (+ input)
		evaporation_speed_init	= 0.04;	// humidity -- naturellement le jour et ++ à l'aube
		evaporation_speed		= evaporation_speed_init;
		burning_speed			= 0.06;	burning_speed			= 0.1;
	
	//Eclaboussures
		can_absorb_splah		= true;	//Peut absorber des éclaboussures, sauf quand vient d'en recevoir
		timer_splash			= 0.5 * global.game_speed;
		splash_humidity_gain	= 15;
		
			//Distance de chaque membre par rapport au centre horizontal (x).
			leg_esp_x	= (drop_ray / 2);	//En fonction de la taille de la goutelette :)
			leg_esp_y	= drop_ray - sqrt( sqr(drop_ray) - sqr(leg_esp_x) );
			arm_esp = drop_ray;