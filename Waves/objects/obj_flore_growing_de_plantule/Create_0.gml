///@desc GROWING PLANT

global_var_to_local(); //déclare localement cell = RES.CELLSIZE; + les couleurs

//ATTENTION !!! IL Y A "STAGE" (sprite précis en fonction de l'age) ET "STATE"
//(état général de croissance : semis / croissance / mourrant, et qui se réfère à l'enum)
//quand MATURE, peut produire des graines qui tombent au sol
enum GROWTHSTAGE { SEED, YOUNG, MATURE, OLD };
state		= GROWTHSTAGE.SEED;
state_str	= "SEED";

//FIRE
	//enum FIRESTATE { NORMAL = 0, RECOVER = 1, BURNED = 2 };
enum FIRESTATE { NORMAL, BURNED };
firestate	= FIRESTATE.NORMAL; 

	fire_colors = [c_white, yellow, orange, red];
	fire_state	= 0;	//Devient max quand brûle, puis décroit progressivement
	fire_state_max = array_length(fire_colors) - 1;


//plant_name		= plant_name;	//Dans les variables
plant_object		= object_get_name(object_index);			//nom de l'objet ENFANT
plant_sprite		= sprite_get_name(sprite_index);

	//Pour pouvoir draw_part la graine dans l'inventaire, il faut désactiver Nine Slice
	//Je crois qu'il faut dabord en créer un puis le désactiver :
	//nineslice			= sprite_nineslice_create();
	//nineslice.enabled = false;
	//sprite_set_nineslice(sprite_index, nineslice);


#region SPRITE

	image_speed		= 0;
	scale			= 1;
	image_xscale	= choose(-scale, scale);

	sprite_normal	= sprite_index;
	//Si on assigne autre chose que sprite_index à sprite_burning dans les variables, on change le sprite lors du feu.
	largeur			= sprite_width;
	hauteur			= sprite_height;

#endregion

#region POSITION (CLAMP & GRID)

	//GRID
	x = x - (x mod (cell/2));
	y = y - (y mod (cell/2));
	
	//CLAMP
	posmarge = cell * 6;
	x = clamp(x, - posmarge, room_width + posmarge);
	y = clamp(y, - posmarge, room_height + posmarge);

#endregion


#region PLANT_SIZE & DURATION STAGE

	//plant_sizes = ["small", "medium", "big", "giant"];	//Le nombre de stage dans GROWTH en dépend
	//plant_size = 1;
	
	all_durations_stages_0 = [
	//seed(1), young(1), mature(2ou+), (old)
		[1, 1,	1, 1,	1],		//plant_size = 0 (small plant) (le dernier chiffre est toujours celui de old)
		[2, 3,	5, 10,	30],	//plant_size = 1 (medium plant)
		[3, 3,	3, 3, 3, 3, 3]	//plant_size = 2 (big plant)
		];
	
	rd = irandom(1);	//random days duration
	all_durations_stages = [
	//Combien de jours passés dans chacun des stages ? En fonction du state (0, 1, 2, ou 3)
	//Pour rappel, il y a 1 seul stage dans les states 0, 2, et 3. Donc le state 1 répète la même durée pour tous ses stages.
	//seed(1), young(1), mature(2), old(3)
		[1 +rd, 1,	3 +rd,	1 +rd],		//plant_size = 0 (small plant) (le dernier chiffre est toujours celui de old)
		[3 +rd, 3,	8 +rd,	2 +rd],		//plant_size = 1 (medium plant)
		[4 +rd, 5,	10 +rd, 3 +rd],		//plant_size = 2 (big plant)
		[5 +rd, 8,	20 +rd, 10 +rd]		//plant_size = 3 (giant plant)
		];
	//duration_stage = all_durations_stages[state];	//dans ce cas, touts les stages de l'état GROWTH durent 3.
	
		all_durations_stages_len = array_length(all_durations_stages);
	//Si la taille de la plante est sup ... ? 
	if (plant_size > array_length(all_durations_stages) -1)
			{	duration_stage = array_length(all_durations_stages) -1; } //la durée de l'âge = 
	else	{	duration_stage = all_durations_stages[plant_size][state]; }
	
