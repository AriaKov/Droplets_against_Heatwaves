///@desc FADE OUT

global_var_to_local();

//Le fade out (écran noir progressif) se fait que si fade_out == true dans les variables.
//fade_out
fade_out_active	= false;

alpha_min	= 0;
alpha_max	= 1;
alpha		= alpha_min;
alpha_add	= 0.007;

color		= COL.BLACK;
	

//Indicateur visuel de la possibilité de direction
show_indicator		= false;
indic 				= spr_indicator_teleport;
//indic_dir			= 0;	//0 = RIGHT, 90 = UP, 180 = L, 270 = DOWN
indic_img			= 0;
indic_img_counter	= 0;
indic_img_speed		= 8;
indic_color			= COL.WHITE;
indic_alpha			= 1;

