///@desc DEBUG


	if(global.debug == true)
	{
	//	draw_circle_color(x, y, rayon_action, c_yellow, c_yellow, true);	
	
			draw_set_alpha(1);
			var _s		= 0.5;
			draw_set_align(0, -1);
			var _sep	= 8;
			var _i		= 0;
		
		draw_line_width(x, y, x + lengthdir_x(16, dir), y + lengthdir_y(16, dir), 1);
		
	//	draw_text_transformed(x, y + (_i * _sep), string(state_str), _s, _s, 0);	_i++;
		draw_text_transformed(x, y + (_i * _sep), "move_x : " + string(move_x), _s, _s, 0);	_i++;
		draw_text_transformed(x, y + (_i * _sep), "move_y : " + string(move_y), _s, _s, 0);	_i++;
	}		
		



draw_self();


