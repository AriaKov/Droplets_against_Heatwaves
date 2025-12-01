///@desc EVENTS


if(instance_exists(object_cycle))
{
	with(object_cycle)
	{
		if(minutes >= 30) && (minutes < 50) // && (seconds == 0)
		{
			with(obj_c_meteo) 
			{	
		//		if(can_set_event_hourly == true) { event_perform(ev_alarm, 5); }
			}
		}
	//	if(minutes >= 55) && (minutes < 60) && (obj_c_meteo.can_set_event_hourly == false)
		{ 
	//		obj_c_meteo.can_set_event_hourly = true;
	//		show_message("Nouvelle heure ! --> TRUE");
		}
		
		
		if(hours >= 12)	//MIDI : FIRE
		{
			with(obj_c_meteo) 
			{	
				//Qu'une seule fois par jour (can_set... est réinit dans event_user(1))
				if(can_set_event_fire == true) { event_perform(ev_alarm, 2); }
			}
		}
		
		if(hours >= 15)	// ...?
		{
			with(obj_c_meteo) 
			{	
				//Qu'une seule fois par jour (can_set... est réinit dans event_user(1))
				if(can_set_event_day == true) { event_perform(ev_alarm, 3); }
			}
		}
	
		if(hours >= 24) //NOUVELLE JOURNEE (MIDNIGHT)
		{
			//seconds = 0;	//Dans cycle day night
			with(obj_c_meteo) { event_perform(ev_alarm, 1); }
		}
		
	}
}


#region METEO - BRUME (propabilité d'apparaitre à minuit)

	if(meteo_brume == true)
	//meteo_brume est contrôlé par un event aléatoire dans obj_c_cycle_day_night.
	{ 
		if(can_activate_brume == true)
		{
		//	alpha_brume_wanted = alpha_brume_max;	//Alpha a atteindre
			can_activate_brume = false;
		}
	}
	else {
		if(can_activate_brume == false)
		{
			alpha_brume_wanted = 0;			//Alpha a atteindre
			can_activate_brume = true;	
		}
	}

	//Alpha progressif dans les deux sens
	if(abs(alpha_brume_wanted - alpha_brume) > 0.01)	//Pour éviter l'infiniment petit
	{
		alpha_brume = lerp(alpha_brume, alpha_brume_wanted, alpha_brume_inc);
	
		//Application de l'alpha au layer Brume
		var _layer_id = layer_background_get_id("Background_Brume");
		layer_background_alpha(_layer_id, alpha_brume);
	}
	else { alpha_brume = alpha_brume_wanted; }

#endregion


#region METEO - RAIN

	//Application de la pluie
	//var _layer_id = layer_background_get_id("Particle_Rain");
	layer_enable_fx("Particle_Rain", meteo_rain);
	
#endregion	
	
	//OK :-) Applique un effet sur un seul layer. ATTENTION : ne marche pas si on a Draw autre chose que draw_self dans les objets.
//	effect_fx = fx_create("_effect_glow");
//	fx_set_single_layer(effect_fx, true);
//	layer_set_fx("Background_Brume", effect_fx);
	
	
	/*
		//var _fx_struct = layer_get_fx("TintEffect");
		var _fx_struct = effect_fx;
		//var _param		= fx_get_parameters(_fx_struct);
		// si filter outline
		//	_param.g_OutlineColour		= c_blue;
		//	_param.g_OutlineRadius		= 16;
		//	_param.g_OutlinePixel_Scale = 2;
		
		fx_set_single_layer(effect_fx, true);
		layer_set_fx("Instances_Items", effect_fx);
		if( collision_circle(player.x, player.y, 64, obj_tool_watch66, false, false) )
		{
			layer_enable_fx("Instances_Items", true);
		}
		else { layer_enable_fx("Instances_Items", false); }
	//layer_set_fx("Instances_FX", effect_fx);
	*/
	






