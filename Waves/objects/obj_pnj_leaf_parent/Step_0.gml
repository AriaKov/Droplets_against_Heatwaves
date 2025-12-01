///@desc 

if(global.pause == true) { exit; }

move_wrap(true, true, 100);

///// COMPORTEMENT AVEC LATENCE
//alarm[0] = random(40);
//alarm[0] = irandom(20);



///// C O L L I S I O N S
//var _collision	= instance_place(x + max(1, move_x), y + max(1, move_y), [obj_collision_parent, tilemap]);


#region STATES

	if(state == PNJ_STATE.IDLE)		//0
	{
		state_str		= "IDLE";
		sprite_index	= sprite_idle;	
	
		counter++;	//Attendre
	
		//TRANSITION TRIGGER : 1 chance sur 2 de se déplacer (Wander)
			if(counter >= (global.game_speed * random_range(3, 4)))
			{
				var _change = choose(0, 1);
				switch(_change)
				{
					case 0: state	= PNJ_STATE.WANDER;
					case 1: counter = 0;					break;
				}
			}
	
			if(instance_exists(target))	//Condition rajoutée pour éviter les bug si player disparait pdt 1 frame
			{
				if(collision_circle(x, y, rayon_alert, target, false, false))
				{
					state = PNJ_STATE.FOLLOW;
				}
			}
	}

	if (state == PNJ_STATE.WANDER)		//1
	{	
		state_str		= "WANDER";
		sprite_index	= sprite_move;

		counter++;
		x += move_x;
		y += move_y;
	
		//TRANSITION TRIGGER
			if(counter >= global.game_speed * random_range(1, 2))
			{
				var _change = choose(0,1);
				switch(_change)
				{
					case 0: state = PNJ_STATE.IDLE;
					case 1: 
						//Vecteur de direction aléatoire
						my_dir = irandom_range(1, 360);
						//Traduction en 2 composantes h et v
						move_x = lengthdir_x(move_speed, my_dir);
						move_y = lengthdir_y(move_speed, my_dir);
						counter = 0;
				}
			}
	
			if(instance_exists(target))	//Condition rajoutée pour éviter les bug si player disparait pdt 1 frame
			{
				if(collision_circle(x, y, rayon_alert, target, false, false))
				{
					state = PNJ_STATE.FOLLOW;
				}
			}
	}

	if (state == PNJ_STATE.RUNAWAY)		//2
	{
		state_str		= "RUNAWAY";
		sprite_index	= sprite_move;
		if(move_x != 0){ image_xscale = sign(move_x); }	
	
		if(instance_exists(target))	//Condition rajoutée pour éviter les bug si player disparait pdt 1 frame
		{
			//Vecteur de direction
			my_dir = - point_direction(x, y, target.x, target.y);		//NEGATIF CAR FUIR AU LIEU DE SUIVRE
	
			//Traduction en 2 composantes h et v
			move_x = lengthdir_x(move_speed, my_dir);
			move_y = lengthdir_y(move_speed, my_dir);
			x += move_x;
			y += move_y;
		
			//TRANSITION TRIGGER
			if (collision_circle(x, y, rayon_alert * rayon_lacherlagrappe, target, false, false) == false)	//Rayon plus grand pour qu'il lache la grappe
			{
				state = PNJ_STATE.IDLE;
			}
		}
		else { state = PNJ_STATE.IDLE; }
	}

	if (state == PNJ_STATE.FOLLOW)		//3
	{
		state_str		= "FOLLOW";
		
		if(move_x != 0){ image_xscale = sign(move_x); }	
	
	
		if(instance_exists(target) == true)	//Condition rajoutée pour éviter les bug si player disparait pdt 1 frame
		{
			//Distance entre soi et la target
			my_dist = point_distance(x, y, target.x, target.y);
		
			if(my_dist > rayon_near)	//Suivre la target
			{
				show_debug_message("FOLLOW > Suivre target > moving");
				
				//Vecteur de direction
				my_dir = point_direction(x, y, target.x, target.y); 
	
				//Traduction en 2 composantes h et v
				move_x = lengthdir_x(move_speed, my_dir);
				move_y = lengthdir_y(move_speed, my_dir);
				
				sprite_index	= sprite_move;
			}
		
			if(my_dist <= rayon_near)	//Arret si très proche
			{
				show_debug_message("FOLLOW > On est proche de la target > stop moving");
				move_x = 0;
				move_y = 0;
				
				sprite_index	= sprite_idle;
			}
		
				x += move_x;
				y += move_y;
			

			//TRANSITION TRIGGER
			if(my_dist > (rayon_alert * rayon_lacherlagrappe))	//Rayon plus grand pour qu'il lache la grappe
			{
				state = PNJ_STATE.IDLE;	show_debug_message("FOLLOW > player trop loin > IDLE");
			}
			//if(collision_circle(x, y, rayon_alert * rayon_lacherlagrappe, target, false, false) == false)	//Rayon plus grand pour qu'il lache la grappe
			{
			//	state = PNJ_STATE.IDLE;	show_debug_message("FOLLOW > player trop loin > IDLE");
			}
			//else { state = PNJ_STATE.IDLE; }
		}
		else { state = PNJ_STATE.IDLE; show_debug_message("FOLLOW > No player > IDLE"); }
	
	}

#endregion


#region C H A N G E M E N T   A L E A T O I R E   D ' E M P L A C E M E N T   S I   C O L L I S I O N
	
	if(avoid_others == true)	//FAIRE UN MEILLEUR SYSTEM DE COLLISIONS !
	{
		var _remaining_loops = 1000;
		var _decalage_x = 1;	//20	//0.1
		var _decalage_y = 1;	//20	//0.1

		while((place_meeting (x, y, obj_pnj_leaf_parent)) or (place_meeting (x,y, obj_collision_parent)) ) && (_remaining_loops > 0)
		{
			x = random_range(x - _decalage_x, x + _decalage_x);
			y = random_range(y - _decalage_y, y + _decalage_y);
			_remaining_loops -= 1;
			//if !audio_is_playing(snd_book_close_02){ audio_play_sound(snd_book_close_02,1,0); }
		}
	}
	
#endregion



#region SOUNDS

	//SON DES PAS CLIQUETTIS A CHAQUE DEBUT D'ANIM DU SPRITE : SI MOVE ET PERIMETRE PROCHE DE PLAYER
	if(instance_exists(target) == true)
	{
		if(point_distance(x, y, target.x, target.y) < rayon_audition)	//Si dans le rayon d'audition
		{
			//if(!move_x == 0 or !move_y == 0)					//Si move
			if(move_x != 0 or move_y != 0)						//Si move
					//&& (image_index == 0))					//Et début d'anim
			{
			//	if(!audio_is_playing(sound_step)){ audio_play_sound(sound_step, 1, false); }
			}
		}
	}

#endregion

		