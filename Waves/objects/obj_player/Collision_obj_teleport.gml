///@desc ROOM TRANSITION



if(water_state != PLAYER_HUMIDITY.RAGE)
{
	with(other)
	{
		//	room_goto(target_room);
		event_user(1);
		
		//Indication de direction
	how_indicator = true;	
	}
}


