///@desc PNJ qui peut suivre player (cf. RIBAMBELLE)
//(cf. obj_ribambelle_fish_parent , cf. Blue See)
//Ribambelle d'objets qui se suivent tous à la file indienne

global_var_to_local();

enum PNJ_STATE { IDLE, WANDER, RUNAWAY, FOLLOW }
state		= PNJ_STATE.IDLE;
state_str	= "IDLE";

counter		= 0;	//S'incrémente

//target	= obj_player;	//Dans les variables

avoid_others = true;

#region RANDOMISE APPEARANCE

	scale = 1;
	image_xscale = scale;
	image_yscale = scale;

	image_speed = random_range(0.8, 1.2);	image_speed = 0;
	
	rc = random_range(0.1, 0.8);
	image_blend = merge_color(COL.GREEN, COL.WATER, rc);
	
	
#endregion

rayon_alert				= 128;	
rayon_near				= 32;	//Distance d'arrêt autour de player. En dessous de cette distance, s'arrête.
rayon_lacherlagrappe	= 1.5;	//Facteur de multiplication du rayon alert, pour qu'il nous suive davantage

//SOUND
rayon_audition = room_width;
//sound_step = snd_MP3_Wing_Flapping;
sound_step = snd_chute_pierre_1022_01;

//TILES_COLLISIONS
//tilemap = layer_tilemap_get_id("Tiles_Collisions"); //Pour les collisions

move_x	= 0;
move_y	= 0;
my_dir	= 0;		//Direction vers la target
my_dist	= 0;	//Distance à la target


#region MOUVEMENT

	// https://marketplace.gamemaker.io/assets/6038/movement-functions

	x_from	= x;	y_from	= y;	//Position de départ
	x_to	= x;	y_to	= y;	//Position d'arrivé
	amt		= 100;					//Amount to interpolate

	#region Détail pour chaque fonction de mouvement possible

		//FOR WAVE_... functions
		amp		= 70;	//Amplitude of the wave
		ncycles = 5;	//Number of cycles

		//FOR WAVE_ABSORBED_... functions
		amp		= 70;	//Amplitude of the wave
		ncycles	= 5;	//Number of cycles
		alpha	= 2;	//Absorption coefficient

		//FOR CIRCLE_... functions
		rad		= 70;	//Radius of circles in pixel (negative to move down first)
		ncycles = 5;	//Number of cycles

		//FOR ZAP_... functions
		njumps	= 7;	//Numbers of jumps

		//FOR ELASTIC_... functions
		relastic	= 30;	//Radius of elasticity, big number = big elasticity
		ncycles		= 5;	//Number of cycles

	#endregion

#endregion

