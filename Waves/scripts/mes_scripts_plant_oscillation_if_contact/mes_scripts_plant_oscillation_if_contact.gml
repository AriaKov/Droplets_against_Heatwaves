//OSCILLATION DE IMAGE_ANGLE SI CONTACT

#region EXPLICATIONS DE L'OSCILLATION
	//Seule l'image bouge, pas l'objet en soi (cf. draw).
	//Pour optimiser, on mettra ça dans l'objet mouse, player, ou dans un autre contrôleur unique.
	
	//Attention : l'oscillation doit continuer même si le trigger est déjà partit hors de la zone d'influence.
	//Donc IDLE n'arrive qu'à la fin de l'oscillation (ou d'un temps impartit)
	
	//						|(= périmètre)
	//1)	plant 			|	trigger			(can_shake)					
	//2)	plant		trigger					(if can_shake --> is shaking)		
	//3)	<<plant<<	trigger					(can_shake = false)	(is shaking)					
	//4)	>>plant>>	trigger								
	//5)	<plant<		trigger								
	//6)	plant		trigger					(can_shake = false)													
	//7)	plant		trigger					(can_shake = false) toujours tant que trigger présent
	//8)	plant			|	trigger			(can_shake)
	//9)	plant		trigger					etc...

	//A l'étape 4) ou 5) si le trigger sort de la zone, l'oscillation continue normalement.
	//can shake : si animation finie et que plus de trigger dans la zone.
	
	////////
	//Triggered par obj_c_shake_plants, un contrôleur qui suit le x,y des objets comme player, enemy...
	////////
	
#endregion
#region EXPLICATION DES SCRIPTS

//Ces scripts sont à placer dans les différents events correspondants de obj_flore_parent

//Remarque : ces scripts utilisent des variables "en bleu classique sans _",
//et le premier script placé dans CREATE les déclare grâce à ses arguments. 
//Donc tous les paramètres sont déclarés dans le script du create et sont ensuite repris automatiquement dans les suivants.

//Dans DRAW on doit mettre : 
//draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, 1);

#endregion

//J'ai l'impression que ça ne marche pas, de déclarer des variables bleues dans un script...
//Maybe je fait des scripts que pour STEP et ALARM.
//-------------------------------------------------------------------------------------------

///@desc obj_decor_shaking_parent : CREATE EVENT. Initialise les variables qui permetteront de faire osciller la plante au passage d'un/plusieurs triggers définits.
///@arg	_triggers	Trigger(s) qui déclenche(nt) l'oscillation. (obj_mouse, obj_player, obj_pnj...)
///@arg {real} _alarm_name Numéro de l'alarme à déclencher pour mettre fin à l'oscillation. (Défaut : 1)
///@arg	{real} _ray	Rayon de "contact" autour de la plante. (Défaut : 8)
///@arg	{real} _angle_max	Angle max de part et d'autre de l'angle initial. (Défaut : irandom_range(5, 35))
///@arg	{real} _per_init	Sinusoïde : Période initiale. (Défaut : 0.01)
///@arg {real} _amp_init	Sinusoïde : Amplitude initiale. (Défaut : 0.5)
///@arg	{real} _duration	Sinusoïde : Durée de l'oscillation (enclenche l'alarme de fin). (Défaut : 60)
function plant_oscillation_if_contact_create(_triggers = global.player, _alarm_name = 1, _ray = 8, _angle_max = irandom_range(5, 35), _per_init = 0.01, _amp_init = 0.5, _duration = 60)
{
	#region OSCILLATION

		is_shaking			= false;
		can_start_shaking	= true;		//La proximité doit trigger 1 seule fois la plante.
										//Pour être re-trigger, le trigger doit partir puis revenir.
		
		trigger_autonome	= true;		//True : l'objet vérifie lui-même la collision (- optimisé)
										//False : la collision est commandée par obj_c_shake_plants (+ optimisé, mais pas encore focntionnel)
		
		ray			= _ray;			//Rayon d'influence du trigger
		angle_init	= 0;			//Angle de base
		angle		= angle_init;	//Angle actuel (fluctue)
		angle_max	= _angle_max;	//Angle max d'oscillation
	
	duration		= random_range(1,3) * game_get_speed(gamespeed_fps);	//Durée (Temps d'amortissement) de l'oscillation
			
		periode_init	= _per_init;				//Longueur d'onde (diminue)
		periode			= periode_init;		
		amplitude_init	= _amp_init;				//Hauteur d'onde (diminue)
		amplitude		= amplitude_init;	
							
		oscillation_speed = 0;

	#endregion

	#region TRIGGER
	
		trigger	= _triggers;
		dist	= distance_to_object(trigger);	//Distance au trigger
		dir_x	= sign(trigger.x - x);	//Direction sur x de l'oscillation, en fonction de la position du trigger. (-1 ou 1)
	
	#endregion
	
	//Alarm
	alarm_end_oscillation = _alarm_name;
	
	image_angle = angle;
}
//-------------------------------------------------------------------------------------------


