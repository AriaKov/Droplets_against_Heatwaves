///@desc UI

var _s = 1;
var _c = COL.BLACK;
var _a = alpha_low;

var _sep	= 8;
var _w		= cadre_pause_w;
draw_set_font(font);
var _decaly = -2;
	
if(state == SHOW_UI.MENU)		//MAIN MENU
{
	//Fond transparent
	_c = color_pause;
	draw_set_alpha(0.2);
	draw_rectangle_color(0, 0, gui_w, gui_h, _c, _c, _c, _c, false);	
	draw_set_alpha(1);
	
	//Cadre
	_c = COL.WHITE;
	var _marg = marge * 3;
	// draw_rectangle_color(_marg, _marg, gui_w - _marg, gui_h - _marg, _c, _c, _c, _c, true);	
	draw_sprite(cadre_pause, 0, mix, miy);
	//	draw_sprite_stretched(cadre_pause, 0, _marg, _marg, gui_w - (2*_marg), gui_h - (2*_marg));
	
	//Titre et crédits
	draw_set_align(0, 1);
	_s = 2;
	//Petrify //Medusa's Rebellion
	//Stone Heart: The Escape. Medusa's Rebellion. Stone-Eyed liberator. Gaze of Stone. The Gaze of Rebellion. Soulbreaker.
	//Gorgon's Escape. Gorgon's path. 
	//Medusa's\nMutiny
	// Chain breaker
	draw_text_ext_transformed_color(mix, miy - 16 + 8, "Medusa's\nMutiny", _sep, _w, _s, _s, 0, _c, _c, _c, _c, 1);
	//draw_text_ext_transformed_color(mix, miy - 16, "Petrify", _sep, _w, _s, _s, 0, _c, _c, _c, _c, 1);
	
	draw_set_align(0, -1);
	_a = alpha_low;
	_s = 1;
	draw_text_ext_transformed_color(mix, miy, "A game created by Ariako for the Pixel Game Jam 2025", _sep, _w, _s, _s, 0, _c, _c, _c, _c, _a);
	draw_set_align();
	

	//Bouton "Start"
		var _by = miy + 40 + 32;
		_a = 1;
		draw_sprite_ext(spr_ui_keyboard_space, 0, mix - space_w/2, _by, _s, _s, 0,  _c, _a);
		draw_set_align(0, 1);
		draw_text_transformed_color(mix, _by + _decaly, "Press SPACE to start", _s, _s, 0, _c, _c, _c, _c, _a);
		draw_set_align();
		
}


if(state == SHOW_UI.WARNING)	//WARNING EPILEPSY
{
	//Fond transparent
		_c = color_pause;
		draw_set_alpha(0.2);
		draw_rectangle_color(0, 0, gui_w, gui_h, _c, _c, _c, _c, false);	
		draw_set_alpha(1);
	
	//Cadre
		_c = merge_color(COL.RED, COL.WHITE, 0.3);
		draw_set_color(_c);
		var _marg = marge * 3;
		draw_sprite(cadre_pause, 0, mix, miy);
	
	//Warning epilepsy
		_a = 1;
		draw_set_align(0, 0);
		draw_text_ext_transformed_color(mix, miy - 4, warning, _sep, _w - 6, _s, _s, 0, _c, _c, _c, _c, _a);
		draw_set_align();
		
	//Bouton "Ok"
		var _by = miy + 40 + 32;
		_c = COL.WHITE;
		_a = 1;
		draw_sprite_ext(spr_ui_keyboard_space, 0, mix - space_w/2, _by, _s, _s, 0, _c, _a);
		draw_set_align(0, 1);
		draw_text_transformed_color(mix, _by + _decaly, "OK", _s, _s, 0, _c, _c, _c, _c, _a);
		draw_set_align();
		
	//Screen Shake	//C'est de la redite du code qui se trouve dans pause! mais bon
		_a		= 1;
		var _kx = marge;
		var _state = "ON";
		var _ky = miy + 64 + key_w * 1.5;
		draw_sprite_ext(key, 0, _kx, _ky, _s, _s, 0, _c, _a);
		draw_set_align(0, 1);
		draw_text_transformed_color(_kx + key_w/2, _ky + _decaly, "L", _s, _s, 0, _c, _c, _c, _c, _a);
		
		draw_set_align(-1, 1);
	//	if(global.screen_shake_active){ _state = "ON"; } else { _state = "OFF"; }
		draw_text_transformed_color(_kx + key_w + 8, _ky + _decaly, "Screen Shake : " + string(_state), _s, _s, 0, _c, _c, _c, _c, _a);
		draw_set_align();
}

	
if(state == SHOW_UI.HUD)		//HEAD UP DISPLAY
{
	//	draw_sprite_ext(petrify, 0, cell, cell, scale, scale, 0,  _c, alpha);

	_c = COL.WHITE;
	if(global.pause){ _a = 1; }
	else	{ _a = alpha_gui; }

	if(global.pause)
	{	
		//ESC (window)
		draw_sprite_ext(escape, 0, escape_x, escape_y, _s, _s, 0, _c, _a);
	}
	
	//TAB (pause)
		draw_sprite_ext(tab, 0, tab_x, tab_y, _s, _s, 0, _c, _a);

		draw_set_align(-1, 1);
		draw_text_transformed_color(tab_x + 12, tab_y + _decaly, "pause", _s, _s, 0, _c, _c, _c, _c, _a);
		draw_set_align();
	
	
	//SHIFT (Talk)
		_c = talk_color;
		draw_sprite_ext(shift, 0, shift_x, shift_y, _s, _s, 0, _c, alpha_talk);
	
		draw_set_align(-1, 1);
		draw_text_transformed_color(shift_x + 12 + 2, shift_y + _decaly, "Talk", _s, _s, 0, _c, _c, _c, _c, alpha_talk);
		draw_set_align();	
	
	//Flèches
		_c = COL.WHITE;
		draw_sprite_ext(arrows, 1, arrows_x, arrows_y, _s, _s, 0, _c, _a);
	
	
	//Barre d'espace : PETRIFY
	if(!global.pause)
	{
		if(instance_exists(player))
		{
		//	if(player.can_petrify == true)	{ _c = action_color; }
		//	if(player.can_petrify == false)	{ _c = COL.WHITE;	 }
		}
			draw_sprite_ext(space, 0, space_x, space_y, _s, _s, 0,  _c, alpha_action);
	
			draw_set_align(0, 1);
		//	draw_text_transformed_color(space_x + space_w/2, space_y + _decaly, global.action_str, _s, _s, 0, _c, _c, _c, _c, alpha_action);
			draw_set_align();
	}
	
	
}


