///@desc HOURLY


show_message("Nouvelle heure ! --> Event + FALSE");
					
//"Donner de l'âge" aux plantes + rapidement
with(obj_flore_parent)
{
	//repeat(irandom(days_to_finish_mature))
	{
		event_perform(ev_alarm, 0);	
	}
}

can_set_event_hourly = false;










