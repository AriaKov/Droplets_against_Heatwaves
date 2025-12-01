///@desc FOOTSTEPS

//	image_speed		= 0;
//	image_index		= irandom(image_number - 1);

scale_init		= 1;
scale			= scale_init;
image_xscale	= choose(-1, 1);
image_yscale	= scale;

reduce			= false; //true pour effet marcher sur la braise :3
time_reduce		= 15;

if(reduce == true) { alarm[0] = time_reduce;	} //Reduce scale

//alarm[10] = 120 / global.time_speed;	//Destroy

image_blend		= COL.WHITE;


image_alpha		= random_range(0.3, 0.1);
alpha_decay		= random_range(0.007, 0.001);

scale_max		= 1;
scale_min		= 0.2;
scale			= scale_max;
image_xscale	= scale;
image_yscale	= scale;

//////
//floatting
timer		= 0;	
r = random(0.001)
rand_amp	= random(0.1);	rand_amp	= 0.08 + r;
rand_per	= random(0.1);	rand_per	= 0.001 + r;

move_y		= - 0.4;
move_y		= - 1;

