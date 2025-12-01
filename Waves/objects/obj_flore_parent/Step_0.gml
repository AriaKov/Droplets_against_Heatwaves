///@desc STATES

fire_img_counter++;

if(global.pause == true) exit;


num_plants = instance_number(object_index);


#region HUMIDITY TRIGGERS

if(can_actualise_state_based_on_humidity == true)	//Cannot actualise when in state BURNING or BURNED
{
	if(humidity >= humidity_wet_min)
	{
		fire_state = FIRE_STATE.WET;
	}
	else if(humidity < humidity_dry_min)
	{
		fire_state = FIRE_STATE.BURNING;	
	}
	else { fire_state = FIRE_STATE.DRY;  }
}
	
		/*
		if(humidity <= 0)
		{
			fire_state = FIRE_STATE.DEAD;	 //Point de non-retour
		}
		else if (humidity >= humidity_seuil)
		{
			if(previous_state == FIRE_STATE.BURNING){ global.fires_stopped++; }
		
			fire_state = FIRE_STATE.NORMAL;
		}
		else if (humidity < humidity_seuil)
		{
			//La plante a déjà brûlé...
		
		
			//Ou elle brûle.
			fire_state = FIRE_STATE.BURNING;
		}
		*/

#endregion


#region CLAMP HUMIMDITY
	
	humidity = clamp(humidity, burn_max, humidity_max);
	
#endregion 
	
	
#region STATE FIRE
	
	
	if(fire_state == FIRE_STATE.WET) || (fire_state == FIRE_STATE.DRY)
	{
	//	if(color_normal_amt < 1){ color_normal_amt += (1 / global.time_speed) / 100; } //propotionnel a l'humidity (humidity_max - humidity_dry_min)
		color_normal_amt = lerp(0, 1, (humidity * 100 / humidity_max) / 100);
		color_normal	= merge_color(color_dry, color_wet, color_normal_amt);	
		color			= color_normal;	
	}
	
	switch(fire_state)
	{
		////////////////////////////////
	/*	case FIRE_STATE.NORMAL:
			fire_state_str			= "NORMAL";
			sprite_index			= sprite_normal;
			color					= color_normal;
			previous_state			= fire_state;
			
			evaporation();
			
			//PLUTOT DANS LE FEU LUI-MEME NON ?
				if(alarm_spark_can_be_set == false){ color = c_yellow; alarm_spark_can_be_set	= true; }
						
			break;
		*/
		////////////////////////////////
		case FIRE_STATE.WET:
			fire_state_str			= "WET";
			sprite_index			= sprite_normal;	//merging color betwin color_dry and color_wet
		//	color					= color_wet;
			previous_state			= fire_state;
			can_actualise_state_based_on_humidity = true;
			
			evaporation();
			
			flore_sparkling_if_well_hydrated(5);

			
			can_start_burn		= true;	//Réinit
			can_start_dry		= true;
			fire_duration		= 0;
			
			if(can_start_wet == true){ 
				global.plants_actually_wet++;
				can_start_wet	= false;
			}
						
			break;

		////////////////////////////////
		case FIRE_STATE.DRY:
			fire_state_str			= "DRY";
			sprite_index			= sprite_normal;
		//	color					= color_dry;
			previous_state			= fire_state;
			can_actualise_state_based_on_humidity = true;
			
			//no evaporation, but can be set in fire with the first spark.

			if(can_start_dry == true){ 
				global.plants_actually_wet--;
				can_start_dry	= false;
			}
			
			can_start_burn		= true;	//Réinit
			can_start_wet		= true;
			fire_duration = 0;
			
			break;
		
		//////////////////////////////
		case FIRE_STATE.BURNING:
			fire_state_str			= "BURNING";
			sprite_index			= sprite_burned;
			color					= color_burning;
			previous_state			= fire_state;
			can_actualise_state_based_on_humidity = false;
			
			can_start_dry = true;
			
			//?	burning();
						
			if(can_start_burn == true){ 
				humidity		= burn_max;	//Negative humidity
				can_start_burn	= false;
				
				global.fires_number++;
			}

			humidity += burn_decay;
				
			//DURATION & DEATH PROBABILITY : + le feu est resté longtemps, + grandes sont les proba de mort.
			fire_duration += 1 / global.game_speed;
			
			death_probability = floor(lerp(death_proba_lowest, death_proba_highest, fire_duration*100/fire_duration_max));
			death_probability = clamp(death_probability, death_proba_highest, death_proba_lowest);


			//TRIGGER end of fire (BURNING > BURNED)
			if(humidity >= humidity_burned_min)
			{
				event_perform(ev_alarm, 6);	
			}	
			
			#region PARTICLES
			
				//Particules d'étincelle enflamée (toutes les x secondes)
					if(alarm_spark_can_be_set == true)
					{
						alarm[alarm_spark]		= spark_timer;
						alarm_spark_can_be_set	= false;
					}
					
			#endregion
			
			//Propagation du feu vers une plante à proximité (rayon de propagation)
				var _other_plant_in_ray = collision_circle(x, y, ray_fire_propagation, obj_flore_parent, true, true);
				if(_other_plant_in_ray != noone)
				{
					with(_other_plant_in_ray)
					{
						if(fire_state != FIRE_STATE.BURNING) && (alarm_propagation_can_be_set == true)
						{
							//Dans le cas d'une latence pour déclencher l'incendie
				//			alarm[alarm_propagation]		= propagation_timer;
				//			alarm_propagation_can_be_set	= false;
						}
					}
				}
				
			
			break;
			
		//////////////////////////////
		case FIRE_STATE.BURNED:		//Ne peut pas rebrûler avant d'avoir été NORMAL à nouveau. Peut potentiellement mourir ?
			fire_state_str			= "BURNED";
			sprite_index			= sprite_burned;
			
			//color					= merge_color(c_black, color_burning, 0.5);
			if(color_burned_amt < 1){ color_burned_amt += (1 / global.time_speed) / 100; }
			//note : faire incrementer a l'infini l'amount du lerp fait des trucs phasants
			color_burned			= merge_color(color_burning, color_wet, color_burned_amt);
			color					= color_burned;
		
		
			previous_state			= fire_state;
			can_actualise_state_based_on_humidity = false;
			
			can_start_dry = true;
			can_start_wet = true;
			
				//TRIGGERS

				
				if(humidity >= humidity_wet_min)
				{
					//Recover :-)
					can_actualise_state_based_on_humidity = true;	//Exit this state
				}
			
			break;
		
		//////////////////////////////
		case FIRE_STATE.DEAD:
			fire_state_str			= "DEAD";
			color					= merge_color(c_black, color_burning, 0.3);
			color					= c_purple;
			sprite_index			= sprite_burned;
			image_alpha	-= 0.001;
			
			if(image_alpha <= 0){ instance_destroy(); }
			
			if(alarm_death_can_be_set == true)
			{
				alarm[11] = death_timer;
				alarm_death_can_be_set	= false;
			}
			
			previous_state			= fire_state;
			break;
	}

	image_blend = color;
	
	wind_osc = sin(wind_osc_per * current_time) * wind_osc_amp;
		
		
