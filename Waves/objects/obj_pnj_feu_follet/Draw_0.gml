///@desc DEBUG


	if(global.debug == true)
	{
	//	draw_circle_color(x, y, rayon_action, c_yellow, c_yellow, true);	
	
			draw_set_alpha(1);
			var _s		= 0.5;
			draw_set_align(0, -1);
			var _sep	= 8;
			var _i		= 0;
		
		var _len = 16;
	//	draw_line(x, y, x + lengthdir_x(_len, dir), y + lengthdir_y(_len, dir));
		
	//	draw_text_transformed(x, y + (_i * _sep), string(state_str), _s, _s, 0);	_i++;
	//	draw_text_transformed(x, y + (_i * _sep), "move_x : " + string(move_x), _s, _s, 0);	_i++;
	//	draw_text_transformed(x, y + (_i * _sep), "move_y : " + string(move_y), _s, _s, 0);	_i++;
	}		
		

#region SPRITE FIRE
	
	var _fire_y = y - 32;
	var _fire_speed = fire_img_counter * fire_speed / global.game_speed;
	draw_sprite(fire_spr, _fire_speed, x, _fire_y);	

#endregion
		
draw_self();

	//	_fire_y = y;
	//	draw_sprite(spr_fire_small, _fire_speed, x, _fire_y);	
		