///@desc GUI


draw_set_font(fnt_gui);
var _c		= c_blue;
var _a		= 1;
var _int	= 24;
var _sep	= 32;
var _s		= 2;
var _i		= 0;

draw_set_align();
var _mx = mx;
var _my = my;

if(state == UI.START)
{
	draw_set_color(COL.WHITE);
	draw_set_font(fnt_title);
	draw_set_align(0, -1);
	_s		= 4;
	draw_text_transformed(mix, miy + 16, "Press [ENTER] to START", _s, _s, 0);
	
		//Titre DROPLETS
		_s = scale;
		//if(show_title_a == true)
		{ draw_sprite_ext(title, 0, title_x, title_y, _s, _s, 0, title_color, title_alpha); }
}

if(state == UI.END)
{
	draw_set_color(COL.WHITE);
	draw_set_font(fnt_title);
	draw_set_align(0, -1);
	draw_set_alpha(end_alpha);
	_s		= 4;
	draw_text_transformed(mix, miy + 16, "Thanks for playing :-) Press [DELETE] to try again", _s, _s, end_alpha);
	draw_set_alpha(1);
}

if(state == UI.MENU)
{
	//Titre DROPLETS - AGAINST - HEATWAVES
		_s = scale;
		if(show_title_a == true){ draw_sprite_ext(title, 0, title_x, title_y, _s, _s, 0, title_color, title_alpha); }
	
		if(show_title_b == true){ draw_sprite_ext(title, 1, title_x, title_y, _s, _s, 0, title_color, title_alpha); }
	
		if(show_title_c == true){ draw_sprite_ext(title, 2, title_x, title_y, _s, _s, 0, COL.RED, title_alpha); }
	
}

