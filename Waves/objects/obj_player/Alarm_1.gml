///@desc FOOTSTEP SOUND


if(water_state == PLAYER_HUMIDITY.RAGE)
{
	//SOUND
	with(obj_c_music)
	{
		s = irandom(array_length(sounds_footstep_normal) - 1);
		sound_footstep_normal	= sounds_footstep_normal[s];
		sound_footstep_gain		= random_range(0.1, 0.15);
		sound_footstep_pitch	= random_range(0.1, 0.3);
		audio_play_sound(sound_footstep_normal, 1, false, sound_footstep_gain, 0.2, sound_footstep_pitch);	
	}	
}

if(water_state != PLAYER_HUMIDITY.RAGE)
&& ( (move_x != 0) || (move_y != 0) )
{
	//SOUND
	with(obj_c_music)
	{
		s = irandom(array_length(sounds_footstep_normal) - 1);
		sound_footstep_normal	= sounds_footstep_normal[s];
		sound_footstep_gain		= random_range(0.2, 0.3);
		sound_footstep_pitch	= random_range(0.8, 1.2);
		audio_play_sound(sound_footstep_normal, 1, false, sound_footstep_gain, 0, sound_footstep_pitch);	
	}
}

alarm[1] = footstep_sound_timer;



