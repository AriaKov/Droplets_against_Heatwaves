///@desc WATER > SPLASH

event_inherited();

image_speed = 0;
image_blend = COL.WATER;
image_index = irandom(image_number - 1);
image_alpha = 0.4; image_alpha = 0.7;

cell		= RES.CELLSIZE;
move_x_max	= cell/4;
move_y_max	= - cell/3;
move_x		= random_range(- move_x_max, move_x_max);		//Direction aléatoire
move_y		= random_range(move_y_max, move_y_max + 8);	//"Saut" initial
//move_y	= random_range(-2, -5);


//Destruction automatique
alarm[10] = random_range(0.1, 1) * global.game_speed;

//En cas de pause, on sauvegarde le temps restant
has_just_been_paused	= false;	//Pour ne redémarrer l'alarme qu'une fois après la pause	
time_remaining			= alarm_get(10);


//Diminution de l'alpha
alpha_decay = 0.005;

