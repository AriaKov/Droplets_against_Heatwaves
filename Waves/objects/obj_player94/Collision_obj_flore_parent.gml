///@desc PICKUP

if(input_keyboard_or_gamepad_check_pressed(global.key_absorbe, global.gp_absorbe))
{
	if(other.growth_stage == AGE.SEED)
	{
	//	show_message("La graine peut-être ramassée :-)");
		//PICKUP
		var _id = instance_id_get(other);
		pickup_seed(_id);	
	}
	//	show_message("C'est trop tard...");
}

/*
//Si la plante est en feu : watering() it
//Qu'on soit WET ou DRY, on perd de l'humidité à son contact
//Si WET --> put off the fire
//Si DRY --> watering
// ?
if(other.fire_state == FIRE_STATE.BURNING)
{
	if(water_state == PLAYER_HUMIDITY.WET)
	{
		watering();
	}
	if(water_state == PLAYER_HUMIDITY.DRY)
	{
		watering();
	}
}
if(water_state == PLAYER_HUMIDITY.RAGE)
{
	set_fire(other);
}