#endregion



//if(keyboard_check_pressed(ord("F")))	{ fire_state = !fire_state; }



#region CHANGEMENT DE STAGE DE CROISSANCE
	
	
	//Les durées de chaque stage dépendent de plant_size (cf. all_durations_stages)
	//L'incrément de l'âge est contrôlé par l'écoulement du temps, dans obj_c_cycle_day_night.
	//Détail : obj_cycle_... active l'évent 0.
	//Chaque jour qui passe incrément l'âge++.
	
//	if(days == 0){ stage = 0; } 		//BABY SEED
	
//	if(days > 0)									
	{

	
		//La durée du STADE dépends de l'ETAT dans lequel est la plante, ET de sa taille.
		//Pour toutes les plantes d'une même taille (0,1,2,3) et dans le même growth_stage, la durée d'un stdays à l'autre est la même.
		duration_stage = durations[growth_stage];	

		//CHANGEMENT DE STAGE DE CROISSANCE (à chaque fin de duration_stage)
		if(days_in_stage >= duration_stage)
		{
			//Condition supplémentaire : si la plante vient de brûler (le feu affaiblit la plante)
			//if can_be_set_in_fire == false //donc brûlé
			if(fire_state == FIRE_STATE.BURNED)
			{	
				//La plante a des chances de passer son tour pour ce changement de stade.
				var _r = irandom(5);	//une chance sur 5...
				if(_r == 0)
				{
					event_perform(ev_alarm, 1);	//img++ et réinitialiser days_in_stage
					//Cela fait aussi repasser au sprite_normal, dans le cas d'un incendie (et sprite_burn)
				}
			}
			
			if(fire_state == FIRE_STATE.NORMAL)
			{
				event_perform(ev_alarm, 1);	//img++ et réinitialiser days_in_stage
			}
		}
	}
	
	if(img > img_max) || (days > days_max)	//DYING + SOUCHE
	{
		//SOUCHE D'ARBRE
		if(plant_size == 2) && (1 == 2)
	//	&& (instance_number(obj_flore_souche) < 20) //Arbres
		//Le mieux serait de limiter le nb d'inst en fonction d'une CONCENTRATION, pas d'un nombre absolu.
		{
			//L'arbre a une chance de devenir une souche d'arbre
			var _rd = irandom(10);	
			if (_rd == 1)
			{
				var _souche = instance_create_layer(x, y, "Instances", obj_flore_souche);
					_souche.image_index = 1;
			}
		}
		//Dans tous les cas
		instance_destroy();
	}
	
