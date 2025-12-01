///@desc ALPHA--

if(global.pause == false)
{
	y += move_y;

	floatting_sinusoidal_x(self, self, 0.01 + rand_per, 0.51 + rand_amp);


	/*
	//Réduction de la taille
	scale -= 0.005;
	//if(scale <= scale_min){ scale = scale_min; }
	if{scale <= 0) instance_destroy();
	
	//scale /= 2;

	//if scale < (scale_init/4) instance_destroy();
	*/
	
	image_alpha		-= alpha_decay;
	if(image_alpha <= 0){ instance_destroy(); }
}

	image_xscale = scale;
	image_yscale = scale;
	