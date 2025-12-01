///@desc REFUEL

//Si on est enragé-e c'est trop tard pour prendre de l'eau
if(water_state != PLAYER_HUMIDITY.RAGE) 
{
	//Indication qu'on peut boire
	with(other)
	{
		show_indicator = true;	
	}
	
	//Action de boire
//	if(input_keyboard_or_gamepad_check(global.key_absorbe, global.gp_absorbe))
	{
		water_absorption();	
	
		//Droplet facial expression
		face_img = 1;
	}
}



