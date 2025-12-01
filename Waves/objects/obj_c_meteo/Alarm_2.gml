///@desc Midday : FIRE

//show_message("METEO : Midday : Création d'instance");
	
//	if(room == rm_start) exit;

	if(1 == 2)
	{
		//Apparition d'objet fire (ou déclencheur du fire)
			var _x, _y;

			var _rx = irandom_range(64, 128);
			var _ry = irandom_range(64, 128);
	
			if(instance_exists(player))
			{	
				//_x = player.x;	_y = player.y;
				_x = player.x + choose(-_rx, _rx);
				_y = player.y + choose(-_ry, _ry)
			}
			else
			{	_x = 200;
				_y = 300;
			}
			instance_create_layer(_x, _y, "Instances", feu_follet);
	}


can_set_event_fire	= false;


