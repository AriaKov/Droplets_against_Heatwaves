///@desc RAGE / PICKUP

var _plant = other;

if(_plant.fire_state == FIRE_STATE.BURNING)
{
	event_user(7);
	
//	if(water_state == PLAYER_HUMIDITY.WET)	//Si je mute ça, le feu attisera le feu (player rage + plante feu = player +++ rage)
	{
//		watering();
	}
}
	
//If Player is in Rage, it can dehydrate plants
if(water_state == PLAYER_HUMIDITY.RAGE)
{
	with(_plant)
	{
		//Ne peut pas rebruler si brule ou vient de l'être
		if(fire_state != FIRE_STATE.BURNING) && (fire_state != FIRE_STATE.BURNED)
		{
			burning();	
		}
		
		//BREAK THINGS
		if(plant_size >= 1)
		{
			if(growth_stage == AGE.MATURE) || (growth_stage == AGE.OLD)
			{
				break_plant_effect();
			}
		}
	}	
}
/*
else
{
	if(input_keyboard_or_gamepad_check_pressed(global.key_absorbe, global.gp_absorbe))	//Pickup
	{
		if(other.growth_stage == AGE.SEED)
		{
			//	show_message("La graine peut-être ramassée :-)");
			//PICKUP
			var _id = instance_id_get(other);
			pickup_seed(_id);	
		}
			//	show_message("Cette plante est trop agée...");
	}
}
*/

//Si la plante est en feu : watering() it
//Qu'on soit WET ou DRY, on perd de l'humidité à son contact
//Si WET --> put off the fire
//Si DRY --> watering
// ?

	