if(state == UI.HUD) || (state == UI.PAUSE)
{

	#region SLEEP ACCELERATION
	
	//	if(obj_c_cycle_day_night.state == TIME.ACCELERATED)
		{
			//BANCEAUX NOIRS
			draw_set_alpha(1);
			
			_c	= color_sleep;
			var _marg = sleep_bord;
			var _marg_l = _marg * 3;
			var _marg_r = _marg * 3;
			var _marg_u = _marg;
			var _marg_d = _marg;
			draw_rectangle_color(0,					0,					_marg_l,	gui_h,		 _c, _c, _c, _c, false);	//LEFT
			draw_rectangle_color(gui_w - _marg_r,	0,					gui_w,		gui_h,		 _c, _c, _c, _c, false);	//RIGHT	
			draw_rectangle_color(0,					0,					gui_w,		_marg_u,	 _c, _c, _c, _c, false);	//UP
			draw_rectangle_color(0,					gui_h - _marg_d,	gui_w,		gui_h,		 _c, _c, _c, _c, false);	//DOWN
		}	
		
		if(time_acceleration == true)
		{
			draw_set_align(0, 0);
			draw_set_font(fnt_title);
			_c	= COL.WHITE;
			_s	= 4;
			var _esp = (cell * 2 * scale) - 6;
			draw_text_transformed_color(mix, rage_text_y, "You are sleeping... TIME SPEEDS UP !", _s, _s, 0, _c, _c, _c, _c, 1);
		}
		
	#endregion
	
	#region LOUPE
		
		if(show_loupe == true)
		{
			//UI TOOL
			_s = scale;
			draw_sprite_ext(loupe, 0, loupe_x, loupe_y, _s, _s, 0, c_white, 1);
		}
	
	#endregion

	#region UI ENTER BUTTON
		_s = scale;
		draw_sprite_ext(enter, enter_img, enter_x, enter_y, _s, _s, 0, enter_color, 0.5);
	#endregion
	
	#region ROUND WATCH + HOURS (cf. Cycle Day Night)
	
	if(show_roundwatch == true) || (time_acceleration == true)
	{
		var _ybuff = 0;
		
		if(time_acceleration == true){ _ybuff = cell * 3 * scale; }
		
		//UI TOOL
		_s = scale;
	//	draw_sprite_ext(watch_ui, 0, loupe_x - loupe_w - marge, loupe_y, _s, _s, 0, c_white, 1);
		
		//Encadré
		//draw_sprite_stretched(box, 0, watch_x, watch_y, watch_w, watch_h);	
	
		//Horlogue qui tourne
		_s = 1;		_s = 2;
		//draw_sprite_ext(watch, 0, watch_x + watch_w/2, watch_y + watch_h/2, _s, _s, watch_angle, c_white, 1);
		draw_sprite_ext(watch, 0, watch_x, watch_y + _ybuff, _s, _s, watch_angle, c_white, 1);
		
		//Cache
		draw_sprite_ext(watch, 1, watch_x, watch_y + _ybuff, _s, _s, 0, c_white, 1);
	
		draw_set_align(0, 1);
		draw_set_font(fnt_gui);
		draw_set_color(color_gui);
		draw_set_alpha(1);
	
		_int	= 24;				//Valeur de l'interligne
		var _x	= global.gui_w/2;	//Position x du paquet d'infos
		var _y	= 16;				//Position y du paquet d'infos
		_i		= 0;				//Ligne actuelle
		_s		= 2;
		
		if(global.debug == true)
		//with(obj_c_cycle_day_night)
		{
			//var _minutes = hours mod floor(hours) * 0.3 / 0.5;	//Conversion de % en minutes
			var _minutes = frac(global.hours) * 0.3 / 0.5;	//Conversion de % en minutes
			//draw_text_transformed(_x, _y + (_i * _int), string(floor(hours) + ":" + string(_minutes), _s, _s, 0); _i++;
			var _time = string(floor(global.hours) + _minutes); _time = string_replace(_time, ".", ":");
			draw_text_transformed(watch_x + (watch_w/2), watch_y + watch_h - 8 + _ybuff, string(_time), _s, _s, 0); _i++;

		//	draw_text_transformed(watch_x + (watch_w/2), watch_y + watch_h + 4, string(obj_c_cycle_day_night.day), _s, _s, 0); _i++;
		}
	}
	
	#endregion
	
	#region HUMIDITY BAR
	
		if(show_humidity_bar == true)
		{
			_s = scale;
		
			//Cadre Tige de fleur :)
		 	//draw_sprite_ext(humidity, 1, hum_x, hum_y, _s, _s, 0, c_white, 1);
		
			//Healthbar
			var _marg = 6 * scale;
			var _hw = 4 * scale;
			var _hh = hum_h - (hum_h/3);
			var _hx = hum_x; // - (_hw/2);
			var _hy = hum_y - _hh;
		
			var _humidity_amt = player.humidity;
		
			//var _color_back = COL.ORANGE;
			//var _color_back = merge_color(COL.ORANGE, COL.WATER, _humidity_amt/100);
			var _color_back = merge_color(COL.RED, COL.ORANGE, _humidity_amt/100);
			draw_healthbar(_hx, _hy, _hx + _hw, hum_y, _humidity_amt, _color_back, COL.INDIGO, COL.WATER, 3, true, false);
		
			//Cadre Tige de fleur :)
			//La tige est ancrée en bas au milieu
			var _img; if(player.humidity >= 99){ _img = 1; } else { _img = 0; }
			draw_sprite_ext(humidity, 0, hum_x, hum_y, _s, _s, 0, c_white, 1);	
		}
	
	#endregion
	
	#region RAGE BACKGROUND
	
		//if(player.water_state == PLAYER_HUMIDITY.RAGE)
		//Toujours, puisque c'est l'alpha qu'on contrôle
		if(rage_bg_alpha > 0)
		{
			_c = merge_color(COL.RED, COL.ORANGE, 0.5);
			draw_set_alpha(rage_bg_alpha);
			draw_rectangle_color(0, 0, gui_w, gui_h, _c, _c, _c, _c, false);
			draw_set_alpha(1);
		}
		
	#endregion
	
	#region Phase of the day, NUMBER OF THE DAY
	
		draw_set_font(fnt_title);
		draw_set_align(1, -1);
		draw_set_color(COL.WHITE);
			var _x	= gui_w - marge;
			var _y	= cell * 2.5 * scale;
			_sep	= cell * scale;
			_s		= 3;
		if(instance_exists(obj_c_cycle_day_night) == true){ with(obj_c_cycle_day_night){
			draw_text_transformed(_x, _y + (_sep * _i), string(phase) + " " + string(day), _s, _s, 0);	_i++;
			}	
		}
			
	#endregion
	
}

