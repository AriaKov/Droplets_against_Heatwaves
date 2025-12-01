///@desc Midnight : Brume

//Réinitialise la possibilité d'activer ler évènements de journée
//(un seul event par type est possible chaque jour btw)
can_set_event_fire	= true;
can_set_event_day	= true;

with(obj_flore_parent) { event_perform(ev_alarm, 0); } //AGE++.


#region BRUME (proba d'apparition)
	
	if(1 == 2){
		
	if(meteo_brume == true)
	{ 
		//BRUME n'apparait qu'un jour d'affilée
		meteo_brume = false;	//show_message("METEO : Midnight : ...la brume disparait..."); 
	}	
	else 
	{
		var _rd = irandom(proba_brume);	//Une chance sur 2 de voir de la brume s'il n'y en avait pas
		if(_rd == 0)
		{ 
			meteo_brume = true; //show_message("METEO : Midnight : Brume ACTIVEE"); 
		}
	//else { show_message("METEO : Midnight : ...toujours aucune brume..."); }
	}
	}

#endregion

#region RAIN (proba d'apparition)

	if(meteo_rain == true)
	{ 
		meteo_rain = false;		//show_message("METEO : Midnight : ...la pluie disparait..."); 
	}	
	else 
	{
		var _rd = irandom(proba_rain);	//Une chance sur 2 de voir de la brume s'il n'y en avait pas
		if(_rd == 0)
		{ 
			meteo_rain = true; //show_message("METEO : Midnight : Pluie ACTIVEE"); 
		}
	//else { show_message("METEO : Midnight : ...toujours aucune pluie..."); }
	}

#endregion


