///@desc DESTROY EFFECTS

//Metamorphose
	instance_create_layer(x, y, "Instances", obj_pnj_droplet);

//Particles
	repeat(irandom_range(15, 20))
	{
		var _r = 16;
		var _x = x + random_range(-_r, _r);
		var _y = y + random_range(-_r, _r);
	//	instance_create_layer(_x, _y, layer, obj_effect_evaporation);
		instance_create_layer(_x, _y, "Instances", obj_fire_particle);
	}
		var _r = 16;
		var _x = x + random_range(-_r, _r);
		var _y = y + random_range(-_r, _r);
		instance_create_layer(_x, _y, "Instances", obj_fire_particle);
		instance_create_layer(_x, _y, "Instances", obj_fire_particle);
		instance_create_layer(_x, _y, "Instances", obj_fire_particle);
		instance_create_layer(_x, _y, "Instances", obj_fire_particle);
		instance_create_layer(_x, _y, "Instances", obj_fire_particle);
	
//Sound
	with(obj_c_music)
	{
		s = irandom(array_length(sounds_feufollet_transform) - 1);
		sound_feufollet_transform	= sounds_feufollet_transform[s];
		audio_play_sound(sound_feufollet_transform, 1, false);
	}