if(state == UI.HUD)
{
		#region STATS
			
			draw_set_font(fnt_title);
			draw_set_alpha(1);
			draw_set_align(-1, 1);

			var _x		= stats_x;
			var _y		= stats_x;
			_sep		= stats_y_esp;
			_i			= 0;
			_s			= scale;
			var _sc		= 4;	//Texte
			var _text_y_decal	= stats_w - (2 * scale);
				
	//		draw_text_transformed(_x, _y + (_i * _sep), "FIRES : " + string(global.fires_number) + " (stopped : " + string(global.fires_stopped) + ")", _s, _s, 0);	_i++;
		
			_c = color_fire_active;		draw_set_color(_c);
			draw_sprite_ext(stats, stat_img_fire_active, _x, _y + (_i * _sep), _s, _s, 0, _c, 1);	
			draw_text_transformed(_x + stats_x_esp, _y + (_i * _sep) + _text_y_decal, string(global.fires_number), _sc, _sc, 0);	
			_i++;
			
				_i--;
				var _xbuff = (32 * scale);
				var _f = 0;
			repeat(nb_droplet)
			{
				_c = COL.WATER;		draw_set_color(_c);
				draw_sprite_ext(stats, stat_img_droplet, _x + (64 * scale) + (_xbuff * _f), _y + (_i * _sep), _s, _s, 0, _c, 1);	
				//draw_text_transformed(_x + stats_x_esp, _y + (_i * _sep) + _text_y_decal, string(nb_droplet), _sc, _sc, 0);	
				_f++;
			}
			repeat(nb_feufollet)
			{
				_c = color_fire_active;		draw_set_color(_c);
				draw_sprite_ext(stats, stat_img_feu_follet, _x + (64 * scale) + (_xbuff * _f), _y + (_i * _sep), _s, _s, 0, _c, 1);	
				//draw_text_transformed(_x + stats_x_esp + (64 * scale), _y + (_i * _sep) + _text_y_decal, string(_num), _sc, _sc, 0);	
				_f++;
			}			
			_i++;	
			

			
			if(stats_ingame == true)
			{
			//	_c = color_fire_stopped;	draw_set_color(_c);
			//	draw_sprite_ext(stats, stat_img_fire_stopped, _x, _y + (_i * _sep), _s, _s, 0, _c, 1);	
			//	draw_text_transformed(_x + stats_x_esp, _y + (_i * _sep) + _text_y_decal, string(global.fires_stopped), _sc, _sc, 0);	
			//	_i++;
		
			//	_c = color_flore_alive;		draw_set_color(_c);
			//	draw_sprite_ext(stats, stat_img_flore_alive, _x, _y + (_i * _sep), _s, _s, 0, _c, 1);	
			//	draw_text_transformed(_x + stats_x_esp, _y + (_i * _sep) + _text_y_decal, string(instance_number(obj_flore_parent)), _sc, _sc, 0);	
			//	_i++;
			
			
			_c = color_flore_hydrated;		draw_set_color(_c);
			draw_sprite_ext(stats, stat_img_flore_hydrated, _x, _y + (_i * _sep), _s, _s, 0, _c, 1);	
			var _propotion_of_wet_plants = ceil( (global.plants_actually_wet * 100) / (instance_number(obj_flore_parent)) );
			draw_text_transformed(_x + stats_x_esp, _y + (_i * _sep) + _text_y_decal, string(_propotion_of_wet_plants) + "%", _sc, _sc, 0);	
			_i++;
			
			//	_c = color_flore_dead;		draw_set_color(_c);
			//	draw_sprite_ext(stats, stat_img_flore_dead, _x, _y + (_i * _sep), _s, _s, 0, _c, 1);	
			//	draw_text_transformed(_x + stats_x_esp, _y + (_i * _sep) + _text_y_decal, string(global.flore_dead), _sc, _sc, 0);	
			//	_i++;
				
			}
			
			
		#endregion
			
	#region TEXTE DANS L'ENCADRE
	
		//Globalement on ne se sert de l'encadré + text que dans HUD, SAUF pour le tuto initial.	
		if(can_show_info_text == true)
		{		
			draw_set_alpha(1);
			_s	= 2;
		
			//Box
			draw_sprite_stretched(box, 0, box_x, box_y, box_w, box_h);
		
				draw_set_font(fnt_body);
				draw_set_align(0, 0);
			
			//Text
			draw_set_color(color_gui);
			draw_text_transformed(posx, posy, text, _s, _s, 0);
		}

	#endregion	

	#region RAGE BAR
	
		if(show_rage_bar == true)
		{
				var _decalx = cell * scale;
				var _hx = rage_x - (rage_w/2) + _decalx;							//_hx = mx;
				var _hy = rage_y - (4 * scale);		_hy = rage_y + (1 * scale);		//_hy = my;
		
				//var _hum_amt = player.humidity * 100 / player.humidity_dry_min;
				var _hum_amt = player.humidity * 100 / player.rage_max;
		
			//Healthbar
			draw_set_alpha(1);
			draw_healthbar(_hx, _hy, _hx + ragebar_w, _hy + ragebar_h, _hum_amt, COL.WATER, COL.RED, COL.ORANGE, 1, true, true);
		
			//Cadre flammes
			_s = scale;
			draw_sprite_ext(rage, 0, rage_x, rage_y, _s, _s, 0, COL.RED, 1);
			
		
		//Text
		draw_set_font(fnt_rage);
		draw_set_align(0, -1);
		draw_set_color(COL.RED);
		_sep	= cell * scale;
		_s		= 4;
		//	var _text = "You've become ENRAGED !!!!"";
		//	var _text = "Dehydration has driven you CRAZY !!";
		//	var _text = "Dehydration made you lose control !";
		//	var _text = "Thirst has driven you mad !";
		//	var _text = "You've become UNCONTROLLABLE and UNSTOPPABLE !!!";
			var _text = "Dehydration has made you UNCONTROLLABLE !!!";
		draw_text_transformed(rage_text_x, rage_text_y, _text, _s, _s, 0);	_i++;
	
		}
	
	#endregion
}

