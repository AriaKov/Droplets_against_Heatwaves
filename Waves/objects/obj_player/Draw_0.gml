///@desc 

//draw_self();

draw_set_color(color);
//Player originel : un animal
//draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, color, image_alpha);

var _s = 1;

#region PLAYER

	if(water_state == PLAYER_HUMIDITY.RAGE)
	{
		//Corps (bulle d'eau)
			draw_set_alpha(0.9);
			draw_set_color(color_rage);
		
			draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, color_rage, image_alpha);
	
			//Visage
		//	draw_sprite_ext(face, face_img, drop_x, drop_y, _s, _s, 0, color_rage, 1);
			draw_set_alpha(1);
			
			
		#region SPRITE FIRE
		
			var _fire_speed = fire_img_counter * fire_speed / global.game_speed;
			draw_sprite(fire_spr, _fire_speed, x, y);	

		#endregion
	}
	else
	{
		//draw_set_color(COL.WATER);
		draw_set_color(color); 
		
		//Jambes
			var _legs_speed = leg_img_counter * leg_speed / global.game_speed;
			var _scalex_r	= - _s;
			var _scalex_l	= _s;
			var _asynchro	= 0;	//Walking leg alternance
			if(move_state == PLAYER_MOVE_STATE.MOVE)
			{
				_legs_speed = leg_img_counter * (leg_speed + 2) / global.game_speed;
				_asynchro = 4;
				if(move_x > 0)	{	_scalex_l = _scalex_r;	}	//to the right
				else if(move_x == 0){ _scalex_r = -_s; _scalex_l = _s; }
				else			{	_scalex_r = _scalex_l; }
			}
			
		//	draw_sprite_ext(leg, _legs_speed, x - leg_esp_x, y, _s, _s, 0, face_color, 1);	//Jambe gauche
		//	draw_sprite_ext(leg, _legs_speed, x + leg_esp_x, y, - _s, _s, 0, face_color, 1);	//Jambe droite
			draw_sprite_ext(leg, _legs_speed, x - leg_esp_x, y - leg_esp_y, _scalex_l, _s, 0, face_color, 1);	//Jambe gauche
			draw_sprite_ext(leg, _legs_speed + _asynchro, x + leg_esp_x, y - leg_esp_y, _scalex_r, _s, 0, face_color, 1);	//Jambe droite
			

		//Bras qui ondulent <3
			_asynchro = 6;
			var _arms_speed = leg_img_counter * arm_speed / global.game_speed;
			draw_sprite_ext(arm, _arms_speed, x - arm_esp, drop_y, - _s, _s, 0, face_color, 1);	//Bras gauche
			draw_sprite_ext(arm, _arms_speed + _asynchro, x + arm_esp, drop_y, _s, _s, 0, face_color, 1);	//Bras droit
	
		//Corps (bulle d'eau)
			draw_set_alpha(0.5);
			//draw_circle(x, y - head_y, drop_ray, false);	
			//draw_ellipse(drop_x - drop_ray, drop_y - drop_ray, drop_x + drop_ray, drop_y + drop_ray, false);	//Ok mtn ajouter les ocsillations
			draw_ellipse(drop_x - drop_rayx, drop_y - drop_rayy, drop_x + drop_rayx, drop_y + drop_rayy, false);
	
		//Visage
		var _decalage = 2;
		var _xbuff = 0; var _ybuff = 0;
			if(move_state == PLAYER_MOVE_STATE.MOVE)
			{
				if(move_x > 0)		{	_xbuff = _decalage;	}	//to the right
				else if(move_x == 0){	_xbuff = 0; }
				else				{	_xbuff = -_decalage; }	//left
				if(move_y > 0)		{	_ybuff = _decalage;	}	//down
				else if(move_y == 0){	_ybuff = 0;	}
				else				{	_ybuff = -_decalage; }	//up
			}
			draw_sprite_ext(face, face_img, drop_x + _xbuff, drop_y + _ybuff, _s, _s, 0, face_color, 1);
			draw_set_alpha(1);

	}

#endregion


	if(global.debug == true) || (show_debug == true)
{
	draw_set_color(c_yellow);
	draw_set_alpha(0.1);
//	draw_circle(x, y, ray_action, false);
	draw_set_alpha(1);
	
	//if(point_in_circle(mouse_x, mouse_y, x, y, ray_action) == true)
	{
		
	//	draw_set_color(c_yellow);
	//	draw_circle(x, y, 2, false);
	//	draw_set_color(c_red);
	//	draw_circle(drop_x, drop_y, 2, false);


		draw_set_align(0, -1);
		_s			= 0.5;
		var _sep	= 8;
		var _i		= 0;
	//	draw_text_transformed(x, y + (_i * _sep), string(facing_str), _s, _s, 0);	_i++;
	//	draw_text_transformed(x, y + (_i * _sep), string(move_state_str), _s, _s, 0);	_i++;
	//	draw_text_transformed(x, y + (_i * _sep), string(water_state_str), _s, _s, 0);	_i++;
	//	draw_text_transformed(x, y + (_i * _sep), "humidity : " + string(humidity), _s, _s, 0);	_i++;
	//	draw_text_transformed(x, y + (_i * _sep), "global.humidity : " + string(global.humidity), _s, _s, 0);	_i++;
	//	draw_text_transformed(x, y + (_i * _sep), string(face_img), _s, _s, 0);	_i++;
	}
	
		draw_set_alpha(0.2);
		draw_set_color(c_white);
	//	draw_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, false);
		draw_set_alpha(1);	
}