if(global.pause)
{
	if(show_pause_menu)
	{
		_c = color_pause;
		draw_set_alpha(0.2);
		draw_rectangle_color(0, 0, gui_w, gui_h, _c, _c, _c, _c, false);	
		draw_set_alpha(1);
	
		_c = COL.WHITE;
		var _marg = marge * 3;
		// draw_rectangle_color(_marg, _marg, gui_w - _marg, gui_h - _marg, _c, _c, _c, _c, true);	
		draw_sprite(cadre_pause, 0, mix, miy);
		//	draw_sprite_stretched(cadre_pause, 0, _marg, _marg, gui_w - (2*_marg), gui_h - (2*_marg));
	
		draw_set_align(0, 0);
		draw_text_transformed_color(mix, miy, "Pause\nPress TAB to continue", _s, _s, 0, _c, _c, _c, _c, 1);
		draw_set_align();
	
	
	//Options
		//
		_a		= 1;
		var _kx = marge;
		var _ky = miy + 64;
		var _state = "ON";
		
	//Sounds
		draw_sprite_ext(key, 0, _kx, _ky, _s, _s, 0, _c, _a);
		draw_set_align(0, 1);
		draw_text_transformed_color(_kx + key_w/2, _ky + _decaly, "M", _s, _s, 0, _c, _c, _c, _c, _a);
		
		draw_set_align(-1, 1);
		if(global.sound_active){ _state = "ON"; } else { _state = "OFF"; }
		draw_text_transformed_color(_kx + key_w + 8, _ky + _decaly, "SOUNDS : " + string(_state), _s, _s, 0, _c, _c, _c, _c, _a);
		draw_set_align();
		
	//Screen Shake
		_ky = miy + 64 + key_w * 1.5;
		draw_sprite_ext(key, 0, _kx, _ky, _s, _s, 0, _c, _a);
		draw_set_align(0, 1);
		draw_text_transformed_color(_kx + key_w/2, _ky + _decaly, "L", _s, _s, 0, _c, _c, _c, _c, _a);
		
		draw_set_align(-1, 1);
	//	if(global.screen_shake_active){ _state = "ON"; } else { _state = "OFF"; }
		draw_text_transformed_color(_kx + key_w + 8, _ky + _decaly, "Screen Shake : " + string(_state), _s, _s, 0, _c, _c, _c, _c, _a);
		draw_set_align();
	}
}

//if(global.gameover)
if(state == SHOW_UI.GAMEOVER)
{
	_c = color_gameover;
	draw_set_alpha(alpha_gameover);
	draw_rectangle_color(0, 0, gui_w, gui_h, _c, _c, _c, _c, false);	
	draw_set_alpha(1);
	
	_c = COL.WHITE;
	draw_set_align(0, 0);
	draw_text_transformed_color(mix, miy, "You are going back to Hell...", _s, _s, 0, _c, _c, _c, _c, alpha_gameover - 0.2);
	
	if(show_button_try_again)
	{
	//Bouton "Try again"
		var _by = miy + 40;
		draw_sprite_ext(button, 0, mix - button_w/2, _by, _s, _s, 0,  _c, alpha_gameover);
		draw_set_align(0, 1);
		draw_text_transformed_color(mix, _by + _decaly, "Try again", _s, _s, 0, _c, _c, _c, _c, alpha_gameover);
		draw_set_align();

	//Bouton "Back to menu"
		var _bx = mix - button_w/2;
		_by = miy + 40 + tab_h + 8;
		draw_sprite_ext(tab, 0, _bx, _by, _s, _s, 0,  _c, alpha_gameover);
		draw_set_align(-1, 1);
		draw_text_transformed_color(_bx + 16, _by + _decaly, "Quit", _s, _s, 0, _c, _c, _c, _c, alpha_gameover);
		draw_set_align();
	}
}


