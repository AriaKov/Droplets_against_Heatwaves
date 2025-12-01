///@desc SCALE

//scale = random_range(0.8, 1.2);
scale = 1;

//Dans les variables
//	random_scale			= true;	
//	random_x_orientation	= true;
//	random_y_orientation	= true;
//	depends_on_time_speed	= false;
//	stops_if_pause			= true;
//	color					= c_white;
//	time_destroy			= random_range(0.5, 1);

if(random_scale == true)
{
	scale = random_range(0.5, 1.5); 
	image_xscale = choose(-scale, scale);
	image_yscale = choose(-scale, scale);
}

if (random_x_orientation == true) { image_xscale = choose(-scale, scale); }
if (random_y_orientation == true) { image_yscale = choose(-scale, scale); }

//if (blend_global_white == true) { image_blend = COL.WHITE; }
image_blend = color;

depth = -20000;

//Diminution de l'alpha
image_alpha = alpha_init;
alpha_decay = 0.005;

alarm[10] = time_destroy * global.game_speed;
