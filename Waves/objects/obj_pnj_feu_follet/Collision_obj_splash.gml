///@desc HUMIDIFY :-(


	if(can_absorb_splah == true)
	{
		humidity			+= splash_humidity_gain;
		can_absorb_splah	= false;	//ne peut pas absorber à chaque frame
		alarm[2]			= timer_splash;	
		
		fire_effects_evaporation(random_range(32, 64));
	}


