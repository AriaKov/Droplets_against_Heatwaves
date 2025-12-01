///@desc ENFLAMME
/*
with(other)
{
	//if(fire_state != FIRE.ON){	fire_state = FIRE.ON;	}
	//Je veux une latence et des effets
	
	if(fire_state != FIRE.ON) && (alarm_propagation_can_be_set == true){
		alarm[alarm_propagation]		= propagation_timer;
		alarm_propagation_can_be_set	= false;
	}
						
}

instance_destroy();

