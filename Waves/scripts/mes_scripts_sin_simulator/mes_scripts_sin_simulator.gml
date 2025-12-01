	
	
///@desc STEP. Permet, avec affichage et modification in game grâce aux touches définies, de trouver le bon ratio période / amplitude pour une fonction sinusoïdale.
///@desc Les valeurs sont affichées près de la souris, comme un mode debug.
///@desc La variable qui doit osciller doit être actualisée avec ces valeurs ensuite.
///@arg	{real}	_per (Facteur de) Période, que l'on modifiera pour trouver la bonne. (Défaut : 0.0005)
///@arg	{real}	_amp (Facteur d') Amplitude, que l'on modifiera pour trouver la bonne. (Défaut : 0.1)
///@arg {string} _key1	Touche pour _per += 0.0001	   (Défaut : "E")
///@arg {string} _key2	Touche pour _per -= 0.0001	   (Défaut : "R")
///@arg {string} _key3	Touche pour _amp += 0.01	   (Défaut : "T")
///@arg {string} _key4	Touche pour _amp -= 0.01	   (Défaut : "Y")
function sin_simulator(_per = 0.0005, _amp = 0.1, _key1 = "E", _key2 = "R", _key3 = "T", _key4 = "Y")
{
	var _per_init = _per;
	var _amp_init = _amp;
	
	if(keyboard_check_pressed(ord("E"))) _per += 0.001;
	if(keyboard_check_pressed(ord("R"))) _per -= 0.001;
	if(keyboard_check_pressed(ord("T"))) _amp += 0.1;
	if(keyboard_check_pressed(ord("Y"))) _amp -= 0.1;

//	if(keyboard_check_pressed(ord(_key1))) _per += 0.0001;
//	if(keyboard_check_pressed(ord(_key2))) _per -= 0.0001;
//	if(keyboard_check_pressed(ord(_key3))) _amp += 0.1;
//	if(keyboard_check_pressed(ord(_key4))) _amp -= 0.1;
	
	show_debug_message("----------------------");
	show_debug_message("_per : " + string(_per));
	show_debug_message("_amp : " + string(_amp));
	
	var _mx = display_mouse_get_x();
	var _my = display_mouse_get_y();
	var _s = 1;
	
	draw_text_transformed(_mx, _my, "_per : " + string(_per), _s, _s, 0);
	draw_text_transformed(_mx, _my + 16, "_amp : " + string(_amp), _s, _s, 0);
	
	return _per;
}


