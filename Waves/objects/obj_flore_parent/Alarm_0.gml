///@desc AGE++; DAYS_IN_STAGE++;

//La plante grandit chaque jour (appelé par obj_c_cycle_day_night, ou obj_c_meteo (qui est lié au précédent))
days			+= 1;
days_in_stage	+= 1;

if(fire_state == FIRE_STATE.BURNED)
{
	var _death = irandom(death_probability);
	if(_death == death_probability)
	{
		fire_state = FIRE_STATE.DEAD;
	}
}

//SEED PROPAGATION
if(growth_stage == AGE.MATURE)
{	
	repeat(seed_num)	//Nombre de graines possible disséminables à la fois
	{
		num_plants = instance_number(object_index);
		
		//Probabilité de disséminer seed_num graines autour d'elle.
		if(num_plants >= num_plants_max)	{ exit; }
		if(num_plants < num_plants_min)		{ seed_proba = 100; }
		else								{ seed_proba = seed_proba_init; }
		
		var _rand = irandom(100);
		if(_rand <= seed_proba)	//si rand compris entre 0 et la proba (qui est en %)
		{
			if(seeds_propagated < seed_num_total)
			{ event_perform(ev_alarm, 8);	} //Disséminer une graine dans le seed_rayon
		}
	}
}
//Ajouter une valeur qui permet de vérifier la concentration de la plante déjà en place.
//Et SURTOUT : une qui permet de créer à coup sûr une graine s'il reste moins d'un certain nombre de la plante.
//Voire... adapter seed_proba en fonction d'un intervalle de nombre min à nombre max de plantes.
//seed_proba serait une moyenne dans un cas de figure normal, mais tendrait vers 0 si num_plants == num_plants_max,
//et tendrait vers 100% si num_plants < num_plants_min;

