///@desc HUMIDIFY

with(other)
{
	var _humidity_gain	= splash_humidity_gain;
	var _timer_splash	= timer_splash;
	
		if(fire_state == FIRE_STATE.BURNED)
		{
			_humidity_gain	= splash_humidity_gain/4;
			_timer_splash	= timer_splash * 2;	//Peut absorber beaucoup + lentement
		}

	if(can_absorb_splah == true)
	{ 
		humidity			+= _humidity_gain;
		alarm[2]			= _timer_splash;	
		can_absorb_splah	= false;	//ne peut pas absorber à chaque frame
		
		if(first_time_being_hydrated == true){ 	global.plants_hydrated_by_splash++; first_time_being_hydrated = false; }
		
		if(fire_state == FIRE_STATE.BURNING)
		{
			fire_effects_evaporation();
		}
	}
}
//instance_destroy();





