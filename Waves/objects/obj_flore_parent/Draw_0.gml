///@desc DRAW + DEBUG

#region PLANT

	//plant_oscillation_if_contact_draw();
	draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, color, 1);
	
	if(fire_state == FIRE_STATE.BURNING) //SPRITE DU FEU (? ou objet ?)
	{
		//var _fire_speed = current_time mod 60;
		var _fire_speed = fire_img_counter * fire_speed / global.game_speed;
		draw_sprite(fire_spr, _fire_speed, x, y);	
	
		// Désormais je crée carrément une instance de feu, c'est + simple (?)
	}
	// draw_self();

	if(1 == 2)
	{
		if(fire_state == FIRE_STATE.WET) //Couleur du sprite + oscillation
		{
			//L'idéal serait d'utiliser draw_sprite_pos pour faire osciller le sommet des plantes,
			//tout en appliquant les couleurs avec image_blend. MAIS cette fonction n'accepte pas de blend !! >:(
			//Sur ce forum qqu'un a le mm pb que moi : https://forum.gamemaker.io/index.php?threads/draw_sprite_pos-with-image_blend.105956/
			//Sep 28, 2023.	//Tangerine said:
			//Passing uniforms into a shader for each sprite color is the only solution I could think, but that could be a lot of batch breaks for each tree.
			//Better idea: create a vertex buffer with all the trees in it, and give each vertex a color - each tree would have the same color for all four vertices that it consists of. (This is basically how image_blend works under the hood). And for the swaying, you could let the vertex shader displace the vertices using a time uniform and some per-tree specific angle offset parameter passed in using either a custom vertex format data point, or maybe you could just use the alpha channel (which comes with the color vertex format member for free) for this to simplify things.
			//Since all the trees are a single vertex buffer, you can draw them all as a single draw call, not just a single batch!

			var _x1 = x - (spr_w/2) + wind_osc;	//Top left (oscille horizontalement)
			var _y1 = y - spr_h + ((cos(wind_osc_per * current_time) * wind_osc_amp)/4);
			var _x2 = x + (spr_w/2) + wind_osc;	//Top Right (oscille horizontalement)
			var _y2 = _y1;
			var _x3 = x + (spr_w/2);	//Bottom Right (stable)
			var _y3 = y;
			var _x4 = x - (spr_w/2);	//Bottom Left (stable)
			var _y4 = y;
			draw_set_color(color);
			draw_sprite_pos(sprite_index, image_index, _x1, _y1, _x2, _y2, _x3, _y3, _x4, _y4, 0.8);		
		}

		else // Color blend ROUGE + PAS d'oscillation
		{
			draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, c_red, 1);
		}
	}

#endregion

