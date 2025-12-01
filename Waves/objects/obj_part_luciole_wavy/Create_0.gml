///@desc LUCIOLES (cf. MEDUSA PLANKTON)

//rayon_action = 32;
//espace = 10;

player = obj_player;

if(instance_exists(player) == false){ target = noone; }
else { target = player; }

always_visible = choose(true, false, false, false, false, false);
always_visible = true;

enum LUCIOLE { FREE, FLYAWAY }
state		= LUCIOLE.FREE;
state_str	= "FREE";

#region RANDOMISER CHAQUE INSTANCE 

	scale = 1;
	image_xscale = scale;
	image_yscale = scale;

	//Choix d'une sub_image du sprite
	image_index = irandom_range(0, sprite_get_number(sprite_index) - 1);
	image_speed = 0;
	
	//Alpha & Blend
	//image_alpha = random_range(0.3, 0.9);
	image_alpha = random_range(0.4, 0.8);
	rd			= random(0.7);
	rd			= random_range(0.2, 0.8);
	//color		= merge_color(COL.ORANGE, COL.YELLOW, rd);
	color		= merge_color(COL.WATER, COL.YELLOW, rd);
	image_blend	= color;
	
	//Oscillation sur x
	per			= 0.01;	per = 0.001;
	amp			= 0.01;	amp = 0.2;
	rand_period = random(0.1);
	rand_period = random(0.2);	rand_period = random(0.02);
	rand_amp	= random(0.1);
	rand_amp	= random(0.2);
	
	move_x = 0;
	move_y = 0;
	move_speed_x = random_range(-0.08, 0.08);
	move_speed_y = random_range(-0.05, 0.05);
	
		//RANDOM MOVE (NEW depuis WAVES : les lucioles se déplacent quand même)
		dir = irandom_range(1, 359);
		move_speed = 1;
		
		
#endregion

//rayon_action = 50;
//espace = 10;	//Espace d'écartement

fuir		= true;
balancement = false;

//ANGLE
angle			= 0;	
angle_naturel	= 20;	//Vent, ...
angle_max		= 180;	//50; //Action de player

//if(instance_exists(global.player)){	target = global.player; }
//else {	target = obj_follow_mouse; }

//target = obj_follow_mouse;
dist_x = 0;



