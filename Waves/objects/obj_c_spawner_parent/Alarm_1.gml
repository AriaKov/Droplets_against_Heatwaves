///@desc SPAWN

if(instance_number(obj_to_spawn) > number_max_in_room) exit;

//Position du spawn
var _xx = 0; var _yy = 0;

count++;

var _obj_to_spawn = choose(
	obj_faune_bird,
	obj_faune_butterfly,
	obj_faune_fox,
	obj_faune_ourson,
	);
_obj_to_spawn = obj_to_spawn;


if(spawn_outside_camera == false)
{
	while(place_meeting(_xx, _yy, collisionnables) == true)
	{
	//Spawn in the entire room
	_xx = random_range(0, room_w);
	_yy = random_range(0, room_h);
	}
}

if(spawn_outside_camera == true)
{
	var _cx, _cy, _cw, _ch;
	
	if(instance_exists(obj_c_camera) == true)
	{
		//Position de l'origine de la caméra dans la room
		_cx = obj_c_camera.cx;
		_cy = obj_c_camera.cy;

		//Largeur et hauteur de la caméra
		_cw	= obj_c_camera.cam_w;
		_ch	= obj_c_camera.cam_h;
	}
	var _espace = margin + 0;
			
	//Position du spawn
		//Si la position horizontale n'importe pas, on doit éviter la zone centrale verticale.
		//Si la position horizontale exclue le centre, alors c'est la position verticale qui importe peu.
		//Tout ceci pour définir une zone de possibilité autour de la zone de caméra (même si les 8 blocs autour n'ont pas les mêmes proba)
		var _zone = choose(0, 1);
	
		var _side;
		var _debug = "";

			switch(_zone)
			{
				case 0:	//Position horizontale en dehors de la zone de caméra, position verticale libre (mais clampée).
					_side = choose(-1, 1);	//A droite ou à gauche
					if(_side == -1)	{ _xx = _cx - _espace;			_debug = "à gauche";	}
					if(_side == 1)	{ _xx = _cx + _cw + _espace;	_debug = "à droite";	}
					//_xx = choose((_cx - _espace), (_cx + _cw + _espace));	
				
					_yy = random_range((_cy - _espace), (_cy + _ch + _espace));	//N'importe où
					break;
		
				case 1:	//Position horizontale libre (mais clampée), position verticale en dehors de la caméra.
					_side = choose(-1, 1);	//En haut ou en bas
					if(_side == -1)	{ _yy = _cy - _espace;			_debug = "en haut";		}
					if(_side == 1)	{ _yy = _cy + _ch + _espace;	_debug = "en bas";		}
					_xx = random_range((_cx - _espace), (_cx + _cw + _espace));	//N'importe où
					break;
			}
			
		while(place_meeting(_xx, _yy, collisionnables) == true)
		{
			switch(_zone)
			{
				case 0:	//Position horizontale en dehors de la zone de caméra, position verticale libre (mais clampée).
					_side = choose(-1, 1);	//A droite ou à gauche
					if(_side == -1)	{ _xx = _cx - _espace;			_debug = "à gauche";	}
					if(_side == 1)	{ _xx = _cx + _cw + _espace;	_debug = "à droite";	}
					//_xx = choose((_cx - _espace), (_cx + _cw + _espace));	
				
					_yy = random_range((_cy - _espace), (_cy + _ch + _espace));	//N'importe où
					break;
		
				case 1:	//Position horizontale libre (mais clampée), position verticale en dehors de la caméra.
					_side = choose(-1, 1);	//En haut ou en bas
					if(_side == -1)	{ _yy = _cy - _espace;			_debug = "en haut";		}
					if(_side == 1)	{ _yy = _cy + _ch + _espace;	_debug = "en bas";		}
					_xx = random_range((_cx - _espace), (_cx + _cw + _espace));	//N'importe où
					break;
			}
		}
		
	//EXCLURE LES TILES D'EAU !
	
	
	//show_debug_message("SPAWN " + string(count) + " : " + string(_debug) + " (" + string(_xx) + ", " + string(_yy) + ") " + string(object_get_name(_obj_to_spawn)));

}
	
//instance_create_layer(_cx, _cy, "Instances", _obj_to_spawn);
instance_create_layer(_xx, _yy, "Instances", _obj_to_spawn);

latency		= (latency_sec + random(3)) * global.game_speed;	
alarm[1]	= latency;

