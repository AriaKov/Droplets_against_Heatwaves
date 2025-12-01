///@desc ALPHA--;

if (global.pause == false) // && obj_test.balles_visibles == true)
{
	/*
	//Réduction de la taille
	scale -= 0.005;
	//if scale <= scale_min { scale = scale_min; }
	if scale <= 0 instance_destroy();
	
	//scale /= 2;

	//if scale < (scale_init/4) instance_destroy();
	*/
	
	//Transparence augmente
	alpha		-= 0.0001;
	image_alpha = alpha;
	if(alpha <= 0) { instance_destroy(); }
}

	image_xscale = scale;
	image_yscale = scale;
	