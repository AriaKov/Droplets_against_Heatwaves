///@desc GUI DU JEU

global_var_to_local();

cell	= RES.CELLSIZE;
mix		= global.mix;
miy		= global.miy;

gui_w		= global.gui_w;
gui_h		= global.gui_h;
mix			= gui_w/2;
miy			= gui_h/2;

mx = display_mouse_get_x();
my = display_mouse_get_y();

player	= obj_player;
source	= obj_watersource;


scale	= RES.SCALE;
marge	= cell;

enum UI { START, MENU, WARNING, HUD, PAUSE, DIALOGUE, GAMEOVER, STATS, END }
state		= UI.START;
state_str	= "START";


//Pause
	show_pause_menu = true;
	cadre_pause		= spr_ui_cadre_pause_negative;
	cadre_pause_w	= sprite_get_width(cadre_pause);
	


enter		= spr_ui_keyboard_enter_mini;
key			= spr_ui_keyboard_key;
shift		= spr_ui_keyboard_shift;
space		= spr_ui_keyboard_space;
arrows		= spr_ui_keyboard_arrows;
escape		= spr_ui_keyboard_escape;
tab			= spr_ui_keyboard_tab;
button		= spr_ui_keyboard_button;
enter_w		= sprite_get_width(enter) * scale;
key_w		= sprite_get_width(key) * scale;
shift_w		= sprite_get_width(shift) * scale;
space_w		= sprite_get_width(space) * scale;
arrows_w	= sprite_get_width(arrows) * scale;
escape_w	= sprite_get_width(escape) * scale;
escape_h	= sprite_get_height(escape) * scale;
tab_w		= sprite_get_width(tab) * scale;
tab_h		= sprite_get_height(tab) * scale;
button_w	= sprite_get_width(button) * scale;
button_h	= sprite_get_height(button) * scale;
shift_x		= marge;
shift_y		= gui_h - marge;
space_x		= mix - space_w/2;
space_y		= gui_h - marge;
arrows_x	= gui_w - marge - arrows_w;
arrows_y	= gui_h - marge;
escape_x	= marge;
escape_y	= marge + tab_h; 
tab_x		= marge;
tab_y		= escape_y + tab_h * 1.5; 


#region MENU

	title = spr_ui_title;
	title_w = sprite_get_width(title) * scale;
	title_h = sprite_get_height(title) * scale;
	title_x = global.gui_w/2 - (title_w/2);
	title_y = global.gui_h/2 - (title_h/2);
	title_color = COL.WATER;
	
	show_title_abc = false; //True quand tout le titre est affiché
	show_title_a = true;
	show_title_b = false;
	show_title_c = false;
	title_latency = 1.5 * global.game_speed;	//title_latency = 0.5 * global.game_speed;
	title_latency = 1 * global.game_speed;
	can_iterate_title = true;
	
	title_alpha				= 1;
	title_alpha_decay		= 0.005; //S'efface progressivement après que la caméra a rejoint player
	title_is_fading_out		= false;
	
#endregion

	
	end_alpha = 1;
	end_alpha_decay = 0.005;

