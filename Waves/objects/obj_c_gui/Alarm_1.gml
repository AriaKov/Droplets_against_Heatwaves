///@desc MENU DYNAMIQUE


if(show_title_abc == true)
{
	//instance_create_layer(mix, miy, layer, obj_fire_invisible); 
	//instance_create_layer(700, miy, layer, player); //ça ne marche pas
//	instance_activate_object(player);
//	with(obj_c_camera){ mode = CAMMODE.MOVE_TO_TARGET_SMOOTH; }	//Va automatiquement faire un travelling vers target (player)
	
	//Ensuite, une fois que la caméra a rejoint player, le titre s'efface progressivement
	
	//---> dans QUEST_SYSTEM
}


//Pour avoir AGAINST & HEATWAVES en meme temps :
if(show_title_a == true){ show_title_b = true; show_title_c = true; can_iterate_title = true; }

/*
if(show_title_b == true){ show_title_c = true; can_iterate_title = true; }
	
if(show_title_a == true){ show_title_b = true; can_iterate_title = true; }

else					{ show_title_a = true; can_iterate_title = true; }

//On réfléchit à l'envers


