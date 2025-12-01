///@desc DRAW DROPLET

draw_set_color(COL.WATER);
draw_set_alpha(0.5);
var _s = 1;


//Jambes
	var _legs_speed = leg_img_counter * leg_speed / global.game_speed;
//	draw_sprite_ext(leg, _legs_speed, x - leg_esp, y, _s, _s, 0, face_color, 1);	//Jambe gauche
//	draw_sprite_ext(leg, _legs_speed, x + leg_esp, y, - _s, _s, 0, face_color, 1);	//Jambe droite
	draw_sprite_ext(leg, _legs_speed, x - leg_esp_x, y - leg_esp_y, _s, _s, 0, face_color, 1);	//Jambe gauche
	draw_sprite_ext(leg, _legs_speed, x + leg_esp_x, y - leg_esp_y, - _s, _s, 0, face_color, 1);	//Jambe droite

//if(state == PNJ_DANCING_STATE.DANCE)
{
	//Bras qui ondulent <3
		var _arms_speed = leg_img_counter * arm_speed / global.game_speed;
		draw_sprite_ext(arm, _arms_speed, x - arm_esp, drop_y, - _s, _s, 0, face_color, 1);		//Bras gauche
		draw_sprite_ext(arm, _arms_speed, x + arm_esp, drop_y, _s, _s, 0, face_color, 1);		//Bras droit
}	


//Corps (bulle d'eau) = Ellipse
	//draw_circle(x, y - head_y, drop_ray, false);	
	//draw_ellipse(drop_x - drop_ray, drop_y - drop_ray, drop_x + drop_ray, drop_y + drop_ray, false);	//Ok mtn ajouter les ocsillations
	draw_ellipse(drop_x - drop_rayx, drop_y - drop_rayy, drop_x + drop_rayx, drop_y + drop_rayy, false);
	
	
//Visage de la bulle d'eau
	draw_sprite_ext(face, face_img, drop_x, drop_y, _s, _s, 0, face_color, 1);
	
	draw_set_alpha(1);

//draw_set_color(c_yellow);
//draw_circle(x, y, 2, false);

	if(global.debug == true)
{	
	//if(point_in_circle(mouse_x, mouse_y, x, y, ray_action) == true)
	{
	//	draw_circle(x, y, ray_alert, true);
		
		_s			= 0.5;
		draw_set_align(0, -1);
		var _sep	= 8;
		var _i		= 0;
		draw_text_transformed(x, y + (_i * _sep), string(name), _s, _s, 0); _i++;
	//	draw_text_transformed(x, y + (_i * _sep), "drop_y : " + string(drop_y), _s, _s, 0);	_i++;
	//	draw_text_transformed(x, y + (_i * _sep), string(facing_str), _s, _s, 0);	_i++;
	//	draw_text_transformed(x, y + (_i * _sep), string(move_state_str), _s, _s, 0);	_i++;
		draw_text_transformed(x, y + (_i * _sep), string(state_str), _s, _s, 0);	_i++;
		draw_text_transformed(x, y + (_i * _sep), string(humidity), _s, _s, 0); _i++;
	//	draw_text_transformed(x, y + (_i * _sep), "counter : " + string(counter), _s, _s, 0);	_i++;
	//	draw_text_transformed(x, y + (_i * _sep), string(face_img), _s, _s, 0);	_i++;
	}	
}

