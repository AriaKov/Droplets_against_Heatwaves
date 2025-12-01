

//	water_absorption(absorption_speed);	
	
	//Droplet facial expression
//	face_img = 1;
	
	//SOUND
//	with(obj_c_music)
	{
//		if(audio_is_playing(sound_drink) == false)
		{
//			audio_play_sound(sound_drink, 1, false, sound_drink_gain, 0, sound_drink_pitch);	
		}
	}


///@desc HUMIDIFY

//with(other)
{
	var _humidity_gain	= splash_humidity_gain;
	var _timer_splash	= timer_splash;

	if(can_absorb_splah == true)
	{ 
		humidity			+= _humidity_gain;
		alarm[2]			= _timer_splash;	
		can_absorb_splah	= false;	//ne peut pas absorber à chaque frame
	}
}
//instance_destroy();

