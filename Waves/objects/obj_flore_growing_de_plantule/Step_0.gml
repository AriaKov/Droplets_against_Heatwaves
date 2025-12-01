///@desc AGE>STAGES>STATES

if global.pause exit;


#region CHANGEMENT DE STAGE DE CROISSANCE
	
	//Les durées de chaque stage dépendent de plant_size.
	//L'incrément de l'âge est contrôlé par l'écoulement du temps, dans obj_c_cycle_day_night.
	//Détail : obj_cycle_... active l'évent 0.
	//Chaque jour qui passe incrément l'âge++.
	
	if (age == 0) stage = 0;							//BABY SEED
	
	
	if (age > 0)										//CHANGEMENT DE STAGE DE CROISSANCE
	{

		//La durée du STADE dépends de l'ETAT dans lequel est la plante, ET de sa taille.
		//Pour toutes les plantes d'une même taille (0,1,2,3) et dans le même state, la durée d'un stage à l'autre est la même.
		duration_stage = all_durations_stages[plant_size][state];	


		//CHANGEMENT DE STAGE DE CROISSANCE (à chaque fin de duration_stage)
		if(days_in_stage >= duration_stage)
		{
			
			//Condition supplémentaire : si la plante vient de brûler (le feu affaiblit la plante)
			//if can_be_set_in_fire == false //donc brûlé
			if(firestate == FIRESTATE.BURNED)
			{
				
				//La plante a des chances de passer son tour pour ce changement de stade.
				var _r = irandom(10);	//une chance sur ...
				if _r == 0
				{
					event_perform(ev_alarm, 1);	//Stage++ et réinitialiser days_in_stage
					//Cela fait aussi repasser au sprite_normal, dans le cas d'un incendie (et sprite_burn)
				}
			}
			
			//if can_be_set_in_fire == true
			if(firestate == FIRESTATE.NORMAL)
			{
				event_perform(ev_alarm, 1);	//Stage++ et réinitialiser days_in_stage
			}
		}
	}
	
	
	if (stage > number_of_stages) || (age > age_max)	//DYING + SOUCHE
	{
		//SOUCHE D'ARBRE
		if plant_size == 2 && instance_number(obj_flore_souche) < 20 //Arbres
		//Le mieux serait de limiter le nb d'inst en fonction d'une CONCENTRATION, pas d'un nombre absolu.
		{
			//L'arbre a une chance de devenir une souche d'arbre
			var _rd = irandom(10);	
			if _rd == 1
			{
				var _souche = instance_create_layer(x, y, "Instances", obj_flore_souche);
					_souche.image_index = 1;
			}
		}
		
		//Dans tous les cas
		instance_destroy();
	}
	
#endregion


#region FIRE STATES

	fire_state = clamp(fire_state, 0, fire_state_max);

	if firestate = FIRESTATE.BURNED
	{
		sprite_index		= sprite_burning;	//N'est pas forcément différent du sprite_normal
		image_blend			= fire_colors[fire_state];	//Couleur "cramée" de - en - intense
		can_be_set_in_fire	= false;
		
		//fire_state décroit jusqu'à sortir de l'état brûlé
		if fire_state == 0 { firestate = FIRESTATE.NORMAL; }
	}
	if firestate = FIRESTATE.NORMAL
	{
		sprite_index = sprite_normal;
		fire_state = 0;	//au cas où
		image_blend = c_white;
		can_be_set_in_fire = true;
		//Le passage à FIRESTATE.BURNED se fait lors d'une collision avec du feu, par exemple
	}

	/*
	if firestate = FIRESTATE.BURNED
	{
		sprite_index		= sprite_burning;
		image_blend			= red;
		//is_bruned			= true;
		can_be_set_in_fire	= false;
	}
	if firestate = FIRESTATE.RECOVER
	{
		sprite_index = sprite_burning;
		image_blend = orange;
		//is_bruned = false;
		can_be_set_in_fire = false;
	}
	if firestate = FIRESTATE.NORMAL
	{
		sprite_index = sprite_normal;
		image_blend = c_white;
		//is_bruned = false;
		can_be_set_in_fire = true;
	}*/

#endregion


#region STATES

	//Age >>> impacte Stage >>> qui impacte State

	if(state == GROWTHSTAGE.SEED)	//(state 0)
	{
		if(stage > 0){ state = GROWTHSTAGE.YOUNG; }	//STAGE DETERMINE LA STATE
		
		state_str			= "SEED";
		image_index			= 0;
		can_propagate_seed	= false;
		//if (stage > 0) && (stage <= 2)	{ state = GROWTHSTAGE.YOUNG; }	//STAGE DETERMINE LA STATE
	}
	
	if(state == GROWTHSTAGE.YOUNG) || (state == GROWTHSTAGE.MATURE)		//(state 1 --> 2) 	//(state 3 --> max -1)
	{
		if(stage > 1) && (stage < number_of_stages)	{ state = GROWTHSTAGE.MATURE; }	//STAGE DETERMINE LA STATE
		if(stage >= number_of_stages)				{ state = GROWTHSTAGE.OLD; }		//STAGE DETERMINE LA STATE
		
		state_str		= "YOUNG";
		image_index		= stage;
		//image_index	= clamp(image_index, 1, number_of_stages - 1);
		
		
		//Une plante dans ce state a la particularité de pouvoir brûler (= anime fire + changer de sprite)
		//Dans ce cas on enlève le calque FEUILLE du sprite, et ce jusqu'à la fin du stage.
		//Au passage au stage suivant, on remet les feuilles. MAIS je ne sais pas comment activer/désactiver
		//un calque de sprite pendant le jeu, donc je vais peut-être devoir dupliquer le sprite et en faire une version sans feuille.
		
		if(state == GROWTHSTAGE.MATURE)
		{
			state_str			= "MATURE";	
			can_propagate_seed	= true;
			//Doit eptre géré dans l'event de changement de stage, car ne doit se faire qu'une fois à chaque stage
		}
	}
	
	if(state == GROWTHSTAGE.OLD)	//(state max)
	{
		state_str			= "OLD";
		image_index			= number_of_stages;
		can_propagate_seed	= false;
	}
	
#endregion

	
//CONCENTRATION DE LA PLANTE DANS LA ROOM (C = n/V)
		
	superficie_pxl		= room_width * room_height;	//en pixels carré
	superficie_cell		= obj_c_global.nb_cell_x * obj_c_global.nb_cell_y;
	concentration_pxl	= ( num_plants / superficie_pxl ) * 10000;
	concentration_cell	= ( num_plants / superficie_cell ) * 100;


shake_step();


