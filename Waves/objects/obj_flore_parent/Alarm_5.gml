///@desc FIRE
//Appelé lors de collision avec le feu

//if instance_number(obj_part_fire) < 200

//Lorsque brûle, la plante doit avoir un feu sur elle
if(collision_circle(x, y, 16, fire_obj, false, true) == noone)
{
	//Création d'un feu
	//instance_create_layer(x, y, "Instances", fire_obj);
	
	//ou plutot, state feu + dessin de feu !
}

//SOUND
//	if(audio_is_playing(sound_fire) == false){ audio_play_sound(sound_fire, 1, false); }

//STATE
	fire_stage	= 0;
	fire_state	= FIRESTATE.BURNED;
	/*
	sprite_index		= sprite_burning;
	image_blend			= c_red;
	//is_bruned			= true;
	can_be_set_in_fire	= false;


