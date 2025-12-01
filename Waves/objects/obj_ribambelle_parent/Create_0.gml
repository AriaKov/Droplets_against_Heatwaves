///@desc PNJ qui peut suivre player (cf. RIBAMBELLE) TEST
//(cf. obj_ribambelle_parent , cf. Blue See)
//Ribambelle d'objets qui se suivent tous à la file indienne.

proximite_max = 50;	//En dessous de cette distance avec l'object_to_follow, s'arrête.

//move_speed = random_range(0.7, 2);

global_var_to_local();

player = obj_player;

enum STATE { FREE, FOLLOW }
pnj_state		= STATE.FREE;
pnj_state_str	= "FREE";


#region Comportement avec LATENCE
	
	can_activate_alarm	= true;	
	latency				= irandom(20);
	alarm[0]			= latency;

#endregion


#region MOUVEMENT

	// https://marketplace.gamemaker.io/assets/6038/movement-functions

	x_from = x;		y_from = y;	//Position de départ
	x_to = x;		y_to = y;	//Position d'arrivé
	amt = 100;					//Amount to interpolate

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


#region COLLISION

	//tuto pour tiles collisions : https://www.youtube.com/watch?v=UyKdQQ3UR_0&t=1113s
	//	tilemap = layer_tilemap_get_id("Tiles");
	//	collisionnables = [tilemap, obj_collision_parent];	//TOUTES COLLISIONS
	collisionnables = [obj_collision_parent];

#endregion
