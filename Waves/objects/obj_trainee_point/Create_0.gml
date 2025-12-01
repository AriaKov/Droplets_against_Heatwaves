///@desc TRACES DE PAS	

//SCALE
scale_init		= 2;	//puis 1 puis reste à 1 puis disparait
scale			= scale_init;
image_xscale	= scale;
image_yscale	= scale;

reduce		= true; //true pour effet marcher sur la braise :3
time_reduce = 15;

if (reduce == true) { alarm[0] = time_reduce;	} //Reduce scale
else
{
	scale = 1;	
}
alarm[1] = 120 / global.time_speed;	//Destroy


// Je ne peux pas utiliser ces effets avec la contrainte "Gameboy 160x144 et 4 couleurs"
alpha		= 0.5;
image_alpha = alpha;

scale_max		= 0.6;
scale_min		= 0.2;
scale			= scale_max;
image_xscale	= scale_max;
image_yscale	= scale_max;


