///@desc MOVE

fire_img_counter++;

if(can_move_wrap == true){ move_wrap(true, true, 80); }

//if(global.pause == true){ exit; }

#region PAUSE & ALARMS

	if(global.pause == true) || (global.time_acceleration == true)
	{
		if(has_just_been_paused == false)
		{ 
			time_remaining	= alarm_get(3);		//On sauve le temps restant
		}
		alarm[3]				= time_remaining;	//On incrémente l'alarme à l'infini pour ne pas l'activer
		has_just_been_paused	= true; 
		exit;
	}

	else
	{
		if(has_just_been_paused == true)
		{
			alarm[3]				= time_remaining;
			has_just_been_paused	= false;
		}



	if(dir != new_dir)
	{
		dir = lerp(dir, new_dir, 0.05);
	}

		//Mouvement incontrôlé
			//	move_x = sin(0.005 * current_time) * 10;
			//	move_y = sin(0.007 * current_time) * 20;
			if(can_change_dir == true) && (dir == new_dir)	//Fait que l'alarme attends qu'on ait atteind la bonne direction
			{ alarm[7] = can_change_dir_timer; can_change_dir = false; }
			
			move_x = lengthdir_x(move_speed, dir);
			move_y = lengthdir_y(move_speed, dir);
			//move_x = lengthdir_x(move_speed, new_dir);
			//move_y = lengthdir_y(move_speed, new_dir);
			move_x += sin(per * current_time) * amp;
			move_y += sin(per * current_time) * amp;
			x += move_x;
			y += move_y;
	}

#endregion


if(humidity >= humidity_max){ instance_destroy(); }

