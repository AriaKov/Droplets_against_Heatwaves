///@desc GIVE PLANT

if(other.state == FOURMI.ASKING)	//Si le PNJ est en demande d'un objet...
{
	if(input_keyboard_or_gamepad_check_pressed(global.key_absorbe, global.gp_absorbe) == true)
	{
		//On regarde la plante demandée...
		var _plant_to_give = other.plant;
	
		//Si on a la plante demandée dans global.grid_flore...
		
	
		//...on la lui donne.
		give_seed(_plant_to_give, 1);
	
		//Sound effect dans le script
		
		//...et le pnj cesse de demander et incrémente sa demande pour + tard
		
	}
}











