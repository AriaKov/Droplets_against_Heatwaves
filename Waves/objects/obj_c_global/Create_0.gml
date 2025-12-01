///@desc GLOBAL.VARIABLES
#region NOTE SUR LA SYNTAXE !!!
//		Fonction			Retourne					Utilisation recommandée
//		instance_exists()	true ou false				Utilisez directement
//		place_meeting()		true ou false				Utilisez directement
//		instance_place()	ID de l'instance ou noone	Comparez avec noone
//		collision_circle()	ID de l'instance ou noone	Comparez avec noone		*ainsi que toutes les collision_...

//C'est TRES IMPORTANT car écrire : if(condition == true){...} ne marchera PAS mais ne sera pas considéré comme une erreur fatale!
//La bonne grammaire est :			if(condition != noone){...}
#endregion

//ARBRE DE PARENTALITE
// obj_vfx						: tous les objets SOLIDES (flore, êtres vivants, objets, particules d'eau, de feu,...)
//	> obj_flore_parent			: toutes les plantes (IMMOBILES)
//	> obj_living_beings_parent	: tous les êtres vivants MOBILES (player, pnj, faune, ennemis)
//		> obj_player			:
//		> obj_faune_parent		: 
//		> obj_pnj_parent		: 
//			> obj_pnt_droplet	: idle, dance 
//			> obj_pnt_leaf		: idle, wander, follow
//		> obj_enemy_parent		: 

	//xmiddle = mean(obj_player1.x, obj_player2.x, obj_player3.x);
	//ymiddle = mean(obj_player1.y, obj_player2.y, obj_player3.y);
	//This will set xmiddle and ymiddle to the x and y coordinates of the average of the coordinates
	//of three player objects, obj_player1, obj_player2 and obj_player3.
	//You could, for instance, use this to keep the game camera focused on all three players instead of just one.

// randomize();	//Permet de randomiser la seed (pour du vrai aléatoire)

//DEBUG : faire grandir les plantes "à la main"
can_artificially_make_plants_grow = false;
artificial_plants_growing_counter = 0;

global.debug		= false;	//géré par o_debug (permanent) qui est retiré de la room dans le jeu fini
global.fullscreen	= false;
global.pause		= false;	can_pause_game = true;
global.game_speed	= game_get_speed(gamespeed_fps);
global.player		= noone;
global.gravite		= 0.5;

global.time_speed	= 1;	//Lié à l'écoulement du temps de obj_c_cycle_day_night

//STATS
global.fires_number		= 0;	//Number of : obj_fire_parent, and obj_flore_parent if BURNING
global.fires_stopped	= 0;
global.flore_dead		= 0;

global.plants_actually_wet = 0;
global.plants_hydrated_by_splash = 0;	//total de toutes les plantes arrosées

global.hours = 0;	//Car je n'arrive pas à accéder à hours dans obj_c_cycle_day_night...??

global.found_tool_watch		= false;
global.found_tool_loupe		= true;
global.found_tool_humidity	= false;
global.found_rage_bar		= true;


