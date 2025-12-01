///@desc DRAW + DEBUG

draw_self();


if (global.debug == false) exit;
	
	var _c = c_red;
	draw_set_alpha(0.5);	
	
	_c = c_red;			draw_circle_color(x, y, rayon_alert, _c, _c, true);
	_c = c_green;		draw_circle_color(x, y, rayon_near, _c, _c, true);
	_c = c_yellow;		draw_circle_color(x, y, rayon_alert * rayon_lacherlagrappe, _c, _c, true);
	
	draw_set_color(c_orange);
	//draw_line_width(x, y, target.x, target.y, 1);
	
	draw_set_align(0, -1);
	draw_set_color(c_orange);
	draw_set_alpha(1);	
	var _sep	= 8;
	var _w		= 600;
	var _sc		= 0.5;
	var _i		= 0;
	draw_text_ext_transformed(x, y + 32 + (_i*_sep), string(name), _sep, _w, _sc, _sc, 0); _i++;
	draw_text_ext_transformed(x, y + 2 + (_i*_sep), string(state_str), _sep, _w, _sc, _sc, 0); _i++;
	//draw_text_ext_transformed(x, y + 2 + (_i*_sep), string(alarm[0]), _sep, _w, _sc, _sc, 0); _i++;
	//draw_text_ext_transformed(x, y + 2 + (_i*_sep), "move_speed : " + string(move_speed), _sep, _w, _sc, _sc, 0); _i++;
	//draw_text_ext_transformed(x, y + 2 + (_i*_sep), "speed : " + string(speed), _sep, _w, _sc, _sc, 0); _i++;
	//draw_text_ext_transformed(x, y+2 + (_i*_sep), "dir : " + string(floor(direction)), _sep, _w, _sc, _sc, 0); _i++;
	//draw_text_ext_transformed(x, y+2 + (_i*_sep), "dir_init : " + string(floor(dir_init)), _sep, _w, _sc, _sc, 0); _i++;
	//draw_text_ext_transformed(x, y+2 + (_i*_sep), string(dir_init), _sep, _w, _sc, _sc, 0); _i++;






/*

if(global.debug == false) { exit; }

//	if(instance_exists(self))
	{
//		with(self)
		{
			draw_set_alpha(0.3);
			var _c = c_yellow;

			//Centre
			//draw_circle_color(x,y,16, _color, _color, 0);

			//Rayons d'alerte et d'attaques
			
			draw_set_alpha(1);
			draw_circle_color(x, y, rayon_alert, _c, _c, true);
			draw_set_alpha(0.5);
			draw_circle_color(x, y, rayon_alert * rayon_lacherlagrappe, _c, _c, true);		//false = plein, true = vide


			//Affichage de l'état (0,1,2,3)
			draw_set_color(c_blue);
		//	draw_set_font(fnt_ordinarypixel_60);
			var _scale = 1;
			draw_text_ext_transformed(x, y + 10, string(state), 50, 600, _scale, _scale, 0);
			//draw_text_ext_transformed(x, y + 20, "life : " + string(life), 50, 600, _scale, _scale, 0);
		}
	}


draw_set_alpha(1);



