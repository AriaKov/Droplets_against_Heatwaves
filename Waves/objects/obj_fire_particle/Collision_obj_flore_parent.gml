///@desc ENFLAMME

with(other)
{
	//if(fire_state != FIRE.ON){	fire_state = FIRE.ON;	}
	//Je veux une latence et des effets

	//	if(plant_state != FIRE_STATE.BURNING) && (alarm_propagation_can_be_set == true){
	//		alarm[alarm_propagation]		= propagation_timer;
	//		alarm_propagation_can_be_set	= false;
	//	}
	
	
	
	//burning(); //non, trop lent si l'étaincelle se détruit juste après
	humidity -= 20;		
}

instance_destroy();

