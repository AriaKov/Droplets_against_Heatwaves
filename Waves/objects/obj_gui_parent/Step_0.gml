///@desc IF INTERACTIF : CLIC -> SCRIPT

if !interactif exit;	//BOUTON ou SIMPLE ELEMENT VISUEL d'IU ?

//Si actif en pause, est actif tout le temps peut importe la pause ou pas.
//Si non actif en pause, doit être désactivé lors de la pause.
//Donc on lit ce code, SAUF si ( pause && non-actif_en_pause )
if (!actif_if_pause && global.pause) exit;
//sinon...


//if room == rm_1 state = GUI.FOREST_GAME;


if (button_script != 0) && (position_meeting(mouse_gui_x, mouse_gui_y, id) == true)
{
	image_index = button_image + 1;
	if mouse_check_button_pressed(mb_left)
	{
		//script_execute(button_script, aspect_argument);
		y = ystart + 2;
		alarm[0] = 8;	//event_perform(ev_alarm, 0); //non car on veut une mini latence
		
		audio_play_sound(sound_clic, 1, false);
		audio_sound_gain(sound_clic, 0.2, 0);
	}
}
else image_index = button_image;


