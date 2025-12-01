///@desc STATES of PARENT

//POUR POUVOIR CLIQUER SUR DES BOUTTONS DRAW SUR LE LAYER GUI
//Pour que ça marche, il faut placer les boutons dans le coin gauche de la room, 
//dans le cadre de la caméra et proportionnellement à la view.
//tuto : https://www.youtube.com/watch?v=RbBgE3cUShc


#region ANCHOR

	#macro mouse_gui_x device_mouse_x_to_gui(0)
	#macro mouse_gui_y device_mouse_y_to_gui(0)

	inactive_offset = [0, 200];
	active_pos = [x, y];

	enum ANCHOR {	TOP_LEFT,		TOP_CENTER,		TOP_RIGHT,
					MIDDLE_LEFT,	MIDDLE_CENTER,	MIDDLE_RIGHT,
					BOTTOM_LEFT,	BOTTOM_CENTER,	BOTTOM_RIGHT,
	}
	enum ALIGNMENTX { LEFT = 0,	CENTER = 1,	RIGHT = 2 };
	enum ALIGNMENTY { TOP = 0,	MIDDLE = 1,	BOTTOM = 2 };

	//Update position based on the anchor wanted
	event_user(0);

#endregion

global_var_to_local();

enum GUI {	FOREST_GAME, ADVENTURE_GAME };
state = GUI.FOREST_GAME;

//button_spr = spr_bouton;
//button_image = 0;
//larg = sprite_get_width(button_spr);
//haut = sprite_get_width(button_spr);

sound_clic = snd_clic_Key_Souris_raspberry_simple_clic__ID_1735__LS;


