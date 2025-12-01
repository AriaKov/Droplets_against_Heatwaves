///@desc DEBUG

#region CSV <3

	//Alt + I pour géréer les .csv en fichiers liés

	if(1 == 2)
{
	var _grid_csv = grid_csv;

	var _cell = 48;
	var _posx = 16;
	var _posy = 300;
	//draw_set_align();

	for(var _xx = 0; _xx < ds_grid_width(_grid_csv); _xx++)
	{
		for(var _yy = 0; _yy < ds_grid_height(_grid_csv); _yy++)
		{
			//if (_yy > E_MONSTER_STATS.NAME) { global.monster_stats[_xx, _yy] = real(ds_stats_csv[ _xx, _yy]); 
			//Convertir les string en real dès que c'est sensé être des chiffres, car le csv considère tout comme des strings
			
			var _text = _grid_csv[# _xx, _yy];		//Texte à afficher (dans la case xx, yy)
			if (_yy > 0) { _text = real(_grid_csv[# _xx, _yy]); }		//Convertion en réel
				
			var _drawx = _posx + (_xx * _cell * 2);	//x
			var _drawy = _posy + (_yy * _cell);		//y
		
			draw_text(_drawx, _drawy, _text);		//Draw
		}
	}
}
	
#endregion

var _grid = ds_quests;

if(global.debug == false) exit;

	draw_set_align();
	draw_set_color(c_ltgray);
	draw_set_font(fnt_body);
	var _int	= 32;
	var _j		= 0;
	var _s		= 2;
	var _str	= "";

	var _x = display_mouse_get_x() + 256;	//_x = 16;
	var _y = display_mouse_get_y() + 16;	//_y = 16;

//draw_text_transformed(_x, _y + (_int * _j), "array_quests_number = " + string(array_quests_number), _s, _s, 0); _j++;
draw_text_transformed(_x, _y + (_int * _j), "Number of quests : " + string(ds_quests_number), _s, _s, 0); _j++;
//draw_text_transformed(_x, _y + (_int * _j), "ITEMS : " + string(global.items), _s, _s, 0); _j++;

var _i = 0; repeat(ds_quests_number)	// Pour toutes les quêtes...
{
	var _name		= _grid[# 0, _i];				//Nom de la quête
	var _stage		= _grid[# 1, _i];				//Etat de la quête
	var _stage_nb	= array_length(_grid[# 2, _i]);	//Nombre de sous-quêtes

	if(_stage != -1)					//Si la quête est active...
	{
		var _stage_desc	= _grid[# 2, _i][_stage];	//Description de la sous-quête
		//Sachant que la colonne 2 de l'array est elle-même un array...
	
		//var _array = ds_quests[# 2, _i];	//Etat d'avancement & sous-quête associée
		//DRAW : le titre : la description de la sous-quête en fonction de l'état (0,1,2...)
		//_str = "\n" + string_upper(ds_quests[# 0, _i]) + " : " + _array[_stage];
		//Normalement ça envoie un retour à la ligne, mais ça bug. Ma méthode :
		var _texte = string(_i) +") " + string_upper(_name) + " : (" + string(_stage + 1) +"/"+ string(_stage_nb) + ") " + string(_stage_desc);
		draw_text_transformed(_x, _y + (_int * _j), _texte, _s, _s, 0);
		_j++;
		//_stage + 1 car le véritable numéro de la sub-quête commence à 0
	}
	_i++;	
}

//draw_text_transformed(_xx, _yy, _str, _s, _s, 0);



