///@desc GUI DU JEU

scale		= RES.SCALE;	//scale = 1;
cell		= RES.CELLSIZE;

player		= obj_player;
gui_w		= global.gui_w;
gui_h		= global.gui_h;
mix			= gui_w/2;
miy			= gui_h/2;

marge		= cell;


enum SHOW_UI { MENU, WARNING, HUD, DIALOGUE, GAMEOVER, STATS }
state = SHOW_UI.MENU;

show_menu	= true;	
show_hud	= false;


//Warning
warning = "The following program may potentially trigger seizures for people with photosensitive epilepsy.\nViewer discretion is advised.\nYou can turn Off the screen shake effect by pressing [L]";
//The following program contains bright flashing lights. It also contains harsh, high-contrast graphics.


//SPRITES
petrify		= spr_pnj_leaf_idle;
petrify_w	= sprite_get_width(petrify) * scale;
petrify_h	= petrify_w;

key			= spr_ui_keyboard_key;
shift		= spr_ui_keyboard_shift;
space		= spr_ui_keyboard_space;
arrows		= spr_ui_keyboard_arrows;
escape		= spr_ui_keyboard_escape;
tab			= spr_ui_keyboard_tab;
button		= spr_ui_keyboard_button;
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


//Un seul et unique bouton ?

//Action possible avec espace
//	action_petrify_color	= COL.ORANGE;
//	action_look_color		= COL.PINK;
//	action_talk_color		= merge_color(COL.WHITE, COL.BLUE, 0.2);
action_color 			= COL.ORANGE;



escape_distance			= 0;

//font = fnt_pixelbasic;
font = fnt_body;

alpha_low	= 0.4;
alpha_min	= 0.2;
alpha_max	= 1;
alpha_action = alpha_max;

can_change_alpha	= true;

//Indications de mouvement (arrows et tab)
alpha_gui_max	= 0.4;
alpha_gui_min	= 0.1;
alpha_gui		= alpha_gui_min;
alpha_gui_change_speed	= 0.005;

can_change_alpha_gui	= true;
alpha_gui_become_opaque	= false;
alpha_gui_latency		= 2 * global.game_speed;




//Talk
can_talk	= false;
alpha_talk	= alpha_min;
talk_color	= merge_color(COL.WHITE, COL.INDIGO, 0.2);


//Pour la pause
//can_spawn_darkness = true;
show_pause_menu = true;
cadre_pause		= spr_ui_cadre_pause_512;
cadre_pause_w	= sprite_get_width(cadre_pause);
color_pause		= COL.YGREEN; color_pause = merge_color(COL.WATER, COL.WHITE, 0.5);

//Gameover
alpha_gameover = 0;
color_gameover_amount = 0;
color_gameover = merge_color(COL.WHITE, COL.RED, color_gameover_amount);

show_button_try_again = false;

