///@desc SURFACE LIGHT
//("Draw_73" dans le dossier = DESSINER LA FIN)
//tuto : https://www.youtube.com/watch?v=Q_RAGnirITo (Simple 2D Lighting - GameMaker Tutorial, DragoniteSpam)


if(draw_halo_light == false) //|| (room == rm_menu) 
{ exit; }

//On mets les choses visuelles ici pour qu'elles soient dessinées par dessus tout
//part_system_drawit(global.particle_system); //si j'avais un particle system

var _camera = view_get_camera(0);

if(surface_exists(self.light_surface) == false)
{
	//On la crée au cas où, mais normalement elle est déclarée dans CREATE
	//var _camera = view_get_camera(0);
	var _cam_w = camera_get_view_width(_camera);
	var _cam_h = camera_get_view_height(_camera);
	
	self.light_surface = surface_create(_cam_w, _cam_h);
	
}

surface_set_target(self.light_surface);

draw_clear(color_dark);
camera_apply(camera);

//OK MTN LES BLENDMODES
gpu_set_blendmode(bm_subtract);
//gpu_set_blendmode(bm_one);	//joli


#region ASSIGNATION DES SOURCES LUMINEUSES

	//var _s = 1 + ( 0.1 * sin(current_time / 500 ));	//Oscillation
	//var _s = 1 + ( (0.1) * sin( (current_time+random_range(-0.1, 0.1)) / 500 ));	//Oscillation
	var _s				= scale + ( (0.05) * sin( (current_time) / 500 ) );	//Oscillation
	var _halo			= halo;
	var _halo_small		= halo_small;
	var _halo_spark		= halo_spark;
	var _alpha_medium	= alpha_medium;
	var _alpha_low		= alpha_low;
	
	with(player)
	{
		//draw_sprite_ext(_halo, 0, self.x, self.y - head_y, _s, _s, 0, c_white, 1);
		var _proportion = 1;
		if(water_state != PLAYER_HUMIDITY.RAGE)
		{
			//_proportion = lerp(0.5, 1.2, humidity/100);
			_proportion = lerp(0.5, 1.5, humidity/100);
		}
		else{ _proportion = 2; }
		var _scale = _proportion + ( (0.05) * sin( (current_time) / 500 ) );
		
		draw_sprite_ext(_halo, 0, drop_x, drop_y, _scale, _scale, 0, c_white, 1);
	}
	with(flore)
	{
		if(fire_state == FIRE_STATE.BURNING)
		{
		draw_sprite_ext(_halo, 0, self.x, self.y - 8, _s, _s, 0, c_white, 1);
		}
	}
	with(obj_pnj_fourmi)
	{
		draw_sprite_ext(_halo, 0, self.x, self.y - 8, _s, _s, 0, c_white, 1);
	}
	with(obj_pnj_droplet)
	{
	//	draw_sprite_ext(_halo, 0, self.x, self.y - 8, _s/2, _s/2, 0, c_white, _alpha_low);
	}
	with(obj_pnj_leaf_parent)
	{
	//	draw_sprite_ext(_halo, 0, self.x, self.y - 8, _s/2, _s/2, 0, c_white, _alpha_low);
	}
	
//FIRES
	with(obj_fire_medium)
	{	
		//draw_sprite_ext(_halo_small, 0, self.x, self.y - cell, _s, _s, 0, c_white, 1);
		draw_sprite_ext(_halo, 0, self.x, self.y - cell, _s/2, _s/2, 0, c_white, 1);
	}
	with(obj_fire_small)
	{
		//draw_sprite_ext(_halo_small, 0, self.x, self.y, _s/2, _s/2, 0, c_white, 1);//
		draw_sprite_ext(_halo, 0, self.x, self.y, _s/3, _s/3, 0, c_white, 1);
	}
	with(obj_fire_torch)
	{
		//draw_sprite_ext(_halo_small, 0, self.x, self.y, _s/2, _s/2, 0, c_white, 1);
		draw_sprite_ext(_halo, 0, self.x, self.y, _s/3, _s/3, 0, c_white, 1);
	}
	with(spark)
	{
		draw_sprite_ext(_halo, 0, self.x, self.y, _s/6, _s/6, 0, c_white, 1);
	}
	
	with(obj_pnj_feu_follet)
	{
		draw_sprite_ext(_halo, 0, self.x, self.y, _s, _s, 0, c_white, 1);
	}
	with(obj_item_parent)
	{
	//	draw_sprite_ext(_halo_small, 0, self.x, self.y, _s/2, _s/2, 0, c_white, 1);
	}
	with(faune)
	{
	//	draw_sprite_ext(_halo_small, 0, self.x, self.y - cell, _s/2, _s/2, 0, c_white, _alpha_low);
	}

	
#endregion


gpu_set_blendmode(bm_normal);

surface_reset_target();

//Quand on utilise les surface, GM reset la camera pour qu'elle se target sur l'origine 0, 0.
//Et ça fout le bordel avec la caméraaaa
/*
@xa447
so this completely breaks full screen, what do

@DragoniteSpam
draw the application surface stretched with the dimensions of window_get_width() and window_get_height() like the light surface



