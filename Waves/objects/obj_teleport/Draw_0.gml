///@desc 

//draw_self();

if(show_indicator == true)	//Indicateur visuel de la possibilité d'action
{
		draw_set_alpha(indic_alpha);
		draw_set_color(indic_color);
	
		var _indic_speed = indic_img_counter * indic_img_speed / global.game_speed;
		var _x = mean(x, player.x, player.x);
		var _y = mean(y, player.y, player.y); // + decalage_y;
		
	draw_sprite_ext(indic, _indic_speed, _x, _y, 1, 1, indic_dir, indic_color, indic_alpha);	
	
		draw_set_font(fnt_gui);
		draw_set_align(0, 0);
		var _s = 0.5;
		var _c = indic_color;
		
	draw_text_transformed_color(_x, _y, "", _s, _s, 0, _c, _c, _c, _c, indic_alpha);
	
		draw_set_alpha(1);
		draw_set_align();
}




