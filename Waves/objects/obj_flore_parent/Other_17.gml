///@desc BURNING
//EVENT_USER(7)

if(fire_state == FIRE_STATE.WET) || (fire_state == FIRE_STATE.DRY)
{
	burning(burning_speed);	//Perte d'humidité rapide...
}

if(fire_state == FIRE_STATE.BURNING) || (fire_state == FIRE_STATE.BURNED)
{
//	burning(burning_speed/3);	//Perte d'humidité lente... ?
}


/*
//show_debug_message("La plante ("+ string(plant_name) +") est en contact avec du feu");

var _hypothese_timer = false;
if(_hypothese_timer == true)
{
	if(fire_state == FIRESTATE.BURNED) exit;	//Ne peut pas prendre feu si est encore brûlé
	
	//sinon...
	var _rt = 0.1;	_rt = 0;	//Random Time
	//alarm[5] = resistance_time + random_range(-_rand, _rand);
	//alarm[5] = resistance_time;
	//event_perform(ev_alarm, 5);
	alarm_set(5, resistance_time + random_range(-_rt, _rt));
}

