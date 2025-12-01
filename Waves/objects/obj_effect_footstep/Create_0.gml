///@desc FOOTSTEPS

image_speed		= 0;
image_index		= irandom(image_number - 1);

scale_init		= 1;
scale			= scale_init;
image_xscale	= scale;
image_yscale	= scale;

reduce			= false; //true pour effet marcher sur la braise :3
time_reduce		= 15;

if(reduce == true) { alarm[0] = time_reduce;	} //Reduce scale

//alarm[10] = 120 / global.time_speed;	//Destroy

image_blend		= COL.WATER;


image_alpha		= random_range(0.2, 0.3);
alpha_decay		= random_range(0.005, 0.001);

scale_max		= 1;
scale_min		= 0.2;
scale			= scale_max;
image_xscale	= scale;
image_yscale	= scale;


