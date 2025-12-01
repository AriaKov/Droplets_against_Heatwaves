///@desc MUSIC TRIGGERS

if(global.music_active == false) && (global.sound_active == false) { exit; }


#region SOUND OF FIRE

		//Number of fires in the room
		var _fires_number	= global.fires_number;
		
		if(_fires_number <= 0)			//No fire
		{
			//Stop sounds
			if(audio_is_playing(sound_fire_soft) == true)	{	audio_stop_sound(sound_fire_soft); }
			if(audio_is_playing(sound_fire_strong) == true)	{	audio_stop_sound(sound_fire_strong); }
		}
		else							//There is fire !
		{
			if(_fires_number < 10){
				if(audio_is_playing(sound_fire_strong) == true)	{	audio_stop_sound(sound_fire_strong); }
				if(audio_is_playing(sound_fire_soft) == false){	audio_play_sound(sound_fire_soft, 1, true, sound_fire_gain, 0, sound_fire_pitch); }	
			}else{
				if(audio_is_playing(sound_fire_soft) == true)	{	audio_stop_sound(sound_fire_soft); }
				if(audio_is_playing(sound_fire_strong) == false){	audio_play_sound(sound_fire_strong, 1, true, sound_fire_gain, 0, sound_fire_pitch); }	
			}
		}
		
#endregion


if(instance_exists(player) == true)
{
	var _state = player.water_state;
	var _state_rage = (_state == PLAYER_HUMIDITY.RAGE);
	
//	if(music_normal_gain != music_normal_gain_goal){
//	music_normal_gain -= gain_decay;
//	}
		
//	if(music_a_gain != music_a_gain_wanted){ music_a_gain += gain_incr * sign(music_a_gain_wanted - music_a_gain); }
//	if(music_b_gain != music_b_gain_wanted){ music_b_gain += gain_incr * sign(music_b_gain_wanted - music_b_gain); }


	if(_state_rage == false)
	{
		can_play_rage_music		= true;
		
		if(can_play_normal_music == true)
		{
			//Actualise only one time
			sound_footstep			= sound_footstep_normal;
			can_play_normal_music	= false;
		}
		
		//AMBIENT
			if(audio_is_playing(sound_nature) == false){
				audio_play_sound(sound_nature, 1, true);
			}
			audio_sound_gain(sound_nature, sound_nature_gain, fade_speed/2);
			
				if(instance_exists(obj_c_cycle_day_night)){	
					with(obj_c_cycle_day_night){
						if(state == TIME.ACCELERATED)
						{
							sound_nature_pitch = 1.5;
						}
						else { sound_nature_pitch = 1; }
					}
					audio_sound_pitch(sound_nature, sound_nature_pitch);
				}
			
		if(global.music_active == true)
		{
			//FADE OUT MUSIC RAGE
			if(audio_is_playing(music_rage) == true)
			{
				audio_sound_gain(music_rage, gain_min, fade_speed);
				
				if(music_rage_pitch <= music_rage_pitch_min){ music_rage_pitch = music_rage_pitch_normal; }
				
				//music_rage_pitch -= 0.0005;
				music_rage_pitch -= 0.001;
				music_rage_pitch = clamp(music_rage_pitch, music_rage_pitch_min, music_rage_pitch_max);
				audio_sound_pitch(music_rage, music_rage_pitch);
				
				if(music_rage_pitch <= music_rage_pitch_min) // || (music_rage_gain <= 0)
				{
					audio_stop_sound(music_rage); 
					music_rage_pitch = music_rage_pitch_normal;
					}
			}
			
		
			//FADE IN
		//	if(audio_is_playing(music_normal) == false){
		//		audio_play_sound(music_normal, 1, true);
		//	}
		//	audio_sound_gain(music_normal, gain_max, fade_speed/2);
		}
	}
	
	if(_state_rage == true) 
	{
		can_play_normal_music	= true;
		
		if(can_play_rage_music == true)
		{
			//show_message("can_play_rage_music == true");
			sound_footstep		= sound_footstep_rage;
			music_rage_pitch	= music_rage_pitch_normal;
			can_play_rage_music	= false;
		}
		
		//AMBIENT
			if(audio_is_playing(sound_nature) == true){
			audio_sound_gain(sound_nature, gain_min, fade_speed);
			}
			
		if(global.music_active == true)
		{
			//FADE OUT
			if(audio_is_playing(music_normal) == true){
			audio_sound_gain(music_normal, gain_min, fade_speed);
			}
			//FADE OUT
			if(audio_is_playing(music_fairy) == true){
			audio_sound_gain(music_fairy, 0, fade_speed);
			}
			
			//FADE IN MUSIC RAGE
			if(audio_is_playing(music_rage) == false){
				audio_play_sound(music_rage, 1, true);	
				
			//	audio_play_sound(music_rage, 1, true, music_rage_gain, 0, music_rage_pitch);	
			}
			audio_sound_pitch(music_rage, music_rage_pitch_normal);
			audio_sound_gain(music_rage, gain_max, fade_speed);
			
		//	if(music_rage_pitch < music_rage_pitch_normal){ 
		//		music_rage_pitch += 0.001; 
		//		music_rage_pitch = clamp(music_rage_pitch, music_rage_pitch_min, music_rage_pitch_max);
		//		audio_sound_pitch(music_rage, music_rage_pitch);	
		//	}

		}
		
	}
}



