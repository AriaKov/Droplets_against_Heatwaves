

/*
	var _target_x, _target_y;


	//QUOI SUIVRE ?
	if(target == noone)	//Si rien de défini, suivre la souris.
	{
		_target_x = mouse_x;	
		_target_y = mouse_y;
	}
	else	//Si un objet_to_follow est défini dans les variables, le suivre.
	{
		if(!instance_exists(target)){ _target_x = mouse_x; _target_y = mouse_y; }
		else
		{
		_target_x = target.x;
		_target_y = target.y;
		}
	}


	#region SE DEPLACER

		var _dist = point_distance(x, y, _target_x, _target_y);

		if _dist <= proximite_max
		{
		    speed = 0;
			sprite_index = spr_fish_idle;	
		
			if(audio_is_playing(snd_MP3_Wing_Flapping))
			{	audio_stop_sound(snd_MP3_Wing_Flapping);  }
		} 
		if _dist > proximite_max
		{
			///////CLIC GAUCHE OU DES QUE DEPLACEMENT NECESSAIRE
			//New point to reach
			x_from = x;		y_from = y;
			x_to = _target_x;	y_to = _target_y;
			amt = 0;
		
			//image_angle = point_direction(x_from, y_from, x_to, y_to);
	
			///////EXECUTE MOVEMENTS
			if amt < 100
			{   
			    amt += 1;
				var _coord = zap_constant_move(x_from, y_from, x_to, y_to, njumps, amt);
				x = _coord[0];
			    y = _coord[1];
		
				move_towards_point(_target_x, _target_y, move_speed);
				sprite_index = spr_fish_move;
			
				if(!audio_is_playing(snd_MP3_Wing_Flapping) && ( point_distance(x, y, _target_x, _target_y) < 100 ))
				{	audio_play_sound(snd_MP3_Wing_Flapping, 1, true);  }
			}
	
			//move_towards_point(_target_x, _target_y, move_speed);
			//sprite_index = sprite_move;	
		}
	
			if(audio_is_playing(snd_MP3_Wing_Flapping) && ( point_distance(x, y, _target_x, _target_y) >= 100 ))
			{	audio_stop_sound(snd_MP3_Wing_Flapping);  }

	#endregion



		var _dir = point_direction(x, y, _target_x, _target_y);
		move_x = lengthdir_x(move_speed, _dir);
		move_y = lengthdir_y(move_speed, _dir);
	
		#region COLLISIONS CHECKS		(copié brutalement depuis obj_player_3d_parent)
	
		//tuto : https://www.youtube.com/watch?v=Tc4ijzjplZs
		
		//HORIZONTAL
		if(move_x != 0)	//Si on bouge sur x
		{
			if(place_meeting(x + move_x, y, _collision))	//Si collision anticipée au prochain déplacement à la vitesse move_speed...
			{
				repeat(abs(move_x))					//Pour le nombre de fois (valeur absolue) que de pixel voulus de déplacement...
				{
					if(!place_meeting(x + sign(move_x), y, _collision))	//...si pas de collision devant...
					{
						x += sign(move_x); 			//...on avance d'un pixel.
					}
					else { break; }
				}		
				move_x = 0;							//...sinon on s'arrête.
			}
		}

		//VERTICAL
		if(move_y != 0)	//Si on bouge sur y
		{
			if(place_meeting(x, y + move_y, _collision))	//Si collision anticipée au prochain déplacement à la vitesse move_speed...
			{
				repeat(abs(move_y))					//Pour le nombre de fois (valeur absolue) que de pixel voulus de déplacement...
				{
					if(!place_meeting(x, y + sign(move_y), _collision))	//...si pas de collision devant...
					{
						y += sign(move_y); 			//...on avance d'un pixel.
					}
					else { break; }
				}
				move_y = 0;							//...sinon on s'arrête.
			}
		}
		
		#endregion





	#region FLIP SPRITE HORIZONTAL

		var _dir_x = _target_x - x; //Direction du déplacement horizontal, pour le Flip Sprite
		var _dir_y = _target_y - y;
		if (_dir_x != 0) image_xscale = sign(_dir_x);
		//if (_dir_x < 0) image_xscale = sign(_dir_x);

		//Direction dans les 4 cadrants du cercle trigo et les image_XYscale associées :
		//0-90 (x+ y+), 90-180 (x- y+), 180-270 (x- y+), 270-360 (x+ y+)
		//

		//if(_dir_y < 0 && _dir_x != 0){
		//	image_yscale = -1;
		//	image_xscale = sign(_dir_x);
		}

		//if (image_yscale = -1) image_yscale = 1;

	#endregion


	#region C H A N G E M E N T   A L E A T O I R E   D ' E M P L A C E M E N T   S I   C O L L I S I O N
	
		var _remaining_loops = 1000;
		var _decalage_x = 1;	//20
		var _decalage_y = 1;	//20

		while((place_meeting (x,y, obj_ribambelle_fish_parent)) or (place_meeting (x,y, obj_collision_parent)) ) && (_remaining_loops > 0)
		{
			x = random_range(x - _decalage_x, x + _decalage_x);
			y = random_range(y - _decalage_y, y + _decalage_y);
			_remaining_loops -= 1;
			//if !audio_is_playing(snd_book_close_02){ audio_play_sound(snd_book_close_02,1,0); }
		} 
	
	#endregion




