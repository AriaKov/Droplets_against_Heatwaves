///@desc LIGHT, CALENDAR

/*
//AFFICHAGE RECTANGLE COLOR DE BASE SANS TEMPORALITE
var _c = c_white; draw_set_alpha(0);
draw_rectangle_color(0, 0, global.gui_w, global.gui_h, _c, _c, _c, _c, false);
*/

#region AFFICHAGE DU CALQUE ( COLOR, DARKNESS )

	if (draw_daylight == true)
	{
		var _c = light_color;
		draw_set_alpha(darkness);
	
		//Modes de fusion (optionnel)
		//gpu_set_blendmode(bm_add);
		//gpu_set_blendmode(bm_subtract);
		//gpu_set_blendmode(bm_max);
		//gpu_set_blendmode_ext(bm_dest_colour, bm_zero);	//Effet de multiplication cf. Photoshop
	
		draw_rectangle_color(0, 0, global.gui_w, global.gui_h, _c, _c, _c, _c, false);
	
		//gpu_set_blendmode(bm_normal);
		draw_set_alpha(1);
	}

#endregion

#region A F F I C H A G E   D E S   V A L E U R S   P O U R   T E S T

	

	draw_set_align(0, -1);
//	draw_set_font(fnt_body);
	draw_set_color(c_blue);
	draw_set_alpha(1);
	
	var _int = 24;				//Valeur de l'interligne
	var _x = global.gui_w/2;	//Position x du paquet d'infos
	var _y = 16;				//Position y du paquet d'infos
	var _i = 0;					//Ligne actuelle
	var _s = 3;
	
		//HEURE --->>> dans GUI
		//var _minutes = hours mod floor(hours) * 0.3 / 0.5;	//Conversion de % en minutes
	//	var _minutes = frac(hours) * 0.3 / 0.5;	//Conversion de % en minutes
		//draw_text_transformed(_x, _y + (_i * _int), string(floor(hours) + ":" + string(_minutes), _s, _s, 0); _i++;
	//	var _time = string(floor(hours) + _minutes); _time = string_replace(_time, ".", ":");
	//	draw_text_transformed(_x, _y + (_i * _int), string(_time), _s, _s, 0); _i++;

if(global.debug == true)
{	
	if(1 == 2)
	{
	
	draw_set_align(1, -1);
	_int = 24;				//Valeur de l'interligne
	_x = global.gui_w - 10;	//Position x du paquet d'infos
	_y = global.gui_h/2;	//Position y du paquet d'infos
	_i = 0;					//Ligne actuelle
	_s = 2;
	
		draw_text_transformed(_x, _y + (_i * _int), "time_increment = " + string(time_increment), _s, _s, 0); _i++;
		//draw_text_transformed(_x, _y + (_i * _int), "(moment = " + string(moment*100) + " % )", _s, _s, 0); _i++;
	//	draw_text_transformed(_x, _y + (_i * _int), "(darkness = " + string(darkness) + " )", _s, _s, 0); _i++;
	//	draw_text_transformed(_x, _y + (_i * _int), "(light_color = " + string(light_color) + " )", _s, _s, 0); _i++;
		_i++;

		draw_text_transformed(_x, _y + (_i * _int), "T = Temps en pause", _s, _s, 0); _i++;
		draw_text_transformed(_x, _y + (_i * _int), "* = acc. / = ralentir", _s, _s, 0); _i++;
		 _i++;

		draw_text_transformed(_x, _y + (_i * _int), string(phase), _s, _s, 0); _i++;
		 _i++;

		draw_text_transformed(_x, _y + (_i * _int), string(floor(seconds)) + " s", _s, _s, 0); _i++;
		draw_text_transformed(_x, _y + (_i * _int), string(floor(minutes)) + " min", _s, _s, 0); _i++;
		draw_text_transformed(_x, _y + (_i * _int), string(hours) + " h", _s, _s, 0); _i++;
		draw_text_transformed(_x, _y + (_i * _int), "jour : "	+ string(day), _s, _s, 0); _i++;
		draw_text_transformed(_x, _y + (_i * _int), "saison : "	+ string(season), _s, _s, 0); _i++;
		draw_text_transformed(_x, _y + (_i * _int),	"annee : "	+ string(year), _s, _s, 0); _i++;
		if (time_pause == true) { 
		draw_text_transformed(_x, _y + (_i * _int), "~ p a u s e ~", _s, _s, 0); _i++; }

	}

	draw_set_align();
	draw_set_alpha(1);
	
}

