///@desc GUI

//	if(global.pause == false) exit;

/*

if(storage_by_grid == false)
{
		var _x		= cell * 4;
		var _y		= cell * 4;
		var _s		= 2;
		var _sep	= cell * _s;
		var _w		= 600 * _s;
		var _i		= 0;
		
		draw_set_align();
		draw_set_color(c_blue);
		draw_set_alpha(1);
	
	var _p = 0;	//Plante index
	repeat(array_length(global.graines) - 1)
	{
		var _obj	= global.graines[_p][xx_quantity];
		var _name	= object_get_name(_obj);
		var _qty	= global.graines[_p][xx_quantity];
		
		draw_text_transformed(_x, _y + (_sep * _p), string(_qty) + " x " + string(_name), _s, _s, 0);
		_p++;
	}
}

