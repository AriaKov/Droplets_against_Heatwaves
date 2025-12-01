///@desc DRAW + DEBUG

draw_self();

	draw_set_align(0, -1);
	draw_set_color(c_blue);
	draw_set_alpha(1);	
	var _c		= c_red;
	var _sep	= 8;
	var _w		= 600;
	var _s		= 0.5;
	var _i		= 0;
	
if(global.debug == true)
{	
	var _name = object_get_name(object_index);	_name	= name;
	draw_text_ext_transformed(x, y + 32 + (_i*_sep), string(_name), _sep, _w, _s, _s, 0); _i++;
}	
	
	
	
	
	