///@desc obj_decor_shaking_parent : STEP EVENT. Fait osciller la plante au passage d'un/plusieurs triggers définis dans : plant_oscillation_contact_create
///@desc (OU PLUTOT DANS CREATE, tout simplement, car ça ne marche pas de déclarer des variables bleues dans un script).
///@arg {real} _alarm_name Numéro de l'alarme à déclencher pour mettre fin à l'oscillation. (Défaut : 1)
function plant_oscillation_if_contact_step(_alarm_name = 1)
{
	
	
			if(is_array(trigger) == false){	dist	= distance_to_object(trigger); }	//Distance au trigger (cas normal où trigger == player seulement)
			
			//Tentative d'avoir aussi des triggers faune et pnj
			if(is_array(trigger) == true)
			{
				show_message("FLORE > STEP : trigger IS an array (" + string(trigger));
				//var _inst = instance_place(x, y, trigger); //instance_place permet de récolter la valeur de  l'instance pour l'utiliser
				var _inst = instance_nearest(x, y, trigger);
				show_message("FLORE > STEP : instance_nearest = " + string(_inst));
				if (_inst != noone) //s'il y a collision...
				{ 
					trigger = _inst;	//Save the id of that trigger
				}
			}

	
	#region TRIGGER(S)
	
		//Entrée du trigger dans le rayon de contact.
		//var _collision = collision_circle(x, y, trigger.ray, trigger, false, false);
	//	var _collision = collision_circle(x, y, ray, trigger, false, false);
		collision		= collision_circle(x, y, ray, trigger, false, false);
		var _collision	= collision;
		
		//show_message("_collision == true");
		
			//Idée : dans Stardew Valley, même si on a pas quitté le rayon de la plante après l'avoir fait osciller
			//MAIS qu'on rebouge, la plante re-oscille. can_start_shaking = true si player is moving.
			//	with(trigger) { var _is_moving = (xprevious != x) || (yprevious != y); }	//Remplacer avec le STATE.MOVE
			//	_collision = _collision && _is_moving;
		
		
		if(trigger_autonome == true)	//true = l'objet vérifie lui-même la collision (- optimisé)
		{
			if((_collision != noone) && (can_start_shaking == true))	{	is_shaking	= true;	}
		}
		
	#endregion

	#region OSCILLATION
	
	//floatting_sinusoidal_x(self, self, 2, 2);	//Test. wooow c'est psychédélique... mais pk???

		if(is_shaking == false)
		{
			//Tout le temps dans ce state, sauf quand le trigger ARRIVE dans la zone de contact (de rayon ray)
			//Tant que le trigger RESTE, la plante ne peut repasser au state SHAKE. (car can_start_shaking est faux)
			//can_startshaking repasse à true que lorsque le trigger est absent ET que la plante n'est pas déjà en train de shaker.
			osc_state_str	= ".";
			//image_blend	= c_white;
			angle			= angle_init;
	
			//Remise à la normale
			periode			= periode_init;
			amplitude		= amplitude_init;
	
			//Pour pouvoir start_shake again, le trigger doit partir puis revenir dans la zone de contact (ray)
			//Pas d'oscillation ET absence du trigger.
			if(_collision == noone)
			{
				can_start_shaking = true;	//Dans l'objet trigger ! .... heu non ?
			}			
		}
	
		if(is_shaking == true)
		{
			if(can_start_shaking == true)	//Pour initialiser une seule fois
			{
				//Shake jusqu'à la fin de la durée (alarm).
				//Oscillation sinuzoïdale de l'angle en fonction de la position droite/gauche p/r au trigger
				//Dans ce state uniquement pendant la durée de l'oscillation, lorsque le trigger ARRIVE en contact.
				//A la fin de l'oscillation, state => IDLE, que le trigger soit encore là ou pas.
				osc_state_str	= "S";
		
				//INITIALISATION DE L'OSCILLATION (Direction du début de la sinuzoïde)

				//Ceci doit être calculé 1 seule fois au début de l'oscillation, et ne doit pas changer en cours de route.
				//	dist	= distance_to_object(trigger);	//Actualisation trigger
					dir_x	= sign(trigger.x - x);
			
					if global.debug
					{
					//	if dir_x == 1	{	image_blend = c_red;	}	//FROM RIGHT ( <<<plant   trigger )
					//	if dir_x == 0	{	image_blend = c_yellow; }
					//	if dir_x == -1	{	image_blend = c_green;	}	//FROM LEFT ( trigger	  plant>>> )
					}
					else image_blend = color;
				
				
				#region SOUNDS
					
					//sound_active & sound_gain sont définis dans CREATE
					if(sound_active_when_oscillation == true)
					{
						//Random sound
							var _sh		= irandom(array_length(sounds) - 1);
							var _sound	= sounds[_sh];
						//Random pitch and gain
							//sound_gain		= random_range(0.1, 0.2) * global.sound_volume;
							var _sound_gain		= (sound_gain + random_range(-0.05, 0.05)) * global.sound_volume;
							sound_pitch			= random_range(0.8, 1.2);
						//Play sound
						//	if(audio_is_playing(_sound) == false)
							{ 
								audio_play_sound(_sound, 1, false, _sound_gain, 0, sound_pitch);
							}
					}	
					
				#endregion
	
	
				//Arrêt de l'oscillation après x secondes
				if((can_start_shaking == true) && (oscillation_type != "angle_lerp")){ alarm[_alarm_name] = duration; }
				can_start_shaking = false;	//Ne peut pas REcommencer avant d'avoir fini. Empêcher infinite loop.
			}
			
			if(oscillation_type == "false")
			{
				//Ne rien faire
			}
			if(oscillation_type == "angle")			//HERBES
			{
				//	angle += sin(current_time * periode) * amplitude;
				//floatting_sinusoidal_x(self, self, 2, 2);	//Inutile mais ça marche.
				//	angle = 45 * dir_x;
		
				//	angle = angle_init + ( sin(current_time * 20) * 20 );	//marche aussi mais cheloument...
	
				// Définir la vitesse d'oscillation en fonction du temps
				//oscillation_speed = angle_max * sin(current_time / duration * 2) * amplitude;
				oscillation_speed	= angle_max * sin(current_time * periode ) * amplitude;
				angle				= angle_init + (oscillation_speed * dir_x);	//Ajustement de l'angle
			}
			if(oscillation_type == "x")				//ROCHES
			{
				//oscillation_speed = angle_max * sin(current_time * 0.015 ) * 0.06;
				oscillation_speed	= sin(current_time * 0.015 ) * 0.7;
				posx				= x + (oscillation_speed * dir_x);
			}
			if(oscillation_type == "angle_lerp")	//test
			{
				dist		= distance_to_object(trigger);	//Actualisation trigger
				var _angle	= lerp(angle_max * dir_x, angle_init, (ray * dist)/1000 );
				//angle		+= _angle + (0.1 * dir_x);
				angle		+= _angle;
			}
			if(oscillation_type == "unique")		//SQUELETTES
			{
				//var _angle	= random(5);
				//angle			= choose(angle_init-_angle, angle_init, angle_init, angle_init, angle_init + _angle);
				//angle			+= choose(angle_init-_angle, angle_init + _angle);
				angle			= (angle_init + 10) * sign(dir_x);
			}
			
			//Amortissement
			periode += 0.0001;
			periode = clamp(periode, 0, periode_init);
	
			amplitude -= 0.01;
			amplitude = clamp(amplitude, 0, amplitude_init);
		}

	#endregion

	angle = clamp(angle, angle_init - angle_max, angle_init + angle_max);
	image_angle = angle;
	image_blend = color;
}


