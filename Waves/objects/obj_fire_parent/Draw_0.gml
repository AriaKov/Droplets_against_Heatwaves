///@desc 

draw_self();





if(global.debug == true)
{
	draw_set_color(c_white);
	draw_set_align(0, -1);
	var _s		= 0.5;
	var _sep	= 8;
	var _i		= 0;
		
//	draw_text_transformed(x, y + (_i * _sep), "spd : " + string(image_speed), _s, _s, 0);	_i++;

	if(automatic_destruction == true) { 
//	draw_text_transformed(x, y + (_i * _sep), "alarm[10] : " + string(alarm[10]), _s, _s, 0);	_i++;
//	draw_text_transformed(x, y + (_i * _sep), "time_remaining : " + string(time_remaining), _s, _s, 0);	_i++;
//	draw_text_transformed(x, y + (_i * _sep), "has_just_been_paused : " + string(has_just_been_paused), _s, _s, 0);	_i++;
	}
}

if(show_debug == true) 
{
	//Humidity bar
		var _hw = cell;
		var _hh = 1;
		var _hx = x - _hw/2;
		var _hy = y + 10;

		//Jauge d'humidité de 0 à 100%
		var _humidity_proportion = (humidity * 100) / humidity_max;
		draw_healthbar(_hx, _hy, _hx + _hw, _hy + _hh, _humidity_proportion, c_red, COL.INDIGO, COL.INDIGO, 0, true, false);
}		
		
		