#endregion

#region STAGES OF GROWTH
	
	//AGE	:	Age en jours (cf. CycleDayNight). A chaque nouveau jour : age++ 
	//STAGE :	Stade de développement - impacte le sprite. Autant de stage que d'image dans le sprite.
	//			Stage dépend de l'âge. le dernier stade est "old" et ensuite mort.
	//STATE	:	Etat (semis (image/stade 0), croissance (x images/stade), mourrant (image max/dernier stade)).
	
	age				= 0;		//Age total de la plante, en jours, depuis son semis.
	
	//ages_max = [
	//	30 + irandom(3),	//small
	//	45 + irandom(5),	//medium
	//	60 + irandom(10)];	//big
		ages_max = [
		30 + irandom(3),	//small
		45 + irandom(5),	//medium
		100 + irandom(10),	//big
		300 + irandom(10)];	//giant
	
	if(plant_size > array_length(ages_max) - 1) { age_max = array_length(ages_max) - 1; }
	else { age_max = ages_max[plant_size]; }	//Age max de la plante, après quoi disparait.
	
	days_in_stage	= 0;		//Nombre de jours passés dans un stage. Réinitialise à chaque début de stage.
								//days_in_stage se balade dans duration_stage
			
	//number_of_stages = sprite_get_number(sprite_index) - 1;		//Nombre d'états de croissance max
	number_of_stages = image_number - 1;	//number_of_stage est égal au sprite "old"
	
	//Stage initial randomisé que lors de spawn de début de room (sinon, lorsqu'on sème, on voit la frame random pendant 1 fraction de seconde)
	stage_init		= irandom_range(1, number_of_stages - 2);	//Stade initial randomisé (excepté seed et old)
	//stage_init	= 0;	
	stage			= stage_init;		//Stade actuel de développement
	image_index		= stage;			//Stade actuel impacte l'image_index
	
	image_blend = c_white;	//Si normal
	//sprite_index = sprite_normal;
	
#endregion


#region FIRE
	
	//is_bruned = false;			//Actif lors du feu, et jusqu'à ce que la plante redevienne normale.
	can_be_set_in_fire = true;	
	//resistance_time = 0.5 * global.game_speed + (plant_size/2) + random(0.5);	//Avant de s'embraser
	//resistance_time = 0.5 * global.game_speed + (plant_size/2);	//Avant de s'embraser
	resistance_time = 0.5 * global.game_speed;	//Avant de s'embraser
	resistance_time = 1;	//1 donne un effet immé0diat
	//time_set_in_fire = 10 * global.game_speed;
	
	sound_fire = snd_fire;
	
#endregion