counter = 0;	//COMPTEUR DE TEMPS PASSE DANS LA ROOM


	
#region INPUTS

	//Au lieu de ne considérer que les inputs clavier et appeler mes variables global.input_...,
	//Je considère d'une part le gamepad (global.gp_...) et d'autre part le keyboard (global.key_...).
	
	#region GAMEPAD
	
		global.gamepads = [];	//Va avec ASYNC SYSTEM (+ gamepad_exists()...) pour utiliser les manettes
	
			global.gp_pause			= gp_start; 
			global.gp_fullscreen	= gp_select;
			global.gp_a			= gp_face2;	//jump
			global.gp_b			= gp_face1;	//attack
			global.gp_x			= gp_face3; //pickup
			global.gp_y			= gp_face4;
		//	global.gp_vision	= gp_shoulderl; //et gp_shoulderr !
	
			global.gp_croix_u	= gp_padu;
			global.gp_croix_d	= gp_padd;
			global.gp_croix_l	= gp_padl;
			global.gp_croix_r	= gp_padr;
			
			//SHOULDER
		//	gp_shoulderl
		//	gp_shoulderlb
		//	gp_shoulderr
		//	gp_shoulderrb
			
			//MOVE
			global.gp_stick_l	= gp_stickl;	//Appuyer sur le joystick
			global.gp_stick_r	= gp_stickr;	//Appuyer sur le joystick
			global.gp_h			= gp_axislh;	
			global.gp_v			= gp_axislv;	//mais peu utile non ? on ne s'en sert que dans Player...
			
			//GAMEPLAY
			global.gp_absorbe	= global.gp_b;	//ABSORBER
			global.gp_splash	= global.gp_a;	//ECLABOUSSER
			global.gp_zoom		= gp_shoulderl;	//ZOOM +/-
			
			//MEDUSA
		//	global.gp_jump		= global.gp_a;
		//	global.gp_petrify	= global.gp_y;
		//	global.gp_talk		= global.gp_x;
			
			
		global.vibrations = true;

	//BOUTONS DE MANETTE :
	// A (jump/roulade)
	// B (attaque)
	// X (action choisie)
	// Y (watervision?)
	// shoulder L (recentrer la caméra)
	// shoulder R (afficher la map)
	// shoulder(R/L) bas (maintenir pour être en watervision?)
	// START (pause)
	// SELECT (screen?)
	// JoystickL (move)
	// JoystickR (caméra?)
	// pads (settings ? music / vibration)
	
	#endregion
	
	#region KEYBOARD
				
		//UI
		global.key_pause		= vk_enter;		keyboard_set_map(vk_enter, vk_return);
		global.key_fullscreen	= vk_escape;	//ord("F");		//Toggle Fullscreen mode
	//	global.key_a			= vk_space;		// Use Tool / OK
	//	global.key_b			= vk_shift;		// Changer outil (incr++) / Retour
	
	//	global.key_dialog			= vk_space;		//Select / Speak / Attack
	//	global.key_pickup			= ord("C");		//Pick up / Drop item (anciennement input_action)	//Shift
	
		//MOVES
		global.key_r	= vk_right;
		global.key_u	= vk_up;
		global.key_l	= vk_left;
		global.key_d	= vk_down;
		//Provisoiremant desactivé pour le débug
													//WASD équivaut à ZQSD
		//keyboard_set_map(ord("W"), vk_up);		keyboard_set_map(ord("Z"), vk_up);
		//keyboard_set_map(ord("A"), vk_left);		keyboard_set_map(ord("Q"), vk_left);
		//keyboard_set_map(ord("D"), vk_right);
		//keyboard_set_map(ord("S"), vk_down);
			
		//GAMEPLAY
		global.key_absorbe	= vk_shift; //ABSORBER
		global.key_splash	= vk_space;	//ECLABOUSSER
		keyboard_set_map(vk_rshift, vk_shift); keyboard_set_map(vk_lshift, vk_shift);
		//global.key_zoom	= ord("Z");	//ZOOM +/-
		global.key_zoom		= vk_add;			keyboard_set_map(vk_subtract, vk_add);
		
	#endregion
	
#endregion
	
#region GAMEPLAY
	
	//OBJETS RECURRENTS
	global.player	= obj_player;
	global.humidity = 25;	//Humidité initiale de player
	
	global.seeds	= 0;	//GRAINES RECOLTEES

	global.time_acceleration = false; //True when sleeping
		
	global.tiles_collision = "Tiles_Water";
	
	//GAME
	global.life_max		= 100;				//PV max
	global.life			= global.life_max;	//PV initial et actuel
	
	//GAME OVER : l'écran de game over est controllé par o_DrawGUIGame
	global.gameover		= false;			//Si PV <= 0
	global.meltdown_num	= 0;				//Nombre de mort du player

		
#endregion
	
