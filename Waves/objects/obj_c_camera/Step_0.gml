///@desc MODES + OPTIMISATION



//Switch = selon le mode, agit ainsi …
switch(mode)
{
	case CAMMODE.INERT:
		cx = 0;
		cy = 0;
	
	break;
	
	#region FOLLOW OBJECT (0) : La caméra suit otf
	case CAMMODE.FOLLOW_OBJECT:
		
		//Vérifier l'existence du objet à suivre. Si pas, on sort de ce mode
		if(instance_exists(otf) == false) break;
		
		//if(keyboard_check_pressed(ord("Y"))){ otf = global.weapon; }
		//if(keyboard_check_pressed(ord("U"))){ otf = global.player; }
		//if(keyboard_check_pressed(ord("Y"))){ camera_follow_new_object_smooth(obj_fountain, 0, -100 ); }
		//if(keyboard_check_pressed(ord("U"))){ camera_follow_new_object_smooth(global.player); }		
		
		
		if(instance_exists(otf) == true)
		{
		//Placer les coordonnées de la cam
		//PS : les coord de la cam indiquent le coin sup gauche de la cam alors que les coord de l'otf indiquent sa position précise. On doit donc soustraire la moitié de la taille de la vue [0]
		cx = otf.x - (view_w/2);
		cy = otf.y - (view_h/2);
		}
		
	break;
	#endregion
	
	#region FOLLOW MOUSE DRAG (1) : Le + tricky !!
	case CAMMODE.FOLLOW_MOUSE_DRAG:	
	
		//On n'utilise pas mouse_x et mouse_y car ce sont les coord par rapport au world (room)
		//qui changeraient donc en fonction de la position de la caméra, même si on n'a pas bougé la souris.
		//On utilise la position de la souris par rapport à l'écran affiché : display
		var _mx = display_mouse_get_x();
		var _my = display_mouse_get_y();
		
		if (mouse_check_button(mb_left)){
			cx += (mouse_xprevious - _mx) * 0.5;	//*0.5	
			cy += (mouse_yprevious - _my) * 0.5;	//*0.5
		}
		mouse_xprevious = _mx;
		mouse_yprevious = _my;
		
	break ;
	#endregion
	
	#region FOLLOW MOUSE BORDER (2) : La caméra bouge quand on atteint les bords de l'écran.
	case CAMMODE.FOLLOW_MOUSE_BORDER :
	
		//On vérifie si la souris est dans le rectangle définit ci dessous
		var _x1 = cx + (view_w*0.1);	//0.1 = 10% de la largeur de la vue
		var _y1 = cy + (view_h*0.1);
		var _x2 = cx + (view_w*0.9);
		var _y2 = cy + (view_h*0.9);
		
		/*
		#region Affichage du cadre en surimpression... pour tester
		var c = c_blue;
		draw_set_alpha(0.5);
		draw_rectangle_color(_x1, _y1, _x2, _y2, c,c,c,c, false);
		draw_set_alpha(1);
		#endregion
		*/
		
		if (!point_in_rectangle(mouse_x, mouse_y, _x1, _y1, _x2, _y2)){
			//Si la souris n'est pas dans l'aire centrale
			//On bouge la caméra vers la souris (qui est sur les bords)
			cx = lerp(cx, mouse_x - (view_w/2), 0.05);
			cy = lerp(cy, mouse_y - (view_h/2), 0.05);
			//La fonction lerp lie 2 valeurs (arg1 et arg2) par un % (arg3) et crée une valeur.
			//Elle fait une sorte de moyenne entre les 2 premières valeurs, à la distance % de l'arg 1.
			//Plus la valeur (%) est grande plus cx ou cy sera proche de l'arg 2
		}
		
	break ;
	#endregion
	
	#region FOLLOW MOUSE PEEK (3) : La caméra suit otf, avec influence minime de la souris.
	case CAMMODE.FOLLOW_MOUSE_PEEK :
	
		cx = lerp(otf.x, mouse_x, 0.2) - (view_w/2);
		cy = lerp(otf.y, mouse_y, 0.2) - (view_h/2);
		//Fonction lerp : Plus la valeur (%) est grande plus cx ou cy sera proche de l'arg 2 (mouse)	
		
	break ;
	#endregion
	
//////////////// TEST CUTSCENE //////////////////////////////
	#region FOLLOW OTHER PEEK (3) : La caméra suit otf, avec influence minime de l'AUTRE OBJECT.
	case CAMMODE.FOLLOW_OTHER_PEEK :
	
		if(instance_exists(other_object))
		{
			cx = lerp(otf.x, other_object.x, 0.2) - (view_w/2);
			cy = lerp(otf.y, other_object.y, 0.2) - (view_h/2);
		}
		else break;
		
	break ;
	#endregion
///////////////////////////////////////////////////////////////

	#region MOVE TO TARGET (4) : La caméra jump là où on vient de cliquer (tuto incomplet ?)
	case CAMMODE.MOVE_TO_TARGET :
	
		//Nouveau clic = Nouvelle position à atteindre
		/*tentative
		target_x = mouse_x;
		target_y = mouse_y;
		cx = lerp(cx, target_x, 0.1) - (view_w/2);
		cy = lerp(cy, target_y, 0.1) - (view_h/2);
		*/
		var _target_x = (target_x - (view_w/2));
		var _target_y = (target_y - (view_h/2));
		//Va de - en - vite
		cx = lerp(cx, _target_x, lerp_amount);
		cy = lerp(cy, _target_y, lerp_amount);
		
		/*DoSub :2: Malformed variable cx = lerp(cx, target_x - (view_w/2), 0.1);*/
		
		//Revenir à FOLLOW OBJECT une fois la cible atteinte
		if(cx == _target_x) || (cy == _target_y) { mode = CAMMODE.FOLLOW_OBJECT; }
		
	break;
	#endregion
	
	#region MOVE TO FOLLOW OBJECT (5) : La caméra suit quoi... ?
	case CAMMODE.MOVE_TO_FOLLOW_OBJECT :
	
		//Vérifier l'existence du objet à suivre. Si pas, on sort de ce mode
		if (instance_exists(otf) == false) break;
		
		var _posx =  otf.x - (view_w/2);	//Position de otf "corrigée" (avec prise en compte de l'origine des coord de la caméra)
		var _posy =  otf.y - (view_h/2);	
		
		cx = lerp(cx, _posx - (view_h/2), 0.1);
		cy = lerp(cy, _posy - (view_h/2), 0.1);

		//Pour cesser de s'approcher infinitésimalement et se poser à 100% à la position finale
		if(point_distance(cx, cy, _posx, _posy) < 1)
		{
			mode = CAMMODE.FOLLOW_OBJECT;
		}
	
	break;
	#endregion
	
	#region MOVE_TO_TARGET_SMOOTH (6)
	case CAMMODE.MOVE_TO_TARGET_SMOOTH:
	
		//Pour le mode 4 (move_to_target)
		if(instance_exists(otf) == true)
		{
			var _y = otf.y;
				if(otf == obj_player){ _y = otf.drop_y; } //car niveau du visage + haut que y
			target_x = otf.x - (view_w/2);
			target_y = _y - (view_h/2);
		}

		//var _target_x = (target_x - (view_w/2));
		//var _target_y = (target_y - (view_h/2));
		
		dir		= point_direction(cx, cy, target_x, target_y);
		dist	= point_distance(cx, cy, target_x, target_y);
		
	/*	
	var _taux = amt/100;
	var _dir = point_direction(x_from,y_from,x_to,y_to);
	var _total_distance = point_distance(x_from, y_from ,x_to ,y_to);
	var _d_L = (- 2 * power(_taux,3) + 3 * power(_taux,2)) * _total_distance;

	var _delta_x  = lengthdir_x(_d_L, _dir);
	var _delta_y  = lengthdir_y(_d_L, _dir);

	coord[0] = x_from + _delta_x;
	coord[1] = y_from + _delta_y;
	*/
		
	/*	var _amt = 5;	//10;
		var _taux = _amt/100;
		var _d_L = (- 2 * power(_taux, 3) + 3 * power(_taux, 2)) * dist;
		var _delta_x = lengthdir_x(_d_L, dir);
		var _delta_y = lengthdir_y(_d_L, dir);
		cx += _delta_x;
		cy += _delta_y;
	*/	
		
	//	if(dist > dist - 64)	//Loin
		if(dist > 1)
		{
			//Accélération
		//	cx = lerp(cx, target_x, lerp_amount * (80/dist));	// * (100/dist) c'est au pif ! ça marche :)
		//	cy = lerp(cy, target_y, lerp_amount * (80/dist));
	//	lerp_amount = 0.04;
			cx = lerp(cx, target_x, lerp_amount * (80/dist));	
			cy = lerp(cy, target_y, lerp_amount * (80/dist));	
		}
		/*
		if(dist < 64)	//Proche
		{
			//Ralentissement
			cx = lerp(cx, target_x, lerp_amount);
			cy = lerp(cy, target_y, lerp_amount);	
		}
		else	//Intermédiaire
		{
			//Déplacement à vistesse constante	
			cx += speed_constant * sign(target_x);
			cy += speed_constant * sign(target_y);
		}
		*/
		
		
		/*DoSub :2: Malformed variable cx = lerp(cx, target_x - (view_w/2), 0.1);*/
		
		//Revenir à FOLLOW OBJECT une fois la cible atteinte --> DANS QUEST_SYSTEM
	//	if(cx == target_x) || (cy == target_y) { mode = CAMMODE.FOLLOW_OBJECT; }

	break;
	#endregion
}


