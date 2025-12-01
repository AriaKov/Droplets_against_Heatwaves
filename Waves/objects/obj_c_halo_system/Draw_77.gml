///@desc SURFACE LIGHT
//("Draw_77" dans le dossier = POST-DESSIN)
//tuto : https://www.youtube.com/watch?v=Q_RAGnirITo (Simple 2D Lighting - GameMaker Tutorial, DragoniteSpam)

//if(room == rm_menu) exit;


	//draw_surface(application_surface, 0, 0);	//Comme ça, ça ne va prendre en compte que les pixels réels (320x180)
	draw_surface_stretched(application_surface, 0, 0, window_get_width(), window_get_height());

	//DEBUG
	//o_cycle_day_night.draw_daylight = false;


if (draw_halo_light == true)
{ 
	if (instance_exists(obj_c_cycle_day_night) == true)
	{
		//alpha_surface_dark = 0.75;
	//	alpha_surface_dark = obj_c_cycle_day_night.darkness - 0.2;	//Dépend du cycle jour nuit
	//	alpha_surface_dark = lerp(0, obj_c_cycle_day_night.darkness, 1.5);	//Dépend du cycle jour nuit
	//	alpha_surface_dark = lerp(0, obj_c_cycle_day_night.darkness, 1);	//Dépend du cycle jour nuit
		alpha_surface_dark = lerp(0, obj_c_cycle_day_night.darkness, 3);	//Dépend du cycle jour nuit
		//un amt à 3 c'est joli, on voit encore un peu à travers l'obscurité
		//Au delà de 3 (4, 5...) l'obscurité est opaque !
		
		draw_set_alpha(alpha_surface_dark);

		draw_surface_stretched(self.light_surface, 0, 0, window_get_width(), window_get_height());

		draw_set_alpha(1);
	}
}
