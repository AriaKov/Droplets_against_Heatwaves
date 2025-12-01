///@desc STATES

if(keyboard_check_pressed(ord("B"))){ state = !state; }
if(keyboard_check_pressed(ord("N"))){ event_user(0); }

if(state == FOURMI.NORMAL)
{
	bulle_img = 0;	//Bulle coeur	
}

if(state == FOURMI.ASKING)
{
	bulle_img = 1;	//Bulle question
	
	if(collision_circle(x, y, ray_action, player, false, false) != noone)
	{
		show_details	= true;
		bulle_img		= bulle_img_plant;	//Bulle vide de la bonne taille pour plant_size
	
		//Image de la plante
		plant_img_counter++;
		if(plant_img_counter >= plant_img_speed * global.game_speed)
		{
			plant_img++;			//Image de la plante
			plant_img_counter = 0;	//Réinit
		}
	}
	else
	{
		show_details	= false;
	}

}