#endregion

		//TRIGGERS
		//C'EST img QUI DETERMINE L'AGE (anciennement la STATE)
	//	if(img == img_min)							{ growth_stage = AGE.SEED; }
	//	if(img >= img_min) && (img < img_mature)	{ growth_stage = AGE.YOUNG; }
	//	if(img == img_mature)						{ growth_stage = AGE.MATURE; }
	//	if(img == img_old)							{ growth_stage = AGE.OLD; }


#region GROWTH STAGES (STATES anciennement)
	
	//Days >>> détermine Stage (ou image_index) >>> qui détermine AGE
	if(days <= days_to_finish_seed)										{ growth_stage = AGE.SEED; }
	if(days > days_to_finish_seed) && (days <= days_to_finish_young)	{ growth_stage = AGE.YOUNG; }
	if(days > days_to_finish_young) && (days <= days_to_finish_mature)	{ growth_stage = AGE.MATURE; }
	if(days > days_to_finish_mature)									{ growth_stage = AGE.OLD; }
		
	if(growth_stage == AGE.SEED)	
	{
		growth_stage_str	= "SEED";
		img					= img_seed;	//= stage mais bon
		can_propagate_seed	= false;
		can_burn			= false;
		
		//	intense_sparkling_on_object(obj_flore_parent, "Instances", obj_effect_new_seed, 1, 0, 0, 0, COL.YGREEN, 8);	//trop intense
	//	var _hasard = irandom(10);
	//	if(_hasard == 0){
	//		intense_sparkling_on_object(obj_flore_parent, "Instances", obj_effect_new_seed, 2, 0, 0, 0, COL.YGREEN, 8);
	//	}
	}
	
	if(growth_stage != AGE.SEED)
	{
		plant_oscillation_if_contact_step(7);
	}
	
	if(growth_stage == AGE.YOUNG) || (growth_stage == AGE.MATURE)		//(state 1 --> 2) 	//(state 3 --> max -1)
	{
	//	if(stage > 1) && (stage < stage_max)	{ growth_stage = AGE.MATURE; }	//STAGE DETERMINE LA STATE
	//	if(stage >= stage_max)					{ growth_stage = AGE.OLD; }		//STAGE DETERMINE LA STATE
		
		
		if(growth_stage == AGE.YOUNG)	//growth_stage le + long (variable en fonction des sprites des plantes)
		{
			growth_stage_str	= "YOUNG";
			img					= floor((days - durations[AGE.SEED]) div durations[AGE.YOUNG]) + 1;
								//On retire le nombre de jours dans l'étape SEED.
								//On div : division euclidienne ou entière, il y aura un reste qu'on ignore ici, 
								//mais on +1 car jusqu'à ce que le modulo soit de 0, il faut aller à l'image suivante.
			can_propagate_seed	= false;
			can_burn			= true;
		}
		
		//Une plante dans ce state a la particularité de pouvoir brûler (= anime fire + changer de sprite)
		//Dans ce cas on enlève le calque FEUILLE du sprite, et ce jusqu'à la fin du stage.
		//Au passage au stage suivant, on remet les feuilles. MAIS je ne sais pas comment activer/désactiver
		//un calque de sprite pendant le jeu, donc je vais peut-être devoir dupliquer le sprite et en faire une version sans feuille.
		//En fait je vais faire à chaque fois 2 sprite : 1 normal, 1 brulé.
		
		if(growth_stage == AGE.MATURE)	
		{
			growth_stage_str	= "MATURE";	
			img					= img_mature;
			can_propagate_seed	= true;
			can_burn			= true;
			//Doit être géré dans l'event de changement de stage, car ne doit se faire qu'une fois à chaque stage
		}
	}
	
	if(growth_stage == AGE.OLD)	//(stage max)
	{
		growth_stage_str	= "OLD";
		img					= img_old;	//= stage_max
		can_propagate_seed	= false;
		can_burn			= true;
	}
	
#endregion

	
image_index = img;
