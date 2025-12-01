///@desc PARTICULE DE FEU qui se PROPAGE

cell = RES.CELLSIZE;

//MOVE
move_x_max	= cell/4;
move_y_max	= - cell/5;
move_x		= random_range(- move_x_max, move_x_max);	//Direction aléatoire
move_y		= random_range(move_y_max, move_y_max + 8);	//"Saut" initial
//move_y	= random_range(-2, -5);

//SPRITE
image_blend = merge_color(COL.RED, COL.ORANGE, random(1));
image_speed = random_range(0.8, 1.2);

//Diminution de l'alpha
alpha_decay = 0.005;

flamable_ray = sprite_get_width(sprite_index);


//Trajectoire (particules identiques mais immobiles)
can_create_trainee	= true;

if(can_create_trainee == true)
{
	alarm_trainee			= 1;
	trainee_latency			= 10;
	alarm[alarm_trainee]	= trainee_latency;
}