#region PROPAGATION OF SEEDS
	
	can_propagate_seed = false;	//que au state/stage mature

	//seed_ray		Rayon de propagation possible autour de la plante.
	//seed_num		Nombre de graines propageable en même temps.
	//seed_proba_init	Probabillité (%) que chaque graine apparaisse. init car change en fonction le la densité
	
	seed_proba = seed_proba_init;
	
	margin_dissemination = cell*2;	//Impossibilité de semer dans un petit rayon autour de la plante mère
	
	//RAYON (PAR DEFAUT si -1 dans les variables)
		if seed_ray <= 0		//Si on a mis 0 dans les variables --> rayon par défaut en fonction de la taille
		{	
			//all_ray_seed_dispersion = [cell*6, cell*12, cell*20, cell*30];
			all_ray_seed_dispersion = [cell*4, cell*8, cell*12, cell*60];
				
			if (plant_size > array_length(all_ray_seed_dispersion)-1) seed_ray = array_length(all_ray_seed_dispersion);
			else seed_ray = all_ray_seed_dispersion[plant_size];
		}
		else {	seed_ray = seed_ray * cell;	} //Dans les variables de chaque enfant
	
	
	//NOMBRE D'INSTANCES DE LA PLANTE DEJA DANS LA ROOM (PAR DEFAUT si -1 dans les variables)
		//num_plants = instance_count; //je me demande si ça ne compte pas les instances de obj_growing_parent...
		num_plants = instance_number(object_index);	//C'est mieux (ça cible chaque enfant).
	
		all_num_plants_min = [1, 1, 1];	all_num_plants_max = [400, 300, 200];
		
		 
		if(num_plants_min <= 0)
		{
			if (plant_size > array_length(all_num_plants_min)-1) {	num_plants_min = array_length(all_num_plants_min) - 1; }
			else { num_plants_min = all_num_plants_min[plant_size]; }
		}	//num_plants_min = 5;
		if num_plants_max <= 0
		{
			if (plant_size > array_length(all_num_plants_max)-1) {	num_plants_max = array_length(all_num_plants_max) - 1; }
			else { num_plants_max = all_num_plants_max[plant_size]; } //num_plants_max = 200;
		}
	
	
	//CONCENTRATION DE LA PLANTE DANS LA ROOM (C = n/V)
		//Concentration = Nombre d'Instances / Superficie de la Room
		//Ex :
		//Nombre d'Instances : Supposons qu'il y a 20 instances d'un objet.
		//Superficie de la Room : Si la room mesure 800 pixels de large et 600 pixels de haut, alors :
		//Superficie = 800 * 600 = 480000 pixels²
		//Calcul de la Concentration :
		//Concentration = 20 / 480000 = 0.00004167 instances par pixel²
	
		superficie_pxl		= room_width * room_height;	//en pixels carré
		superficie_cell		= obj_c_global.nb_cell_x * obj_c_global.nb_cell_y;
		concentration_pxl	= ( num_plants / superficie_pxl ) * 10000;
		concentration_cell	= ( num_plants / superficie_cell ) * 100;
		
	
	//SOUND
		sound_seedling = snd_chute_pierre_1022_01;
	
#endregion
	

#region COLLISIONS

	if(layer_exists("Tiles_Collisions") == true){ tilemap = layer_tilemap_get_id("Tiles_Collisions"); }
	else { tilemap = noone; }
	collisionnables = [tilemap, obj_collision_parent, obj_player]; //, obj_flore_growing_parent];
	ray_coll = 8; //marge de collision
	
#endregion

#region SHAKING LORS DU PASSAGE DE PLAYER

	if plant_size == 0 { shake_create(10,	0.5, 30, [obj_player_3d_human, obj_ball_player, obj_enemy_poissonge, obj_enemy_crabe]); }
	if plant_size == 1 { shake_create(1,	0.5, 30, [obj_player_3d_human, obj_ball_player, obj_enemy_poissonge, obj_enemy_crabe]); }
	if plant_size == 2 { shake_create(0.2,	0.5, 30, [obj_ball_player, obj_enemy_poissonge, obj_enemy_crabe]); }
	if plant_size == 3 { shake_create(0.2,	0.5, 30, [obj_ball_player, obj_enemy_poissonge, obj_enemy_crabe]); }

#endregion

#region REPERTOIRE ET QUANTITE DE GRAINES (PICKUP, INVENTORY)

	ds_seeds = ds_grid_create(2, 20);
	
	var _c = 0; var _l = 0;
	ds_seeds[# _c, _l++] = "Quantity";	//
	ds_seeds[# _c, _l++] = "Name";		//
	ds_seeds[# _c, _l++] = "Size";		//plant_size	
	ds_seeds[# _c, _l++] = "Sprite";
	ds_seeds[# _c, _l++] = "Description";

	nb = 0;
	all_plants = [
	[nb, "Tree",	1, 1,	1],		
	[nb, 3,	5, 10,	30],		
	[nb, 3,	3, 3, 3, 3, 3]		
	];
	//plante = all_plants[plant_size][state];
	
	
#endregion	

/*Les plantes poussent, peuvent brûler, et repousser ensuite.
Si elles sont détruites entièrement, elle libèrent du charbon et des graines
Les graines (irandom(5)) poussent à leur tour.
Il faut un tableau qui recence les états de chaque plante, et la durée à l'état suivant.
stage 0 (pousse) durée en jour =	1
stage 1 (juvenile)					1
stage 2								2
stage 3								2
stage 4 (mature)					infini (reste adulte) (ou devient une souche ?)
stage dernier (death)				infini (reste une souche ?)
*/

