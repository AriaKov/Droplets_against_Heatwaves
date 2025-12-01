///@desc STAGE++;
//Appelé par STEP

//La plante change d'état
if(fire_state == FIRESTATE.NORMAL)
{
	stage++;
	days_in_stage = 0;
}

if(firestate == FIRESTATE.BURNED)
{
	//Cesse de grandir tant que n'est pas guérie
	fire_state--;
}

//IN CASE OF WHERE IN FIRE
//if can_be_set_in_fire = false //Retour à la normale si la plante a brûlé
if(firestate == FIRESTATE.BURNED)
{
	/*
	sprite_index = sprite_normal;
	image_blend = c_white;
	//is_bruned = false;
	can_be_set_in_fire = true;
	*/
		//Des chances de créer une Lys dans les cendres
		var _rlys = irandom(10);	//une chance sur ...
		if _rlys == 0
		{
			//event_perform(ev_alarm, 6);		
		}
}


//SEED PROPAGATION
//if can_propagate_seed	//Au final je n'ai pas besoin de cette variable si c'est équivalent au stade MATURE
if(state == GROWTHSTAGE.MATURE)
{	
	repeat(seed_num)	//Nombre de graines possible disséminables à la fois
	{
		num_plants = instance_number(object_index);
		
		if (num_plants >= num_plants_max)	{ exit; }
		if (num_plants < num_plants_min)	{ seed_proba = 100; }
		else { seed_proba = seed_proba_init; }
		
		var _rand = irandom(100);
		if (_rand <= seed_proba)	//si rand compris entre 0 et la proba (qui est en %)
		{
			event_perform(ev_alarm, 7);	//Disséminer une graine dans le seed_rayon
		}
	}
}
//Ajouter une valeur qui permet de vérifier la concentration de la plante déjà en place.
//Et SURTOUT : une qui permet de créer à coup sûr une graine s'il reste moins d'un certain nombre de la plante.
//Voire... adapter seed_proba en fonction d'un intervalle de nombre min à nombre max de plantes.
//seed_proba serait une moyenne dans un cas de figure normal, mais tendrait vers 0 si num_plants == num_plants_max,
//et tendrait vers 100% si num_plants < num_plants_min;