///@desc obj_decor_shaking_parent : ALARM (définie dans le script STEP). Stoppe l'oscillation.
function plant_oscillation_if_contact_alarm()
{
	// Arrêter l'oscillation
	is_shaking	= false;
}


///@desc obj_decor_shaking_parent : DRAW. Pas très utile, mais au cas où.
///@desc draw_sprite_ext(sprite_index, image_index, posx, posy, image_xscale, image_yscale, image_angle, image_blend, 1);
function plant_oscillation_if_contact_draw()
{
	///@desc DRAW
	//draw_sprite_ext(sprite_index, image_index, posx, posy, xscale, image_yscale, image_angle, image_blend, 1);
	draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, 1);
	
	if(global.debug == true) && (1 == 2)
	{
		var _sep	= 8;
		var _i		= 0;
		var _xx		= x;
		var _yy		= y + 8;
	
		draw_set_font(fnt_pixelbasic);
		draw_set_color(image_blend);
		draw_set_alpha(0.7);
		
		draw_text(_xx, _yy + (_sep * _i), "type : " + string(oscillation_type)); _i++;
	//	draw_text(_xx, _yy + (_sep * _i), "autonome : " + string(trigger_autonome)); _i++;
	//	draw_text(_xx, _yy + (_sep * _i), "state : " + string(osc_state_str)); _i++;
		draw_text(_xx, _yy + (_sep * _i), "is_shaking : " + string(is_shaking)); _i++;
	//	draw_text(_xx, _yy + (_sep * _i), "can_start : " + string(can_start_shaking)); _i++;
		if(collision){ draw_text(_xx, _yy + (_sep * _i), "collision !"); _i++; }
		
	//	draw_text(x, y - 6, string(osc_state_str));
		//draw_text(mouse_x, mouse_y - 6, string(periode));
		//draw_text(x, y, string(can_be_triggered));

		if(can_start_shaking == true) { draw_set_color(c_blue);	draw_circle(x, y, 1, true); }
		draw_set_color(c_white);
	}
}



