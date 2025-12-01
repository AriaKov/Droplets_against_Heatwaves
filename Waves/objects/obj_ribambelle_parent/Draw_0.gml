///@desc 


draw_self();

//if (global.debug == false) exit;
	
	draw_set_align(0, -1);
	draw_set_color(c_orange);
	var _sep	= 8;
	var _w		= 600;
	var _sc		= 0.5;
	var _i		= 0;
	draw_text_ext_transformed(x, y + 2 + (_i*_sep), string(pnj_state_str), _sep, _w, _sc, _sc, 0); _i++;
	draw_text_ext_transformed(x, y + 2 + (_i*_sep), string(alarm[0]), _sep, _w, _sc, _sc, 0); _i++;
	//draw_text_ext_transformed(x, y+2 + (_i*_sep), "move_speed : " + string(move_speed), _sep, _w, _sc, _sc, 0); _i++;
	//draw_text_ext_transformed(x, y+2 + (_i*_sep), "speed : " + string(speed), _sep, _w, _sc, _sc, 0); _i++;
	//draw_text_ext_transformed(x, y+2 + (_i*_sep), "dir : " + string(floor(direction)), _sep, _w, _sc, _sc, 0); _i++;
	//draw_text_ext_transformed(x, y+2 + (_i*_sep), "dir_init : " + string(floor(dir_init)), _sep, _w, _sc, _sc, 0); _i++;
	//draw_text_ext_transformed(x, y+2 + (_i*_sep), string(dir_init), _sep, _w, _sc, _sc, 0); _i++;


	draw_set_alpha(0.3);
	var _c = c_red;
	_c = c_red;			draw_circle_color(x, y, proximite_max, _c, _c, true);
//	_c = c_orange;		draw_circle_color(x, y, ray_flyaway, _c, _c, true);
//	_c = c_blue;		draw_circle_color(x, y, ray_max, _c, _c, true);
	draw_set_alpha(1);








