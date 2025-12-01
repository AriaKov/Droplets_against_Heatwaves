///@desc CHANGE DIR

var _target_x, _target_y;


#region STATES

	if(pnj_state == STATE.FREE)
	{

	
	}
	if(pnj_state == STATE.FOLLOW)
	{
		#region TARGET
		
			if (target == 0) { }	//Si rien de défini, ne rien faire

			if (target == noone)	//Si noone défini, suivre la souris.
			{
				_target_x = mouse_x;	
				_target_y = mouse_y;
			}
			else	//Si un objet_to_follow est défini dans les variables, le suivre.
			{
				_target_x = target.x;
				_target_y = target.y;
			}
			
		#endregion

		#region MOVE

			var _dist = point_distance(x, y, _target_x, _target_y);

			if(_dist <= proximite_max)
			{
			    speed = 0;
				sprite_index = sprite_idle;	
			} 
			if(_dist > proximite_max)
			{
				///////CLIC GAUCHE OU DES QUE DEPLACEMENT NECESSAIRE
				//New point to reach
				x_from	= x;			y_from	= y;
				x_to	= _target_x;	y_to	= _target_y;
				amt		= 0;
				//image_angle = point_direction(x_from, y_from, x_to, y_to);
	
				///////EXECUTE MOVEMENTS
				if(amt < 100)
				{   
				    amt += 1;
					var _coord = zap_constant_move(x_from, y_from, x_to, y_to, njumps, amt);
					x = _coord[0];
				    y = _coord[1];
		
					move_towards_point(_target_x, _target_y, move_speed);
				}
	
				//move_towards_point(_target_x, _target_y, move_speed);
				sprite_index = sprite_move;	
			}
		#endregion

		#region FLIP SPRITE HORIZONTAL

			var _dir_x = _target_x - x; //Direction du déplacement horizontal, pour le Flip Sprite
			var _dir_y = _target_y - y;
			if (_dir_x != 0) { image_xscale = sign(_dir_x); }
			//if (_dir_x < 0) { image_xscale = sign(_dir_x); }

			//Direction dans les 4 cadrants du cercle trigo et les image_XYscale associées :
			//0-90 (x+ y+), 90-180 (x- y+), 180-270 (x- y+), 270-360 (x+ y+)
			//

			/*if(_dir_y < 0 && _dir_x != 0){
				image_yscale = -1;
				image_xscale = sign(_dir_x);
			}*/

			//if (image_yscale = -1) image_yscale = 1;

		#endregion

		#region COLLISION > CHANGEMENT ALEATOIRE D'EMPLACEMENT

			var _remaining_loops = 1000;
			var _decalage_x = 1;	//20
			var _decalage_y = 1;	//20

			while((place_meeting (x,y, obj_ribambelle_parent)) or (place_meeting (x,y, collisionnables)) ) && (_remaining_loops > 0)
			{
				x = random_range(x - _decalage_x, x + _decalage_x);
				y = random_range(y - _decalage_y, y + _decalage_y);
				_remaining_loops -= 1;
				//if !audio_is_playing(snd_book_close_02){ audio_play_sound(snd_book_close_02,1,0); }
			} 

		#endregion


	}

#endregion


	latency				= irandom(20);
	alarm[0]			= latency;
//	can_activate_alarm	= true;
