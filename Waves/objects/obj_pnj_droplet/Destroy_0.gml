///@desc -> FEU FOLLET

//Metamorphose
	instance_create_layer(x, y, "Instances", obj_pnj_feu_follet);

//Particles
	repeat(irandom_range(15, 20))
	{
		var _r = 16;
		var _x = x + random_range(-_r, _r);
		var _y = y + random_range(-_r, _r);
	//	instance_create_layer(_x, _y, layer, obj_effect_evaporation);
		instance_create_layer(_x, _y, layer, obj_splash);
	}
	
//Sound
	with(obj_c_music)
	{
		s = irandom(array_length(sounds_droplet_transform) - 1);
		sound_droplet_transform		= sounds_droplet_transform[s];
		audio_play_sound(sound_droplet_transform, 1, false);
	}