//Rester dans les limites de la room
if(boundless == false)
{
	cx = clamp(cx, 0, room_width - view_w);
	cy = clamp(cy, 0, room_height - view_h);
}

camera_set_view_pos(cam, cx, cy);

//Le tout est contrôlé par un script (change_camera_mode) appelé dans des Events de Player_Parent ! :)


#region SCREEN SHAKE
	
	//if(keyboard_check_pressed(ord("S")) == true){ shake_camera = !shake_camera; }
	
	
	if((shake_camera == true) )// || keyboard_check_pressed(vk_shift))
	&& (global.pause == false)
	{
		var _shake_x = cx + random_range(-shake_camera_amount, shake_camera_amount);
		var _shake_y = cy + random_range(-shake_camera_amount, shake_camera_amount);
		camera_set_view_pos(cam, _shake_x, _shake_y); 
		
		//Courte durée
		if(can_shake_camera == true){ alarm[1] = shake_camera_duration; can_shake_camera = false; }
	}

#endregion


#region ZOOM +/-

if(can_zoom == true)
{
	//New size
	cam_multiple = clamp(cam_multiple, 0, cam_multiple_max);
	//On ne veut pas que le zoom soit plus large que la taille de la room
	cam_w = min(room_width, cam_w_sizes[cam_multiple]);	
	cam_h = min(room_height, cam_h_sizes[cam_multiple]);
	
	var _new_w = cam_w;
	var _new_h = cam_h;
	
	//Set camera size
		if(zoom_instant == true)
		{	
			//ZOOM immédiat
			camera_set_view_size(cam, _new_w, _new_h);
		}
		else
		{
			//ZOOM progressif
			_new_w = lerp(camera_get_view_width(cam), cam_w, zoom_lerp_speed);
			_new_h = lerp(camera_get_view_height(cam), cam_h, zoom_lerp_speed);
			camera_set_view_size(cam, _new_w, _new_h);
		}
		
				//Il faut aussi adapter view_w et view_h, car la position cx, cy (centrée sur player) en dépent
				view_w = camera_get_view_width(cam);		//view_w = RES.WIDTH;	
				view_h = camera_get_view_height(cam);		//view_h = RES.HEIGHT;

	/////////////////////////////////////
	//Zoomer/dézoomer pendant le jeu
	//if(keyboard_check_pressed(key_zoom) == true)
	if(input_keyboard_or_gamepad_check_pressed(global.key_zoom, global.gp_zoom) == true)
	&& (global.found_tool_loupe == true)
	{
			//vs++;
			//if (vs > array_length(views_scales) - 1) { vs = 0; }	//boucle
			//view_scale = views_scales[vs];
		
		//Taille (zoom) actuelle de la caméra
		//cam_multiple++;	//Zoom grandissant suivant
		cam_multiple--;	//Zoom rétrécissant suivant
		
		if(cam_multiple > cam_multiple_max) { cam_multiple = 0; }	//Boucle
		if(cam_multiple < 0){ cam_multiple = cam_multiple_max; }
		cam_w = cam_w_sizes[cam_multiple];
		cam_h = cam_h_sizes[cam_multiple];
		
			//Condition pour, si un zoom est inaccessible (room trop petite pour dézoomer), passer directement au zoom accessible suivant, sans devoir appuyer 2 fois sur l'input
			if((cam_w > room_width) || (cam_h > room_height))
			{
				//	show_debug_message("ZOOM : zoom inaccessible (cam_w x h = " + string(cam_w) + " x " + string(cam_h) + "), (room_w x h = " + string(room_width)+" x "+string(room_height)+ "), passage au zoom suivant.");
				cam_multiple++;	//Zoom suivant
				
				if(cam_multiple > cam_multiple_max) { cam_multiple = 0; }	//Boucle
				if(cam_multiple < 0){ cam_multiple = cam_multiple_max; }
				cam_w = cam_w_sizes[cam_multiple];
				cam_h = cam_h_sizes[cam_multiple];
			}
		
		//cam	= view_camera[1];
		//cx = camera_get_view_x(cam);
		//cy = camera_get_view_y(cam);							
		//view_camera[1] = camera_create_view(0, 0, 16*20, 16*18);
		
		//	show_message("ZOOM : cam_multiple = " + string(cam_multiple) + ".  (cam_w x cam_h = " + string(cam_w) +" x " + string(cam_h) + ")   camera_get_view_width(cam) = " + string(camera_get_view_width(cam)) +",  camera_get_view_height(cam) = " + string(camera_get_view_height(cam)));
		
		//	show_debug_message("ZOOM : cam_multiple ++ ===> " + string(cam_multiple));
	}

	//	show_debug_message("ZOOM : cam_multiple = " + string(cam_multiple) + "/" + string(cam_multiple_max) + "  (cam_w, h = " + string(cam_w) + " x " + string(cam_h) + ")   (view_w, h = " + string(view_w) + " x " + string(view_h) + ")");
}	
	
