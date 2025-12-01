///@desc (dans obj_bouton_parent)

/*
	
	
if state = GUI.FOREST_GAME /////////////////////////////////////////////////////////////////////////////
{
	
	
	
	var _marge = cell;
	var _x = _marge;
	var _y = _marge;
	var _ns_decal = 3;	//nine slices decalage
	var _int = cell * 3;
	var _i = 0;
	var _larg = cell * 4;
	var _haut = cell * 2;

	repeat(5)
	{
		var _xx = _x;
		var _yy = _y + (_i * _int);
		draw_sprite_stretched(spr_bouton, button_image, _xx, _yy, _larg, _haut); _i++;
		
		if collision_rectangle(_xx, _yy, _xx + _larg, _yy + _haut, obj_mouse, false, true)
		{ 
			if mouse_check_button_pressed(mb_left)
			{
				audio_play_sound(snd_Sword_Hit_02, 1, true);
			}
		}
	}	
}

if state = GUI.ADVENTURE_GAME /////////////////////////////////////////////////////////////////////////////
{
	
	
}





/*
///SETUP DU TEXTE A L'ECRAN

	draw_set_valign(fa_top);

	var _int	= 40;
	var _bloc	= 1000;
	var _s = 0.5;
	
#region AFFICHAGE "PAUSE = ESCAPE"

	draw_set_halign(fa_center);	
	//draw_text_transformed(global.gui_w/2, margin, "ESC to pause", _s, _s, 0);
	//draw_text_transformed(global.gui_w/2, margin, "ESC", _s, _s, 0);
	draw_set_halign(fa_left);	
	
#endregion


#region BARRE DE VIE ET NOMBRE D'ITEMS COLLECTES (PLAYER)
	
	#region BARRE DE SANTE
	var _mar = 5;	//marge du sprite nine slice autour de la healthbar
	
	var _w = 380;		//380 //largeur de la barre et du cou, du bloc entier. --> les autres données en dépendent
	var _h = 25;		//hauteur de la barre
	var _esp = margin;	//espace
	var _x1 = global.gui_w - _w - _esp - _mar;
	var _y1 = _esp + _mar;
	var _x2 = _x1 + _w;
	var _y2 = _y1 + _h;
	
	var _backcol = #333333;
	var _mincol = black; 
	var _maxcol = blue; //#4EEE94;	//#FF4040,
	
	
		//VARIATION ALPHA DE LA BARRE (CLIGNOTEMENT)
		
		var _alpha_min = 0.1;
		var _alpha_max = 1 - 0.2;
		var _alpha = _alpha_max;
		
		if(global.watervision == true)
		{
			_alpha = _alpha_max + sin(timer * 0.1) * 0.3;	//Transparence qui clignote
			_alpha = clamp(_alpha, _alpha_min, _alpha_max);
			timer++;
		}
		draw_set_alpha(_alpha); 
	
	
	draw_healthbar(_x1, _y1, _x2, _y2,
		global.life/global.life_max * 100, 
		_backcol, _mincol, _maxcol,
		//$FF191919 & $FFFFFF,
		//$FF2745 & $FFFFFF,
		//$9760334 & $FFFFFF, 
		1,		//1 = anchored to the right
		false,
		false
		//(($FF191919>>24) != 0), 
		//(($FF00FFFF>>24) != 0)
		);
	draw_set_alpha(global.alpha_gui); 
	draw_sprite_stretched(spr_healthbar, 0, _x1 - _mar + 2, _y1 - _mar + 2, _w + _mar - 2, _h + _mar + 2);
	var _scale = 5;
	draw_sprite_ext(spr_coeur_idle,		 0,	_x1 - _mar + 2, _y1 - _mar + (_h/2), _scale, _scale, 0, c_white, 1);

	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	draw_set_alpha(global.alpha_gui);
	
	//draw_text_ext_transformed( _x1, _y1 + _int*0,	"INNER ENERGY :     " + string(global.life) +" / "+ string(global.life_max), _int, _bloc, _scale, _scale, 0);
	//draw_text_ext_transformed( _x1, _y1 + _int * 0,	"Inner energy : " + string(global.life), _int, _bloc, _s, _s, 0);
	
	//SPRITE ICONE COEUR
	_scale = 4;
	var _sprite_h = sprite_get_height(spr_coeur_idle);
	//draw_sprite_ext(spr_coeur_idle,		 0,	_x1 - 33, _y1 + _sprite_h + 3, _scale, _scale, 0, c_white, 1);
	
	#endregion
	
	#region NOMBRE D'ITEMS
	
	if(format_text == true)		//AFFICHAGE TEXTE
	{
		//draw_text_ext_transformed( _x1, _y1 + _int*1,	"WATER CENTIPIXEL : " + string(global.item) +" / "+ string(global.item_max), _int, _bloc, _scale, _scale, 0);
		draw_text_ext_transformed( _x1, _y1 + _int * 1,	"Water centipixel : " + string(global.item), _int, _bloc, _s, _s, 0);
	
		//SPRITE ICONE ITEM
		_scale = 6;
		_sprite_h = sprite_get_height(spr_water_item_idle);
		draw_sprite_ext(spr_water_item_idle, 0, _x1 - 33, _y1 + _int + _sprite_h + 3, _scale, _scale, 0, c_white, 1);
	}
	
	if(format_text == false)	//AFFICHAGE VISUEL DU NOMBRE D'ITEMS
	{
		var _intervalle = ((_w / global.item_max) + 2);	//Intervalle entre chaque item = largeur du bloc divisé par les 10 items totaux
		
		//Items totaux récoltables (POINT)
		var t;
		for(t = 0; t < global.item_max; t++)	//Pour autant de nombre d'items que récoltés...
		{
			_scale = 4;
			var _sprite_w = sprite_get_width(spr_water_item_idle);
			draw_sprite_ext(spr_water_item_idle, 1, _x2 - (_sprite_w/1.5) - 4 - (_intervalle * t) , _y2 + 30, _scale, _scale, 0, c_blue, global.alpha_gui - (global.alpha_gui/2));
		}
		
		//Items récoltés (EAU)
		var i;
		for(i = 0; i < global.item; i++)	//Pour autant de nombre d'items que récoltés...
		{
			_scale = 4;
			var _sprite_w = sprite_get_width(spr_water_item_idle);
			draw_sprite_ext(spr_water_item_idle, 0, _x2 - (_sprite_w/1.5) - 4 - (_intervalle * i) , _y2 + 30, _scale, _scale, 0, c_white, global.alpha_gui);
		}
	}
	#endregion
	
	
#endregion


#region ICONE DE VISION D'EAU (WATERVISION) (= sprite)

	if(global.watervision == true)	{ 
		subimg = 1; 
		text = "Water Vision";
		text = "WATER VISION";
		}
	if(global.watervision == false)	{
		subimg = 0;
		text = "Earthly Vision";
		text = "EARTHLY VISION";
		}
	
		var _largeur = sprite_get_width(sprite);
		var _hauteur = sprite_get_height(sprite);

		_int	= 60;
		_bloc	= 600;
		_scale	= 5;	//Pour l'icone
		_scale  = 6;

	#region AFFICHAGE DE L'ICONE

	if(affichage_centre)
	{
		var _margin = 80 + (_hauteur / 2);
		draw_sprite_ext(spr_icone_watervision, subimg, global.gui_w/2, _margin, _scale, _scale, 0, c_white, 1);

		//AFFICHAGE PRESS TOUCHE CRTL
		draw_set_halign(fa_center);
		draw_set_valign(fa_top);
		
		var _xx = margin
		draw_text_ext_transformed(global.gui_w/2 - 3, _margin + _hauteur + 20, "(CTRL)", 60, _bloc, _s, _s, global.alpha_gui);
		draw_text_ext_transformed(global.gui_w/2 - 3, _margin + _hauteur + 60, text, 60, _bloc, _s, _s, global.alpha_gui);
		
		//draw_text_ext_transformed(global.gui_w/2 - 3, _margin + _hauteur + 20, "(CTRL)", 60, _bloc, _s, _s, global.alpha_gui);
		//draw_text_ext_transformed(global.gui_w/2 - 3, _margin + _hauteur + 60, text, 60, _bloc, _s, _s, global.alpha_gui);
	}

	if(!affichage_centre)
	{
		var _xx = margin + 100 + (_largeur/2);
		var _yy = margin + 30 + (_hauteur/2);
		draw_sprite_ext(spr_icone_watervision, subimg, _xx, _yy, _scale, _scale, 0, c_white, 1);

		//AFFICHAGE PRESS TOUCHE CRTL
		var _xxx = _xx + _largeur + margin + margin;
		//var _yyy = _yy - (_hauteur/2) + (_esp * i);
		_esp = margin;
		
		var i = 0;
		draw_text_ext_transformed(_xxx, margin + 6 + (_esp * i), text, _int, _bloc, _s, _s, global.alpha_gui); i++;
		//draw_text_ext_transformed(_xxx, margin + 6 + (_esp * i), "CTRL", _int, _bloc, _s, _s, global.alpha_gui); i++;

		//AFFICHAGE PRESS TOUCHE CRTL
		//draw_set_halign(fa_center);
		//draw_set_valign(fa_top);

		//draw_text_ext_transformed(_marg + (_largeur/2) - 3, _marg + _hauteur + 20, "(CTRL)", _int, _bloc, _s, _s, global.alpha_gui);
		//draw_text_ext_transformed(_marg + (_largeur/2) - 3, _marg + _hauteur + 60, text, _int, _bloc, _s, _s, global.alpha_gui);
	}


#endregion

#endregion


#region TEMPS (CYCLE JOUR NUIT)
/*
	if(instance_exists(o_CycleDayNight))
	{
		with(o_CycleDayNight)
		{
		draw_set_halign(fa_left);
		var _xx = global.gui_w - _w - _esp;
		var _yy = _esp + 100;
		draw_text_ext_transformed(_xx, _yy, "Day : " + string(day), _int, _bloc, _s, _s, 0);
		draw_set_halign(fa_left);
		}
	}

#endregion


if(global.equipped_weapon == true)
{ 
	if(instance_exists(obj_press_space_to_attack))
	{
			with(obj_press_space_to_attack)
			{
				position_x = global.gui_w/2;
				position_y = global.gui_h/2 + 40;
			}
	}
}
if(global.equipped_weapon == false)
{ 
	if(instance_exists(obj_press_space_to_attack))
	{
		with(obj_press_space_to_attack)
		{
			position_x = -500;
			position_y = -500;
		}
	}
}


#region IF GAME OVER

	if(global.gameover == true)
	{
		global.watervision = false;
		
		//FOND ROUGE
		var _c = global.c_aquafoam;
		_c = global.black;
		draw_set_alpha(alphafade);
		
		draw_rectangle_color(0, 0, global.gui_w, global.gui_h, _c, _c, _c, _c, false);

		
		//TEXTE
		draw_set_halign(fa_center);
		draw_set_font(fnt_titrepixel_60);
		draw_set_color(global.color_gui);
		//draw_set_color(c_red);
		
		
		draw_set_alpha(alphafade_text);
		var _s = 1 * 2;
		var _int = 60;
		
		draw_text_ext_transformed(global.gui_w/2, global.gui_h/2 - _int, "Game over", _int, 1000, _s, _s, 0);	//YOU DIED...
		
		_s = 0.6;
		draw_set_alpha(alphafade_text - 0.4);
		draw_set_color(global.white);
		draw_set_color(global.color_gui);
		
		//draw_text_ext_transformed(global.gui_w/2, global.gui_h/2 + _int + 20, "The underwater world is lost forever...", _int, 1000, _s, _s, 0);	//YOU DIED...
		draw_text_ext_transformed(global.gui_w/2, global.gui_h/2 + _int + 20, "You ran out of energy", _int, 1000, _s, _s, 0);	//YOU DIED...

		
		//LOGO YEUX QUI SE FERMENT
		//var _logo = instance_create_layer(global.gui_w/2, global.gui_h/2, "Instances", obj_icone_vision_gameover);
		if(instance_exists(obj_icone_vision_gameover))
		{
			with(obj_icone_vision_gameover)
			{
				x = global.gui_w/2;
				y = global.gui_h/2 - 100;
			}
		//_logo.image_xscale = 4; _logo.image_yscale = 4;
		//_logo.image_alpha = 1;
		}
	}

	#endregion





