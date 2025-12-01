///@desc SEED PROPAGATION

//Appelé par ALARM STAGE++

var _can_disseminate = true;
if (_can_disseminate == true)
{
	var _x = irandom_range(x - seed_ray, x + seed_ray);
	var _y = irandom_range(y - seed_ray, y + seed_ray);
	
	//while place_meeting(_x, _y, collisionnables)	//Eviter les collisions
	while	collision_circle(_x, _y, ray_coll, collisionnables, false, false)
	//||	collision_circle(_x, _y, margin_dissemination, plant_object, false, true)
	{
		var _same_plant_specie = plant_object_string;
		
		//if instance_exists(plant_object)
		//while collision_circle(_x, _y, margin_dissemination, _same_plant_specie, false, false)	//Erreur :

	//collision_circle argument 1 incorrect type (string) expecting a Number (YYGI32)
	//at gml_Object_obj_flore_growing_parent_Alarm_7 (line 15) - 		while collision_circle(_x, _y, cell*2, _same_plant_specie, false, true)
 
		//while place_meeting(_x, _y, obj_flore_growing_parent)
		{
			_x = irandom_range(x - seed_ray, x + seed_ray);
			_y = irandom_range(y - seed_ray, y + seed_ray);
		}
	}

	//C'est bien mais je voudrais en cercle et pas en carré
	//var _babyseed = variable_instance_get_names(self);
	//var _babyseed = object_get_name(object_index);


	var _seed = instance_create_layer(_x, _y, "Instances", object_index);
		_seed.stage_init = 0;
}			
//if !audio_is_playing(sound_seedling) audio_play_sound(sound_seedling, 1, false);
	

 