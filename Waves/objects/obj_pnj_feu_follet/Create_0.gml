///@desc PARTICULE luciole qui vole sans interférence


can_move_wrap = true;
alarm[10] = 60 * global.game_speed;

can_be_controlled	= true; //Sauf quand pète un plomb (??)
move_x		= 0;
move_y		= 0;
move_speed	= 1.5;	move_speed = 1;

dir			= random_range(1, 360);	//Direction actuelle
prev_dir	= 0;	//Direction précédente
new_dir		= 0;	//Direction à atteindre

collisionnables = [obj_collision_parent];


//En mode panique totale enflamée:
can_change_dir = true;
can_change_dir_timer = random_range(1, 3) * global.game_speed;

//Randomisation des instances, et à chaque changement de dir
per = 0.005;	per = random_range(0.003, 0.007);
amp = 1;		amp = random_range(0.7, 1.3);

image_speed = 4;
image_blend = COL.ORANGE;

//Fumée à l'apparition
instance_create_layer(x, y, layer, obj_effect_smoke);


//CREATION DE PARTICULE DE FEU
spark_latency			= 1 * global.game_speed;
alarm[3]				= spark_latency;
time_remaining			= alarm_get(3);		//En cas de pause, on sauvegarde le temps restant
has_just_been_paused	= false;	//Pour ne redémarrer l'alarme qu'une fois après la pause	


		//Eclaboussures
		humidity				= 0;
		humidity_max			= 50;
		can_absorb_splah		= true;	//Peut absorber des éclaboussures, sauf quand vient d'en recevoir
	//	timer_splash			= 0.1 * global.game_speed;
		timer_splash			= 0.5 * global.game_speed;
		splash_humidity_gain	= 10;	//Quantité absorbée au contact d'une goutte

	//Image of fire
		fire_spr			= choose(spr_fire_small, spr_fire_medium);
		fire_speed			= 15;
		fire_img_counter	= 0;
		