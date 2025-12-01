///@desc FIRE
//Appelé lors de collision avec le feu

//if instance_number(obj_part_fire) < 200

//PROPAGATION DU FEU
	//if !collision_point(x, y, obj_part_fire, true, false)
	if(collision_circle(x, y, 16, obj_part_fire, false, true) == noone)
	{
		instance_create_layer(x, y, "Instances", obj_part_fire);
	}

//SOUND
	if(audio_is_playing(sound_fire) == false){ audio_play_sound(sound_fire, 1, false); }

//STATE
	fire_state	= fire_state_max;
	firestate	= FIRESTATE.BURNED;
	/*
	sprite_index		= sprite_burning;
	image_blend			= c_red;
	//is_bruned			= true;
	can_be_set_in_fire	= false;


