///@desc STEP > ALARM (LATENCE)

if (global.pause == true) {	image_speed = 0; speed = 0; exit; }
else {	image_speed = 1; }


mx = display_mouse_get_x();
my = display_mouse_get_y();

	
#region TRIGGERS

	//VERIFIER LA PRESENCE DE PREDATEURS A CHAQUE ETAPE
	ds_list_clear(ds_list_predateurs); // Effacer la liste précédente
	
	//Ajouter des prédateurs à la liste
	var _predateurs = collision_circle_list(x, y, ray_alert, predateurs, false, true, ds_list_predateurs, true);
	//for (var _i = 0; _i < ds_list_size(_predateurs); _i++)	//heu... inutile !
	{
	//	ds_list_add(ds_list_predateurs, _predateurs[| _i]);
	}
	
	//TRIGGERS --> dans la description des states
	//if (ds_list_size(ds_list_predateurs) > 0) //Présence d'au moins un prédateur dans la liste, donc dans le rayon
	{
		//state = OISEAU_SOLO_STATE.FLYAWAY;
	}
	//else { state = OISEAU_SOLO_STATE.FREE; }
	
#endregion



#region STATES THIEF

	if(state == THIEF_STATE.IDLE) || (state == THIEF_STATE.WANDER)	
	{
		if(instance_exists(player) == true)	//Condition rajoutée pour éviter les bug si player disparait pdt 1 frame
		{
			if(collision_circle(x, y, ray_alert, player, false, false))
			{
				state = THIEF_STATE.RUNAWAY;
			}
		}
		if(instance_exists(target) == true)	//Condition rajoutée pour éviter les bug si player disparait pdt 1 frame
		{
			if(collision_circle(x, y, ray_razzia, target, false, false))
			{
				state = THIEF_STATE.RAZZIA;
			}
		}
	}		
			
	if(state == THIEF_STATE.IDLE)		
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
					case 0: state	= THIEF_STATE.WANDER;
					case 1: counter = 0;					break;
				}
			}
	}


	if (state == THIEF_STATE.WANDER)		//1
	{	
		state_str		= "WANDER";
		sprite_index	= sprite_move;

		counter++;
		x += move_x;
		y += move_y;
	
		//TRANSITION TRIGGER
			if(counter >= global.game_speed * random_range(1, 2))
			{
				var _change = choose(0, 1);
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
	}
	
	
	
	if (state == THIEF_STATE.RAZZIA)		//3
	{
		state_str		= "RAZZIA";
		
		if(move_x != 0){ image_xscale = sign(move_x); }	
	
	
		if(instance_exists(target) == true)	//Condition rajoutée pour éviter les bug si player disparait pdt 1 frame
		{
			//Distance entre soi et la target
			my_dist = point_distance(x, y, target.x, target.y);
		
			if(my_dist > ray_near)	//Suivre la target
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
			
		}
		else { state = PNJ_STATE.IDLE; }
	
	}
	
	
	
	#endregion





#region STATES

	if (state == FAUNA_SOLO_STATE.FREE)
	{
		state_str = "FREE";		//show_debug_message("Animal State : " + string(state_str));
		
		//sprite_index = sprite_idle;
		
		if (can_change_direction == true)
		{
			//Changement de comportement
			timer_free = random_range(1, 10) * global.game_speed;
			alarm[1] = timer_free;
				//show_debug_message("volatiles alarm FREE : " + string(alarm[1]));
		}	

	
		//Vole aléatoirement OU est statique, posé au sol
		//direction = random(30)-15; //aléatoire entre 0 et 30° mais -15° pour centrer sur l'origine
		//speed = move_speed;
	
		can_change_direction = false;
		
		//Si présence de prédateur(s)...
		if (ds_list_size(ds_list_predateurs) != 0)
		{ 
			state = FAUNA_SOLO_STATE.FLYAWAY;	//show_debug_message("Animal State changed to FLY AWAY");
		} 
	}

	if (state == FAUNA_SOLO_STATE.FLYAWAY)
	{
		state_str = "FLY AWAY";	//show_debug_message("Animal State : " + string(state_str));

	//Quel prédateur est le plus proche de l'animal ? C'est celui que l'animal doit fuir.
	//Et pour ne pas garder en mémoire le dernier prédateur même lorqu'il n'est plus présent dans le cercle, on réinitialise la liste.
	//Vérifier si le prédateur est toujours dans la liste
	
	    var _dist_min = ray_max;			// Distance minimale initiale (pour sortir du rayon qui implique la fuite de l'animal)
	    var _predateur_proche_index = -1;	// Index du prédateur le plus proche

		//Au début : On considère que la distance minimale est très grande (ray_max).
		//Pour chaque prédateur : On calcule la distance à l'animal.
		//Si cette distance est plus petite que la distance minimale actuelle :
		//On met à jour la distance minimale.
		//On enregistre l'index du prédateur courant comme étant le plus proche.

	    for (var _i = 0; _i < ds_list_size(ds_list_predateurs); _i++)	//Parcours tous les prédateurs présents
		{
	        var _predateur = ds_list_predateurs[| _i];	//Accéder à chaque prédateur
	        var _target_x = _predateur.x;
	        var _target_y = _predateur.y;
        
	        var _dist = point_distance(x, y, _target_x, _target_y);	//Distance entre l'oiseau et le prédateur
        
	        if (_dist < _dist_min)	//Si le prédateur est dans le cercle (donc reste dans la liste)...
			{
				//Si _dist (la distance du prédateur courant) est <  à _dist_min,
				//cela signifie que ce prédateur est le plus proche que nous avons rencontré jusqu'à présent.
	            _dist_min = _dist; 
	            _predateur_proche_index = _i; //On garde l'index du prédateur le plus proche
	        }
			
					//DEBUG// Afficher le nom de tous les prédateurs à proximité
					var _predateur_name = object_get_name(_predateur.object_index);
				//	show_debug_message("   _predateur_proche : " + _predateur_name + "  " + string(round(_dist))); 
	    }
		
		// Si un prédateur est toujours proche, fuyez-le.
		if (_predateur_proche_index != -1) //anciennement if _dist < ray_max
		{
	        var _predateur_le_plus_proche = ds_list_predateurs[| _predateur_proche_index];	//C'est celui-ci que l'oiseau doit fuir
			//var _predateur_proche = ds_list_predateurs[| 0];	//La plus proche instance de prédateur de la liste

			var _target_x = _predateur_le_plus_proche.x;
			var _target_y = _predateur_le_plus_proche.y	
			
					//DEBUG // Afficher le nom du prédateur le plus proche
				    var _predateur_name = object_get_name(_predateur_le_plus_proche.object_index);	//car ceci ne marche pas : string(asset_get_index(_predateur_proche))
				    //show_debug_message("   _predateur_le_plus_proche : " + _predateur_name + " ( " + string(round(_target_x)) + ", " + string(round(_target_x)) + " )"); 
			//		show_debug_message("   _predateur_le_plus_proche : " + _predateur_name + " " + string(round(point_distance(x, y, _target_x, _target_y)))); 
		
			
		//if _dist < ray_max
		//{
		
			//METHODE X ET Y 
				/*
				// Calculer la direction opposée
		        var _dir_x = x - _target_x; // Direction vers l'oiseau (inverse de follow)
		        var _dir_y = y - _target_y; // Direction vers l'oiseau (inverse de follow)
        
		        // Normaliser la direction
		        var _length = point_distance(0, 0, _dir_x, _dir_y);
		        if (_length > 0) {
		            _dir_x /= _length;
		            _dir_y /= _length;
		        }

		        // Déplacer l'oiseau dans la direction opposée
		        x += _dir_x * move_speed;
		        y += _dir_y * move_speed;
				*/
			
			//METHODE ANGLE
			
				// Calculer la distance
			    var _dist = point_distance(x, y, _target_x, _target_y);
    
		        // Calculer la direction à fuir
		        //var _flee_dir = point_direction(_target_x, _target_y, x, y);
				flee_dir	= point_direction(_target_x, _target_y, x, y);
				direction	= flee_dir;
				
		        // Déplacer l'animal
		        x += lengthdir_x(move_speed, direction);
		        y += lengthdir_y(move_speed, direction);
				
				// Orienter le sprite dans la direction du mouvement
		        //image_angle = direction;
		        image_xscale = sign(lengthdir_x(move_speed, direction));
				
				speed = move_speed;
			
			sprite_index = sprite_move;
		}
		
		//else //if _dist <= ray_max
		else // if (_predateur_proche_index == -1) || _dist <= ray_max
		{
			state = FAUNA_SOLO_STATE.FREE;	// show_debug_message("Animal State changed to FREE");
		}
		
		//if !_predateur_presence { state = OISEAU_SOLO_STATE.FREE; }
	}

	if (state == FAUNA_SOLO_STATE.FOLLOW)
	{
		state_str = "FOLLOW";	//show_debug_message("Animal State : " + string(state_str));
		
		//	var _predateur_proche = ds_list_predateurs[| 0];	//La plus proche instance de prédateur de la liste
		//	var _target_x = _predateur_proche.x;
		//	var _target_y = _predateur_proche.y;	
		
		//Suit player (= target)
		var _target_x = target.x;
		var _target_y = target.y;

		var _dist = point_distance(x, y, _target_x, _target_y);

		if(_dist <= proximite_max)
		{
		    speed = 0;
			//sprite_index = sprite_idle;	
		} 
		if(_dist > proximite_max)
		{
			move_towards_point(_target_x, _target_y, move_speed);
			//sprite_index = sprite_move;	
		}


		//FLIP SPRIT HORIZONTAL
		//var _dir_x = _otf_x - x; //Direction du déplacement horizontal, pour le Flip Sprite
		//if (_dir_x  != 0) image_xscale = sign(_dir_x);

	
		//if !_predateur_presence { state = OISEAU_SOLO_STATE.FREE; }
	}

#endregion


		//x += move_x * move_speed;
		//y += move_y * move_speed;

		
#region SPRITE



	//if speed == 0	//IMMOBILE
	if ((move_x == 0) && (move_y == 0)) || (speed == 0)	//IDLE
	{
		moving = false;
		//image_angle = 0;
		sprite_index = sprite_idle;
		
		//FLIP
		//image_xscale = scale * sign(lengthdir_x(speed, direction));
	}
	if (speed != 0) || (x != xprevious) || (y != yprevious)	//MOVING
	{
		moving = true;
		//image_angle = direction; //flee_angle;	// Orienter le sprite dans la direction du mouvement
		sprite_index = sprite_move;
		
		//FLIP
		//if x != xprevious { image_xscale = scale * sign(lengthdir_x(speed, direction)); }
		
		//y += sin(current_time * 0.001);	//grandes vagues d'oiseaux désordonnés (amibance mouettes)
		//y += sin(current_time * 0.01) / 2;	//flottement pas mal type vol lourdeau
		
		if(sautillement == true) { y += sin(current_time * rand_per) / rand_amp; }

	} 
	
	//FLIP
	if(move_x != 0){ image_xscale = sign(move_x); }	
	
#endregion



/*
var _margin = -32;
x = clamp(x, _margin, global.gui_w - _margin);
y = clamp(y, _margin, global.gui_h - _margin);




