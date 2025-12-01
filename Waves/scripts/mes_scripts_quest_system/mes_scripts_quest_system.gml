
///@desc OBJ_QUEST_SYSTEM > CREATE. Crée une grille avec l'array des descriptions de quête écrit à la main.
///@arg _array
function create_ds_grid_from_array(_array)
{
	var _ds_grid;
	
	//On veut créer une ds grid qui contiendrait toutes les quêtes.
	//w = nb of elements in each quest
	//h = nb of quests
	var _array_num_quests	= array_length(_array);
	var _array_w			= array_length(_array[0]);	//On prends la 1ère quête comme modèle,
														//Ca marche si elles ont toutes le même nombre de
	//...perso j'aurai inversé h et w ici !!
	
	//Création de la structure
	_ds_grid = ds_grid_create(_array_w, _array_num_quests);

	//Remplissage de la grille
	var _yy = 0;	//numéro de la quête
	repeat(_array_num_quests)
	{
		//Accéder à la quête en question
		var _quest_array = _array[_yy];
		
		var _xx = 0; 
		repeat(_array_w)
		{
			//Accéder à la caractéristique de la quête en question
			_ds_grid[# _xx, _yy] = _quest_array[_xx];
			
			_xx++;
		}
		
		
		_yy++;
	}

	return _ds_grid;	
}



///@desc OBJ_QUEST_SYSTEM > STEP. A placer à la fin de chaque description de subquest.
///@desc Fait passer à la sous-quête suivante au sein de la même quête.
///@arg _grid Grille des quêtes
///@arg _i Indice de la Quête dans laquelle on est
function next_subquest(_grid, _i)
{
		//VERIF
		show_debug_message("QUEST " + string(_i) + ") SUBQUEST ACHIEVED : " + string(_grid[# 1, _i]));
	
	//Fin de la sub-quête et passage à la suivante
	_grid[# 1, _i] += 1;
}

///@desc OBJ_QUEST_SYSTEM. Permet d'activer une nouvelle quête. Peut être appelé - directement ou via with(...) - par le controlleur de quêtes.
///@arg _grid Grille des quêtes
///@arg _quest_to_activate Indice de la Quête à activer
function activate_new_quest(_grid, _quest_to_activate)
{
	//Active la quête (0) si elle est désactivée (-1)
	if(_grid[# 1, _quest_to_activate] == -1) { _grid[# 1, _quest_to_activate] = 0; }
	else { show_debug_message("Quest " + string(_quest_to_activate) + " is already activated."); exit; }
	
		//VERIF
		var _desc = _grid[# 0, _quest_to_activate];	//Description de la quête			
		show_debug_message("NEW QUEST >>> [" + string(_quest_to_activate) + "] " + string(_desc));
		
		
		//SOUND
		if(_quest_to_activate != QUEST.MENU)
		{
			with(obj_c_music)
			{
				audio_play_sound(sound_quest_new, 1, false, sound_quest_gain, 0, sound_quest_pitch);
			}
		}
}


///@desc OBJ_QUEST_SYSTEM > STEP. Affiche le message correspondant dans l'encadré du GUI, en se basant sur la grille décrite dans obj_quest_system.
///@desc Fonctionne avec obj_c_gui (cf. projet Waves)
///@arg _grid Grille des quêtes
///@arg _i Indice de la Quête dans laquelle on est
///@arg _stage Indice de la subquest dans laquelle on est
function set_appropriate_text_in_gui(_grid, _i, _stage)
{
	//Affiche le message correspondant dans l'encadré du GUI.
	var _stage_desc	= _grid[# 2, _i][_stage +1];	//Description de la sous-quête d'après (stage + 1)
		if(_stage_desc == noone){ _stage_desc = ""; }
	with(obj_c_gui){ text = string(_stage_desc); event_perform(ev_alarm, 4); }
}

///@desc OBJ_QUEST_SYSTEM > STEP. Déclenche une alarme de fin d'affichage du texte dans l'encadré du GUI (le texte devient "")
///@desc Fonctionne avec obj_c_gui (cf. projet Waves).
///@desc Utilise la var alarm_end_text_can_be_set pour n'enclencher qu'une seule fois.
///@arg {real} _time Time, in seconds (Défaut : 5)
///@arg {real} _alarm	Alarm index (Défaut : 0)
function hide_textbar_after_a_moment(_time = 5, _alarm = 0)
{
	with(obj_c_quest_system)
	{
		if(alarm_end_text_can_be_set == true)
		{
			alarm[_alarm]				= _time * global.game_speed;
			alarm_end_text_can_be_set	= false;
		}
	}
}

