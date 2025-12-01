///@desc 

/*

	if(point_in_circle(display_mouse_get_x(), display_mouse_get_y(), x, y, 64) == true)
	{
		var _s		= 2;
		var _x		= cell * 2;
		var _y		= global.gui_h / 2 + cell*2;
		var _sep	= cell;
		var _w		= 1000;
		var _i		= 0;

		draw_set_color(color);
	//	draw_circle_color(x, y, ray_fire_propagation, color, color, true);
		draw_set_align(0, -1);

	//	draw_text(x, y + (_i * _sep), string(hue) + " - " + string(hue_difference) + " = " + string(hue_fire));	_i++;
		//draw_text(x, y + (_i * _sep), "-"+string(hue_difference));	_i++;
		//draw_text(x, y + (_i * _sep), string(hue_fire));	_i++;
	//	draw_text_transformed(_x, _y + (_i * _sep), string(fire_state_str), _s, _s, 0);	_i++;
		draw_text_transformed(_x, _y + (_i * _sep), "humidity : " + string(humidity), _s, _s, 0);	_i++;
	//	draw_text_transformed(_x, _y + (_i * _sep), "spark : " + string(alarm[alarm_spark]), _s, _s, 0);	_i++;
	//	draw_text_transformed(_x, _y + (_i * _sep), "propagation : " + string(alarm[alarm_propagation]), _s, _s, 0);	_i++;
		
		draw_text_transformed(_x, _y + (_i * _sep), "FIRESTATE : " + string(fire_state_str) + " (" + string(fire_stage) + "/" + string(fire_stage_max) + ")", _s, _s, 0);	_i++;
		draw_text_transformed(_x, _y + (_i * _sep), "GROWTH : " + string(growth_stage) + " (stage : " + string(stage) + "/" + string(image_number-1) + ")", _s, _s, 0);	_i++;

	}










