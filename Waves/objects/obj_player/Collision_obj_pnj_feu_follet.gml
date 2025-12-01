

// event_user(7);

///@desc BURNING
//EVENT_USER(7)

//if(water_state != PLAYER_HUMIDITY.RAGE) 
{
	//Ajouter contrainte pour ne pas utiliser burning() plusieurs fois si plusieurs feux
	var _number = array_length(num_of_fire_simultaneously_burning_player);
	if(_number < num_of_fire_simultaneously_burning_player_max)
	{
		array_push(num_of_fire_simultaneously_burning_player, other); //Vidée à chaque frame dans STEP
		
		burning(burning_speed * 2);
	}
}