var _s =	1;


	if(global.debug == true) || (show_debug == true) //&& (plant_size == 2)
{
//	if(point_in_circle(mouse_x, mouse_y, x, y, ray_fire_propagation/2) == true)
//	if(point_in_circle(display_mouse_get_x(), display_mouse_get_y(), x, y, 16) == true)
//	if(point_in_circle(player.x, player.y, x, y, 32) == true)
	{
		var _x		= x;
		var _y		= y + 16;
		var _sep	= cell * 0.75;
		var _w		= 1000;
		var _i		= 0;
		_s			= 0.5;
		
		draw_set_font(fnt_gui);
		draw_set_color(c_white);
		var _c = c_white;
		switch(fire_state){
			case FIRE_STATE.WET:		_c = c_blue;	break;
			case FIRE_STATE.DRY:		_c = c_green;	break;
			case FIRE_STATE.BURNING:	_c = c_red;		break;
			case FIRE_STATE.BURNED:		_c = c_yellow;	break;
		}
		draw_set_color(_c);
		draw_set_color(color);
		//draw_circle(x, y, 1, false);
	//	draw_circle_color(x, y, ray_fire_propagation, color, color, true);
	
		draw_set_align(0, -1);
	//	draw_text(x, y + (_i * _sep), string(hue) + " - " + string(hue_difference) + " = " + string(hue_fire));	_i++;
		//draw_text(x, y + (_i * _sep), "-"+string(hue_difference));	_i++;
		//draw_text(x, y + (_i * _sep), string(hue_fire));	_i++;
	//	draw_text_transformed(_x, _y + (_i * _sep), string(image_blend), _s, _s, 0);	_i++;
	//	draw_text_transformed(_x, _y + (_i * _sep), string(color_burned_amt), _s, _s, 0);	_i++;
		
		draw_text_transformed(_x, _y + (_i * _sep), string(fire_state_str), _s, _s, 0);	_i++;
		draw_text_transformed(_x, _y + (_i * _sep), string(ceil(humidity)), _s, _s, 0);	_i++;
		draw_text_transformed(_x, _y + (_i * _sep), string(floor(fire_duration)) + " : " + string(death_probability), _s, _s, 0);	_i++;
		
	//	draw_text_transformed(_x, _y + (_i * _sep), string(humidity) + " / " + string(humidity_max), _s, _s, 0);	_i++;
	//	draw_text_transformed(_x, _y + (_i * _sep), "spark : " + string(alarm[alarm_spark]), _s, _s, 0);	_i++;
	//	draw_text_transformed(_x, _y + (_i * _sep), "propagation : " + string(alarm[alarm_propagation]), _s, _s, 0);	_i++;
		
	//	draw_text_transformed(_x, _y + (_i * _sep), string(plant_object) + ", size " + string(plant_size), _s, _s, 0);	_i++;
		
	//	draw_text_transformed(_x, _y + (_i * _sep), string(plant_name), _s, _s, 0);	_i++;
	//	draw_text_transformed(_x, _y + (_i * _sep), string(fire_state_str) + " : " + string(fire_stage) + "/" + string(fire_stage_max) + " ", _s, _s, 0);	_i++;
	
	//	draw_text_transformed(_x, _y + (_i * _sep), string(growth_stage_str), _s, _s, 0);	_i++;
	//	draw_text_transformed(_x, _y + (_i * _sep), "img " + string(image_index) + " / " + string(img_max), _s, _s, 0);	_i++;
	//	draw_text_transformed(_x, _y + (_i * _sep), "dont " + string(img_young_number) + " pour young", _s, _s, 0);	_i++;
	//	draw_text_transformed(_x, _y + (_i * _sep), "image_index : " + string(image_index), _s, _s, 0);	_i++;
	//	draw_text_transformed(_x, _y + (_i * _sep), "days " + string(days) + " / " + string(days_max), _s, _s, 0);	_i++;
	//	draw_text_transformed(_x, _y + (_i * _sep), "seeds_propagated " + string(seeds_propagated) + " / " + string(seed_num_total), _s, _s, 0);	_i++;
	
			
	}


			draw_set_alpha(0.2);
			draw_set_color(c_white);
		//	draw_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, false);
			draw_set_alpha(1);
		
}



#region HUMIDITY HEALTHBAR
	
	if(global.debug == true) || (show_debug == true) 
//	if(instance_exists(player) == true) // && (1 == 2)
//	&& (point_in_circle(player.x, player.y, x, y, ray_fire_propagation) == true) 
	{
		var _hw = cell;
		var _hh = 1;
		var _hx = x - _hw/2;
		var _hy = y + 10;
	
			var _col = c_red;
		//	if(fire_state == FIRE_STATE.BURNING){ _col = COL.RED; } 
		//	if(fire_state == FIRE_STATE.NORMAL)	{ _col = COL.ORANGE; } 
	
		//	draw_healthbar(_hx, _hy, _hx + _hw, _hy + _hh, humidity, _col, COL.WATER, COL.WATER, 1, true, false);
		
		//Jauge d'humidité de 0 à 100%
		var _humidity_proportion = (humidity * 100) / humidity_max;
		draw_healthbar(_hx, _hy, _hx + _hw, _hy + _hh, _humidity_proportion, COL.ORANGE, COL.WATER, COL.WATER, 0, true, false);
		
		_s = 1;
		draw_set_color(c_white);
		draw_set_align(0, -1);
		//draw_text_transformed(_hx + _hw/2, _hy + 3, string(ceil(humidity)), _s, _s, 0);
	//	draw_text_transformed(_hx + _hw/2, _hy + 3, string(ceil(humidity)) + " /" + string(humidity_max), _s, _s, 0);
	}
		
#endregion





