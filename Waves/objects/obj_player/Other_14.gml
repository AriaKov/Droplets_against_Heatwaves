///@desc ABSORBE WATER
//EVENT_USER(4)

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
		water_absorption(absorption_speed);	
	
		//Droplet facial expression
		face_img = face_img_drink;
	}
	
	//SOUND
	with(obj_c_music)
	{
		if(audio_is_playing(sound_drink) == false)
		{
			audio_play_sound(sound_drink, 1, false, sound_drink_gain, 0, sound_drink_pitch);	
		}
	}
}
else
{
	//Si on est enragé-e c'est trop tard pour prendre de l'eau ?
	water_absorption(absorption_speed/4);		//RAGE
}





