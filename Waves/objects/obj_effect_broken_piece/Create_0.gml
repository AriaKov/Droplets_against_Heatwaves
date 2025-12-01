///@desc BROKEN PIECE OF THE OBJECT CALLING

global_var_to_local();

image_speed = 0;
image_blend = COL.YGREEN;
image_index = irandom(image_number - 1);
image_angle = choose(0, 90, 180, 270);
image_xscale = choose(-1, 1);
image_alpha = 1;
alpha_decay = 0.005;

move_x_max	= cell/4;
move_y_max	= - cell/3;	
move_x		= random_range(- move_x_max, move_x_max);		//Direction aléatoire
move_y		= random_range(move_y_max - 3, move_y_max + 2);	//"Saut" initial
//move_y	= random_range(-2, -5);


//Destruction automatique
alarm[10] = random_range(0.1, 1) * global.game_speed;

//En cas de pause, on sauvegarde le temps restant
has_just_been_paused	= false;	//Pour ne redémarrer l'alarme qu'une fois après la pause	
time_remaining			= alarm_get(10);