#region VISUEL

	enum COL {
		WHITE	= #ADC3B4,	//#CCCCCC,
		BLACK	= #1f1a11,
		RED		= #CC1B3B,
		ORANGE	= #FF5131,
		YELLOW	= #E2EF25,
		YGREEN	= #ACDF34,
		LGREEN	= #20F57C,	//#1E996C,	
		GREEN	= #12C44D,
			WATER	= #20F5CE,	//#27ECB4, 
		INDIGO	= #2D46E6,
	}

	//SET THE GUI SIZE
	global.game_width = 1920; //960; //320; //750;	//Ces valeurs remplacent les précédentes gui_w et gui_h
	global.game_height = 1080; //540; //180; //420;
	//Association du GUI avec les nouvelles valeurs de la room
	display_set_gui_size(global.game_width, global.game_height);

	global.gui_w = display_get_gui_width();
	global.gui_h = display_get_gui_height();


		enum RES {
			CELLSIZE	= 16,
			W			= 320,	//480,	//Taille en vrai pixels (1920)
			H			= 180,	//270,	//Taille en vrai pixels (1080)
			SCALE		= 4,
		};
	
		cell		= RES.CELLSIZE;	
		global.mix	= RES.W / 2;
		global.miy	= RES.H / 2;	

		#region SET THE WINDOW SIZE (16:9)
		/*
			wi = 0;	
			//Scale : 	1		2,...	3		4		4,...	6
			window_w = [320,	854,	960,	1280,	1366,	1920];	//Tailles possibles de fenêtres
			window_h = [180,	480,	540,	720,	768,	1080];
			wi_max = array_length(window_w);	//Nombre de choix de tailles
			//global.window_w = window_w[wi_max - 1];		//Taille actuelle choisie w (par défaut la plus grande)
			//global.window_h = window_h[wi_max - 1];		//Taille actuelle choisie h (par défaut la plus grande)
			global.window_w = window_w[3];		//Taille actuelle choisie w 
			global.window_h = window_h[3];		//Taille actuelle choisie h*/
		#endregion 
	
		scales = [1, 2, 4, 6]; sc_max = array_length(scales) - 1;
		sc = 3;
		scale = scales[sc];
		//window_set_size(RES.WIDTH * RES.SCALE, RES.HEIGHT * RES.SCALE);
		
		scale = 4;
		window_set_size(RES.W * scale, RES.H * scale);
		//window_set_size(160 * RES.SCALE, 90 * RES.SCALE);
	
		

	nb_cell_x = floor(RES.W / RES.CELLSIZE);
	nb_cell_y = floor(RES.H / RES.CELLSIZE);
	//nb_cell_x = floor(room_width / RES.CELLSIZE);
	//nb_cell_y = floor(room_height / RES.CELLSIZE);

	//SET THE WINDOW SIZE (16:9)
	wi = 0;												//window increment	
	window_w = [320, 854, 960, 1280,	1366,	1920];	//Tailles possibles de fenêtres
	window_h = [180, 480, 540, 720,		768,	1080];
	wi_max = array_length(window_w);	//Nombre de choix de tailles
	//global.window_w = window_w[wi_max - 1];		//Taille actuelle choisie w (par défaut la plus grande)
	//global.window_h = window_h[wi_max - 1];		//Taille actuelle choisie h (par défaut la plus grande)
	global.window_w = window_w[3];		//Taille actuelle choisie w 
	global.window_h = window_h[3];		//Taille actuelle choisie h

#endregion 


#region SOUND & MUSIC
	
	global.music_active		= true;		//Active ou désactive toutes les musiques
	global.sound_active		= true;
	global.master_volume	= 1;		//Volume de tous les sons & musiques
	global.music_volume		= 1;		//Volume de toutes les musiques
	global.sound_volume		= 1;		//Volume de tous les sons

#endregion


#region COLLISIONS

	if(room != rm_init)
	{
		if(layer_exists("Tiles_water") == true)	{ global.tilemap_water = layer_tilemap_get_id("Tiles_water"); }
		else									{ global.tilemap_water = noone; }
	}

#endregion