#endregion


/*
#region CALENDRIER VISUEL

	var _j = 0;	//jours de la semaine (0 --> 6)
	var _s = 0;	//semaine
	var _m = 0;	//mois (4 semaines)
	var _days = day;	
	//var _days_in_year = _days;	//permet de réinitialiser les jours à chaque année
	
	var _int = cell/2;
	var _calx = global.gui_w / 4;					_calx = cell;
	var _caly = global.gui_h - (_int * 7) - cell;	_caly = cell;
	var _calsize = 6;
	var _calx2 = _calx + _calsize;
	var _caly2 = _caly + _calsize;
	
	var _nb_jours_dans_semaines = 7;
	var _nb_jours_dans_mois = 4 * _nb_jours_dans_semaines;
	
	//COLOR
	var _calcolor = calendar_colors[c];
	
	//TIME & DATE
	var _i = 0;
	var _scale = 1;
	draw_set_color(blue);
	draw_set_font(fnt_body);
	draw_set_halign(fa_left);

	//draw_text_transformed(_calx, _caly - cell * 5 + (_i * _int), string(floor(hours)) + " h "+ string(floor(minutes)) +" m "+ string(floor(seconds)) + " s", _scale, _scale, 0); _i++;
	draw_text_transformed(_calx, _caly - cell + (_i * _int*2), string(floor(hours)) + " : "+ string(floor( (minutes mod 60) /10) * 10), _scale, _scale, 0);
	draw_text_transformed(_calx + cell*3, _caly - cell + (_i * _int*2), string(day) +" / "+ string(season)+ " / "+ string(year), _scale, _scale, 0);
	
if global.pause
{
	//AFFICHAGE DES PETITS CARRES POUR CHAQUE JOUR
	for(_days = 0; _days < days_total; _days++)
	{	
		//Colors
		//if _s < 4 || _s > 7 { draw_set_color(c_blue); }
		//else //Changement de mois (1 mois = 4 semaines = 28 jours)
		{
		//	draw_set_color(c_grey);
		}
		
		//JOURS
		draw_set_color(_calcolor);
		draw_set_alpha(0.3);
		var _inter_mois = (_int * _m);	//Pour espacer le calendrier entre chaque mois (toutes les 4 semaines)
		//draw_rectangle(_calx + (_s * _int) + _inter_mois, _caly + (_j * _int), _calx2 + (_s * _int) + _inter_mois, _caly2 + (_j * _int), false); _j++;
		draw_roundrect(_calx + (_s * _int) + _inter_mois, _caly + (_j * _int), _calx2 + (_s * _int) + _inter_mois, _caly2 + (_j * _int), false); _j++;
		draw_set_alpha(1);
		
		//CHANGEMENT DE SEMAINE
		if _j == _nb_jours_dans_semaines 
		{
			_s++;		//Semaine suivante
			_j = 0;		//Premier jour de la semaine
		}
		
		//CHANGEMENT DE MOIS
		//if _s == 3 || _s == 7 || _s == 11
		//if _days == _nb_jours_dans_mois - 1 || _days ==  _nb_jours_dans_mois*2 - 1  || _days == _nb_jours_dans_mois*3 - 1
		if ((_days+1) mod (_nb_jours_dans_mois)) == 0
		{
			_m++;
			//Changement de couleur
			//c++;
		}
		if (c > array_length(calendar_colors)-1) { c = 0; }
		
		//CHANGEMENT D'ANNEE (reset le calendrier)	NE MARCHE PAS (FAIT BUGGUER)
		//if _days_in_year >= (_nb_jours_dans_mois * 4)
		{
		//	_days_in_year = 0;	
		}
	}
}

#endregion