#endregion


#region DESACTIVER TOUTES LES INSTANCES EN DEHORS DE LA CAMERA POUR OPTIMISER

	if(desactive_instance_hors_view == true)
	{
		//Désactivation de toutes les instances de la room (et de "Instances" layer, pas "Controllers" !) en dehors de la view
		var _inst_layer_id = layer_get_id("Instances");
		
		//NOTE : pour que les water items soient visibles sur la map réactive, il ne faut pas les désactiver ici.
		//On les met donc sur un autre layer "Items" et on n'y touche pas
	
		instance_deactivate_layer(_inst_layer_id);
	
		var _rleft, _rtop, _rw, _rh, _marge;
		_marge	= 800;	//augmentation du cadre pour ne pas qu'on perçoive la désactivation des grands objets + ombres
		_rleft	= camera_get_view_x(cam) - _marge;
		_rtop	= camera_get_view_y(cam) - _marge;
		_rw		= view_w + _marge;
		_rh		= view_h + _marge;
	
		instance_activate_region(_rleft, _rtop, _rw, _rh, true);
	
		//Dessin de la région d'activation
		draw_set_alpha(0.3); draw_set_color(c_blue);
		draw_rectangle(_rleft, _rtop, _rw, _rh, false);
		draw_set_alpha(1);
	}
	
#endregion



/*
if(mouse_check_button(mb_left))
{
	///// CHANGEMENT DE CAMERA (cf : o_Camera, change_camera_mode)
	//change_camera_mode(CAMMODE.FOLLOW_MOUSE_DRAG, otf.id);
	change_camera_mode(CAMMODE.FOLLOW_MOUSE_DRAG, mouse_x, mouse_y);	//Pratique si on a plus otf
}