#region HUD


	//INFOS
	stats_ingame			= true;
	stats					= spr_ui_fire;
	stats_w					= sprite_get_width(stats) * scale;
	stat_img_fire_active	= 0;	color_fire_active	= COL.RED;
	stat_img_fire_stopped	= 1;	color_fire_stopped	= COL.ORANGE;

	stat_img_flore_alive	= 2;	color_flore_alive	= merge_color( merge_color(COL.GREEN, COL.YELLOW, 0.1), COL.INDIGO, 0.2);
	stat_img_flore_hydrated	= 3;	color_flore_hydrated	= merge_color( merge_color(COL.YGREEN, COL.WATER, 0.8), COL.INDIGO, 0.2);
	stat_img_flore_dead		= 4;	color_flore_dead	= merge_color(c_black, merge_color(COL.YGREEN, COL.RED, 0.5), 0.7);
	stat_img_feu_follet		= 5;
	stat_img_droplet		= 6;
	nb_feufollet	= instance_number(obj_pnj_feu_follet);
	nb_droplet		= instance_number(obj_pnj_droplet);
	stats_x					= marge;
	state_y					= marge;
	stats_x_esp				= stats_w + (0 * scale);
	stats_y_esp				= stats_w * 1;
	
	
	//BANDEAU POUR LE TEXTE ET LES INFOS
	
	can_show_info_text = true;
	
	//Box
		box		= spr_ui_button_16_64;
		box_w	= cell * 12 * scale;		box_w = cell * 13 * scale;
		box_h	= cell * 1 * scale;
		box_x	= mix - box_w;	
		box_x	= (global.gui_w/2) - (box_w/2);
		box_y_init	= global.gui_h - box_h - (cell * 1 * scale);
		box_y		= box_y_init;
		
	//Text
		text	= "Move with the arrows or WASD";	//Le texte à afficher est déterminé dans le QUEST_SYSTEM, en fonction de la subquest en cours
		posx	= (global.gui_w/2);
		posy	= box_y + (box_h/2);
		
		text_comes_from_an_emitter = false;
		//Et si le texte a un émetteur..
		//Objet émetteur du text. On active l'affichage du texte en s'approchant.
		//Les variables text, text_comes_from_an_emitter, et text_emitter sont contrôlée par QUEST_SYSTEM.
		text_emitter		= source;
		text_emitter_dist	= 64;


	//ROUND WATCH
	
		show_roundwatch = false;	//Sauf si on a trouvé la montre !

		//hours = obj_c_cycle_day_night.hours;
		watch_angle = 15 * global.hours;
		//de 0° (0h ou 24h) à 360° (12h) en passant par 90° = 6h, 270° = 18h
	
		watch		= spr_ui_round_watch;		//watch = spr_ui_round_watch;
		watch_w		= sprite_get_width(watch) * scale;
		watch_h		= watch_w;
		watch_x		= (global.gui_w/2); // - (watch_w/2);	
		watch_y		= cell * scale + (watch_w/4/scale);
		
		watch_ui	= spr_tool_round_watch;
	
	//LOUPE
		
		show_loupe		= false;	//Sauf si on a trouvé la loupe !
		
		loupe			= spr_tool_loupe;
		loupe_w			= sprite_get_width(loupe) * scale;
		loupe_h			= sprite_get_height(loupe) * scale;
		loupe_x			= gui_w - (loupe_w/2) - marge;
		loupe_y			= (loupe_h/2) + marge * 2;

	//PAUSE INDICATOR
		enter_img	=	0;
		enter_x		= gui_w - marge - enter_w - loupe_w;
		enter_y		= marge * 3;
		enter_color	= c_ltgray;
	
	//QUESTS
		quest_x		= marge;
		quest_y		= miy + (marge * 4);
		checkbox	= spr_ui_checkbox_10;
		checkbox_img = 0;
		
	//HUMIDITY BAR
		
		show_humidity_bar = false;	//Sauf si on a trouvé la fleur !
		
		humidity		= spr_ui_jauge_humidity_64;	//Tige de fleur :)
		hum_w			= sprite_get_width(humidity) * scale;
		hum_h			= sprite_get_height(humidity) * scale;
		hum_x			= cell * 6;
		hum_y			= miy - (cell * 4); hum_y = miy - (cell * 6);
		
	//RAGE BAR
	
		show_rage_bar = false;
		
		//Une healthbar qui -- et montre le temps restant en état de RAGE.
		rage			= spr_ui_rage_bar_flames;
		rage_w			= sprite_get_width(rage) * scale;		ragebar_w = 224 * scale; //Healthbar
		rage_h			= sprite_get_height(rage) * scale;		ragebar_h = 5 * scale;
		rage_x			= mix - (rage_w/2);						rage_x = mix;
		//rage_y_final est la position finale de la barre pendant la rage
		//rage_y_final	= global.gui_h - (cell * 1 * scale);	//Anchor en bas à gauche (car flammes qui montent...)
		rage_y_final	= global.gui_h - (cell * 2 * scale);
		rage_y			= rage_y_final;							//Car disparait vers le bas lors de la fin de la rage.
		
		//Text
			rage_text_x		= mix;
			rage_text_y		= global.gui_h - (cell * 5 * scale) - ragebar_h; //cell * 2 * scale;
			
			
		rage_amt		= 60;	//??...
	
		//Quand on est en rage, l'écran devient un peu rouge progressivement
		rage_bg_alpha_max	= 0.3;
		rage_bg_alpha_goal	= 0;
		rage_bg_alpha		= 0;
		
			
	//TIME ACCELERATION WHEN SLEEP
		time_acceleration = false;
		
		sleep_bord_max		= cell * 1.5 * scale;
		sleep_bord_max		= cell * 2.5 * scale;	//Usefull for the pause menu
		sleep_bord			= 0;
		sleep_bord_speed	= 0.02;
			
	
#endregion

#region COLORS

	box_color	= COL.BLACK;
	color_gui	= COL.INDIGO;	color_gui	= COL.WHITE;
//	color_quest = merge_color(COL.WHITE, COL.INDIGO, 0.3);
	color_quest_to_do	= COL.WHITE;
	color_quest_done	= merge_color(COL.WHITE, COL.BLACK, 0.4);
	color_pause = merge_color(COL.WATER, COL.BLACK, 0.7);	alpha_pause = 0.4;	alpha_pause = 0;
	color_sleep = merge_color(COL.BLACK, COL.INDIGO, 0.05);	color_sleep = merge_color(COL.BLACK, COL.WATER, 0);
	
	
#endregion


str		= "azertyuiopqsdfghjklmwxcvbn AZERTYUIOPQSDFGHJKLMWXCVBN";
str_w	= string_width_ext(str, 16, 128);