if(state == UI.PAUSE)
{
	if(show_pause_menu)
	{
			_c = color_pause;
			draw_set_alpha(alpha_pause);
		
		//Fond
	//	draw_rectangle_color(0, 0, gui_w, gui_h, _c, _c, _c, _c, false);	
		draw_set_alpha(1);
	
			
			var _marg = marge * 3;
		
		//Cadre
		//draw_rectangle_color(_marg, _marg, gui_w - _marg, gui_h - _marg, _c, _c, _c, _c, true);	
		//draw_sprite_stretched(cadre_pause, 0, _marg, _marg, gui_w - (2*_marg), gui_h - (2*_marg));
	//	draw_sprite(cadre_pause, 0, mix, miy);
		
		//Désormais pour la pause on met les bandeaux extérieurs comme pour time acceleration.
		
		//Texte
			draw_set_align(0, 0);
		
			draw_set_font(fnt_title);
			_c	= COL.WHITE;
			_s	= 4;
			var _esp = (cell * scale) - 6;
			draw_text_transformed_color(mix, _esp, "P A U S E", _s, _s, 0, _c, _c, _c, _c, 1);
		
		//	draw_set_font(fnt_body);
		//	_c	= COL.ORANGE;
			_s	= 3;
			_sep = 32;
			draw_text_transformed_color(mix, gui_h - _esp - _sep*1.5, "Press ENTER to resume game", _s, _s, 0, _c, _c, _c, _c, 1);
			draw_text_transformed_color(mix, gui_h - _esp, "Press DELETE to restart the game", _s, _s, 0, _c, _c, _c, _c, 1);
			draw_set_align();
	
			
		#region STATS
			
			draw_set_font(fnt_title);
			draw_set_alpha(1);
			draw_set_align(-1, 1);

			var _x		= stats_x;
			var _y		= stats_x;
			_sep		= stats_y_esp;
			_i			= 0;
			_s			= scale;
			var _sc		= 4;	//Texte
			var _text_y_decal	= stats_w - (2 * scale);
				
	//		draw_text_transformed(_x, _y + (_i * _sep), "FIRES : " + string(global.fires_number) + " (stopped : " + string(global.fires_stopped) + ")", _s, _s, 0);	_i++;
		
			_c = color_fire_active;		draw_set_color(_c);
			draw_sprite_ext(stats, stat_img_fire_active, _x, _y + (_i * _sep), _s, _s, 0, _c, 1);	
			draw_text_transformed(_x + stats_x_esp, _y + (_i * _sep) + _text_y_decal, string(global.fires_number), _sc, _sc, 0);	
			_i++;
			
			_c = color_fire_stopped;	draw_set_color(_c);
			draw_sprite_ext(stats, stat_img_fire_stopped, _x, _y + (_i * _sep), _s, _s, 0, _c, 1);	
			draw_text_transformed(_x + stats_x_esp, _y + (_i * _sep) + _text_y_decal, string(global.fires_stopped), _sc, _sc, 0);	
			_i++;
		
			_c = color_flore_alive;		draw_set_color(_c);
			draw_sprite_ext(stats, stat_img_flore_alive, _x, _y + (_i * _sep), _s, _s, 0, _c, 1);	
			draw_text_transformed(_x + stats_x_esp, _y + (_i * _sep) + _text_y_decal, string(instance_number(obj_flore_parent)), _sc, _sc, 0);	
			_i++;
			
			//	_c = color_flore_hydrated;		draw_set_color(_c);
			//	draw_sprite_ext(stats, stat_img_flore_hydrated, _x, _y + (_i * _sep), _s, _s, 0, _c, 1);	
			//	draw_text_transformed(_x + stats_x_esp, _y + (_i * _sep) + _text_y_decal, string(global.plants_actually_wet) + "/" + string(global.plants_hydrated_by_splash), _sc, _sc, 0);	
			//	_i++;
			
			_c = color_flore_hydrated;		draw_set_color(_c);
			draw_sprite_ext(stats, stat_img_flore_hydrated, _x, _y + (_i * _sep), _s, _s, 0, _c, 1);	
			var _propotion_of_wet_plants = ceil( (global.plants_actually_wet * 100) / (instance_number(obj_flore_parent)) );
			draw_text_transformed(_x + stats_x_esp, _y + (_i * _sep) + _text_y_decal, string(_propotion_of_wet_plants) + "%", _sc, _sc, 0);	
			_i++;
		
			_c = color_flore_dead;		draw_set_color(_c);
			draw_sprite_ext(stats, stat_img_flore_dead, _x, _y + (_i * _sep), _s, _s, 0, _c, 1);	
			draw_text_transformed(_x + stats_x_esp, _y + (_i * _sep) + _text_y_decal, string(global.flore_dead), _sc, _sc, 0);	
			_i++;

		#endregion

		#region QUESTS
	
			if(instance_exists(obj_c_quest_system) == true)
			{
				draw_set_align();
				var _x_checkbox = quest_x + 16;
				var _x			= _x_checkbox + (cell * scale);
				var _y		= quest_y;	_y = gui_h - (cell * 2 * scale);
				var _esp	= 24;			
				_s			= 2;
				_c			= c_white;
				var _c_quest_to_do	= color_quest_to_do;
				var _c_quest_done	= color_quest_done;
				
				var _checkbox		= checkbox;
				var _checkbox_img	= checkbox_img;
				
				var _sc = scale;
				
				with(obj_c_quest_system)
				{
					var _grid = ds_quests;
					var _j		= 0;	//Line index
					_i			= 0;	//quest index
					
					var _num_of_active_quests = 0;
					
					repeat(ds_quests_number)	// Pour toutes les quêtes...
					{
						var _name		= _grid[# 0, _i];				//Nom de la quête
						var _stage		= _grid[# 1, _i];				//Etat de la quête
						var _stage_nb	= array_length(_grid[# 2, _i]);	//Nombre de sous-quêtes
						
						var _quest_active	= (_stage != -1);
						var _quest_done		= (_stage == _stage_nb -1);
						
						if(_quest_active == true) && (_i != QUEST.MENU)
						//	&& (_quest_done == false)
						{		
								_num_of_active_quests++;
								
								var _stage_desc	= _grid[# 2, _i][_stage];	//Description de la sous-quête
							//	var _texte = string(_i) +") " + string_upper(_name) + " : (" + string(_stage + 1) +"/"+ string(_stage_nb) + ") " + string(_stage_desc);
							
								var _done = "";
								if(_quest_done == false){	_done = "";				_c = (_c_quest_to_do);	_checkbox_img = 0; }
								if(_quest_done == true)	{	_done = " (completed)"; _c = (_c_quest_done);	_checkbox_img = 1; }
								draw_set_color(_c);
								var _texte = string_upper(_name) + " : " + string(_stage_desc) + _done;
					
							//draw_text_transformed(_x, _y + (_esp * _j), _texte, _s, _s, 0);			//Anchor top
							var _yy = _y - ((_num_of_active_quests -1) + _j) * _esp;
							draw_text_transformed_color(_x, _yy, _texte, _s, _s, 0, _c, _c, _c, _c, 1);	//Anchor bottom
							//_stage + 1 car le véritable numéro de la sub-quête commence à 0
							
							//Case to do list
							draw_sprite_ext(_checkbox, _checkbox_img, _x_checkbox, _yy, _sc, _sc, 0, _c, 1);
							
							_j++;
						}
						_i++;	
					}
				}
			}

		#endregion
	
	}
	
}


if(global.debug == true)
{
	//	draw_text_transformed(mx, my - 8, string(state_str), _s, _s, 0);	
}


/*
if(state == UI.HUD) || (state == UI.PAUSE)
{

	#region TEXTE DANS L'ENCADRE
		//Globalement on ne s'en sert que dans HUD, SAUF pour le tuto initial.
		//Alors je préfère mettre ce code ici dans une condition qui regroupe les 2 cas.	
		if(can_show_info_text == true)
		{		
			draw_set_alpha(1);
			_s	= 2;
		
			//Box
			draw_sprite_stretched(box, 0, box_x, box_y, box_w, box_h);
		
				draw_set_font(fnt_body);
				draw_set_align(0, 0);
			
			//Text
			draw_set_color(color_gui);
			draw_text_transformed(posx, posy, text, _s, _s, 0);
		}

	#endregion	
}
