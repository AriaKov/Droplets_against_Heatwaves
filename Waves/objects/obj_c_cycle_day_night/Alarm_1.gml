///@desc Midnight : DAY++; AGE++;

day++;
days_total++;

//	with(obj_flore_growing_parent) { event_perform(ev_alarm, 0); } //AGE++.
//C'est désormais géré dans obj_flore_parent OU obj_c_meteo.



/* // Dans obj_c_meteo, qui contrôle également d'autres types d'évents liés au cycle jour/nuit.
can_set_event_midday = true;

//METEO
if(instance_exists(obj_c_meteo) == true)
{ 
	with(obj_c_meteo)
	{
		if(meteo_brume == true){ meteo_brume = false; }	//N'apparait qu'un jour d'affilée
		else
		{
			var _rd = choose(0, 1);	//Une chance sur 2 de voir de la brume s'il n'y en avait pas
			if(_rd == 1){ meteo_brume = true; }
		}
	}
}

