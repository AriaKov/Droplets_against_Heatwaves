/// @desc INTERRACTION

if (global.pause == true) exit;

if(instance_exists(player) == false){ target = noone; }
else { target = player; }

move_wrap(true, true, 32);

//trouver un moyen de désactiver ou supprimer les instances hors de la vue


#region TRIGGERS

	var _target_x, _target_y;
	
	//Set up de la terget
	if(target != noone)
	{
		//show_debug_message("target != noone");
		_target_x = target.x;			
		_target_y = target.y;
		dist_x = distance_to_object(target);	//Distance entre la target et cet objet
	}
	else
	{
		_target_x = mouse_x;			
		_target_y = mouse_y;
		var _dist = point_distance(x, y, _target_x, _target_y);
		var _dir = point_direction(x, y, _target_x, _target_y);
		dist_x = lengthdir_x(_dist, _dir);
	}

	var _interraction = collision_circle(x, y, rayon_action, target, false, false);
	
	if(_interraction != noone)
	{
		state = LUCIOLE.FLYAWAY;	//show_debug_message("interraction");
	}
	else
	{
		state = LUCIOLE.FREE;	//show_debug_message("pas d'interraction");
	}

#endregion


#region STATES

	if(state == LUCIOLE.FREE)
	{
		state_str	= "FREE";
		
		#region SI PAS D'INTERRACTION
			
				//NEW
				dir += sin(0.0005 * current_time) * 0.8;
				move_x = lengthdir_x(move_speed * RES.SCALE, dir);
				move_y = lengthdir_y(move_speed * RES.SCALE, dir);
			
			
			//FLOTTEMENT CONSTANT SUR X
			//floatting_sinusoidal_y(self, self, 0.01, 0.01);
			//floatting_sinusoidal_x(self, self, per + rand_period, amp + rand_amp);
			x += sin(current_time * per + rand_period) * amp + rand_amp;
		

		//	move_x = move_speed_x;
		//	move_y = move_speed_y;
		//	move_x += move_speed_x;
		//	move_y += move_speed_y;

			if(_interraction == false)
			{
			//	x = x + move_x;
			//	y = y + move_y;
				x += move_x + move_speed_x;
				y += move_y + move_speed_y;
			}
	
			#region BALANCEMENT
	
				//LES PLANKTONS SONT EXCITES ET SE CALMENT LORS DE LA COLLISION
				if(balancement == false)
				{
					//angle = sin(current_time * (0.005 + rand_period)) * (random_range(2, 10) + rand_amp);
					angle = 0;
				}	
				else
				{ 
					angle = sin(current_time * (0.1 + rand_period)) * 50 + rand_amp;
				}	
		
			#endregion
	
		#endregion

	}
	if(state == LUCIOLE.FLYAWAY)
	{
		state_str	= "FLYAWAY";	
		
		#region VARIATION EN FONCTION DE L'APPROCHE DU PLAYER
	
		//	if(_interraction != noone)
			{
		//		show_debug_message("interraction");
		
			balancement = false;	//Ca les calme définitivement ?
		
			if(x < _target_x)	//TARGET A DROITE --> on penche à gauche (angle -)
			{
				//Variation de l'angle inversement proportionnelle à la proximité
				//Plus la distance est grande, plus l'angle est faible
				//On peut utiliser un lerp qui fera le lien entre :
				//(SI TARGET A DROITE :) la distance (0, + rayon_action) et l'angle (0, - 45)
				//(SI TARGET A GAUCHE :) la distance (0, - rayon_action) et l'angle (0,  45)
		
				//angle = -45;
				//faisons d'abord proportionnel (donc attiré par la target)
				if(fuir == true){ 	angle = lerp(0, - angle_max, -(1/dist_x)); }
				else			{	angle = lerp(0, - angle_max, (1/dist_x)); }

			
				//x = lerp(x, x + (1/dist_x), -(1/dist_x));
				if(fuir == true){  x = lerp(x, x - (1/dist_x) - espace, (1/dist_x)); }	//Vers la gauche
				else			{  x = lerp(x, x + (1/dist_x) + espace, (1/dist_x)); }
			}
	
			if(_target_x < x)	//TARGET A GAUCHE --> on penche à droite (angle +)
			{
				//angle = 45;
				if(fuir == true){	angle = lerp(0, angle_max, -(1/dist_x)); }
				else			{	angle = lerp(0, angle_max, (1/dist_x)); }
			
			
				//x = lerp(x, x + (1/dist_x), -(1/dist_x));
				if(fuir == true){ x = lerp(x, x + (1/dist_x) + espace, (1/dist_x)); }	//Vers la droite
				else			{ x = lerp(x, x - (1/dist_x) - espace, (1/dist_x)); }
			}
		
		
			if(y < _target_y)
			{
				if(fuir == true){ y = lerp(y, y - (1/dist_x) - espace/2, (1/dist_x)); }	//Vers le haut
				else			{  y = lerp(y, y + (1/dist_x) + espace/2, (1/dist_x)); }
			}
		
			if(_target_y < y)
			{
				if(fuir == true){ y = lerp(y, y + (1/dist_x) + espace/2, (1/dist_x)); }	//Vers le bas
				else			{ y = lerp(y, y - (1/dist_x) - espace/2, (1/dist_x)); }
			}

			}
			
		#endregion
	}

#endregion






#region VARIATION EN FONCTION DE L'APPROCHE DU PLAYER



	//DE BASE, SANS INTERACTION
	//angle = 0;
	//angle = cos(timer * 0.1) * 0.1;

//	if(keyboard_check_direct(ord("H"))){ fuir = !fuir; }
	
	//INTERRACTION


	
	angle = clamp(angle, -angle_max, angle_max);
	image_angle = angle;

#endregion


