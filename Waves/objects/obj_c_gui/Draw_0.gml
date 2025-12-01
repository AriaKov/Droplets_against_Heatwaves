///@desc 


//	draw_text(mx, my + 16, string(text));

/*

draw_set_color(COL.RED);
draw_set_alpha(1);

draw_sprite_stretched(box, 0, box_x, box_y, box_w, box_h);

var _s	= 1;

	
	
	if (instance_exists(source) == true)
	&& (point_distance(source.x, source.y, player.x, player.y) < 64)
	{
		draw_set_align(0, -1);
		var _sep	= 16;
		var _i		= 0;
		var _posx	= source.x;	_posx = mouse_x;
		var _posy	= source.y;	_posy = mouse_y;
		var _text	= "Absorbe water with [SPACE]";
		draw_text_transformed(_posx, _posy + (_i * _sep), _text, _s, _s, 0);	_i++;
	}


