///@desc TIME

if(global.pause == true) exit;

if(time_pause == true) exit;

mx = display_mouse_get_x();
my = display_mouse_get_y();

	if(global.debug == true)
	{
		if(keyboard_check_pressed(vk_multiply)){
			if(time_increment >= 1) { time_increment++; }
			if(time_increment < 1)	{ time_increment += 0.1; }
			}	
		if(keyboard_check_pressed(vk_divide)){ 
			if(time_increment >= 2)	{ time_increment--; }
			if(time_increment <= 1) { time_increment -= 0.1; }
			}	
		//Mise à jour de la durée réelle d'une journée dans le jeu
		duration_of_a_day_in_sec	= (60 * 60 * 24) / time_increment / global.game_speed ;
		duration_of_a_day_in_min	= duration_of_a_day_in_sec / 60;
		duration_of_a_day_in_h		= duration_of_a_day_in_min / 60;
	}


//Incrément time
seconds		+= time_increment;	//dans les variables
minutes		= seconds/60;
hours		= minutes/60;
global.hours = hours;

time_increment = clamp(time_increment, 0.1, 960);

//TENTATIVE VARIATION EN FONCTION DE LA SOURIS
var _mouse_x = display_mouse_get_x();
var _mouse_y = display_mouse_get_y();
//_mouse_x = window_view_mouse_get_x(0);
//_mouse_y = window_view_mouse_get_y(0);
//_mouse_x = 
//hours += display_mouse_get_x();

if(state == TIME.NORMAL)		{ state_str = "NORMAL";			time_increment = time_increment_init; }
if(state == TIME.ACCELERATED)	{ state_str = "ACCELERATED";	time_increment = time_increment_max; }

/*
0(%)			= 0					= 00 hours
100(%)			= global.gui_w	(pixel)		= 24 hours (h)
? avancement(%)	= _mouse_x (pixel)	= ? hours (h)
*/

//avancement = (_mouse_x * 100) / global.gui_w;	//% de la journée (INUTILE)
//hours =	(_mouse_x * 24) / global.gui_w;		//Heure de la journée


if(draw_daylight == true)
{

	#region DEFINITION DES PHASES ET VARIABLES DE COULEURS
	
	/*
	var _darks  = [darkness_max, 0.2] ;
	var _colors = [c_orange] ;
	var _pstart = PHASE.SUNRISE;	//Phase start (début de la phase)
	var _pend = PHASE.DAYTIME;		//Phase end (fin de la phase)
	
	var _pmiddle = _pstart + ( (_pend - _pstart) /2 );		//Heure de milieu de cycle
	*/
	
	//var _darks, _colors, _pstart, _pend;
	
	//Couleurs
	var _couleursombre = merge_color(c_black, c_navy, 0.3);
	_couleursombre = merge_color(c_navy, c_aqua, 0.3);
	
	var _coul_1;
	
	if (hours > PHASE.SUNRISE and hours <= PHASE.DAYTIME) {			//Sunrise
		_darks  = [darkness_max, 0.2];
		//_colors = [_couleursombre, c_orange];
		_colors = colors_sunrise;
		_pstart = PHASE.SUNRISE;
		_pend	= PHASE.DAYTIME;
		phase	= "Sunrise";
	}
	else if (hours > PHASE.DAYTIME and hours <= PHASE.SUNSET) {		//Daytime
		_darks  = [0.2, 0, 0, 0, 0.2];
		//_colors = [c_orange, #05fb79, c_white, #05fb79, #b4fb05];
		_colors = colors_day;
		_pstart = PHASE.DAYTIME;
		_pend	= PHASE.SUNSET;
		phase	= "Day";
	}
	else if (hours > PHASE.SUNSET and hours <= PHASE.NIGHTTIME) {	//Sunset
		_darks  = [0.2, darkness_max];	
		//_colors = [c_orange, c_navy, _couleursombre];
		_colors = colors_sunset;
		_pstart = PHASE.SUNSET;
		_pend	= PHASE.NIGHTTIME;
		phase	= "Sunset";
	}
	else {															//Night
		_darks  = [darkness_max];
		//_colors = [_couleursombre];
		_colors = color_night;
		_pstart = PHASE.NIGHTTIME;
		_pend	= PHASE.SUNRISE;
		phase	= "Night";
	}

	#endregion
	
	
	#region ////ARRET DU TEMPS ENTRE CHAQUE PHASE (réactiver avec T) tentative
	//if (moment < 0.05 and moment > -0.05) { time_pause = !time_pause; }
	//	draw_text(global.gui_w/2, global.gui_h/2, "Entre chien et loup : réactiver le temps avec T"); }
	//if (moment <= 0.01 and moment >= -0.01) { time_pause = !time_pause; 
	//if (hours >= _pstart + 0.1) {
	/*if (hours == _pmiddle) {	//Mais hours n'est jamais exacte
		time_pause = !time_pause;
		draw_text(global.gui_w/2, global.gui_h/2, "Milieu de phase : réactiver le temps avec T");
	}
	
	if (seconds == _pmiddle * (60 * 60)) {
		time_pause = !time_pause;
		draw_text(global.gui_w/2, global.global.gui_h/2, "Milieu de phase : réactiver le temps avec T");
	}*/
	/*
	if (hours == PHASEMIDDLE.MI_SUNRISE or hours == PHASEMIDDLE.MI_DAY or hours == PHASEMIDDLE.MI_SUNSET or hours == PHASEMIDDLE.MI_NIGHT) {
		time_pause = !time_pause;
		draw_text(global.gui_w/2, global.global.gui_h/2, "Milieu de phase : réactiver le temps avec T");
	}*/
	#endregion


	#region	MODIFICATIONS DARKNESS ET COULEUR EN FONCTION DE L'HEURE
		
		#region // C O U L E U R S
		
		//Cas particulier du moment entre 22h et 6h du mat, car la soustraction donne un chiffre négatif...
		if (_pstart == PHASE.NIGHTTIME)
		{
			light_color = _colors[0];	//color = la première (et seule) entrée dans l'array
			
			moment = ( (hours - _pstart) / (_pend - _pstart) ); //Position précise (en % décimal) dans la phase donnée
		}
			
		else 
		{
			moment = ( (hours - _pstart) / (_pend - _pstart) ); //Position précise (en % décimal) dans la phase donnée
			
			//var _cc = 0;	//REINITIALISATION A 0 DE _cc POUR EVITER LES "VAR INDEX [x] OUT OF RANGE [y]" LORS DU CHGMT DE PHASE
			
			//Moment * ( position dans l'array (-1 car array commence à 0) )
			var _cc = ( (hours - _pstart) / (_pend - _pstart) ) * (array_length(_colors) - 1);
			
			//C'est cool mais dans un array on a que des entiers, donc :
			//Position dans l'array est comprise entre ces deux valeurs (arrondies à l'unité sup (ceil) et inf (floor)) :
			var _c1 = _colors[floor(_cc)];	//floor = Arrondi à l'unité inférieure
			var _c2 = _colors[ceil(_cc)];	//ceil = Arrondi à l'unité supérieure
			
			
			//Tentative de debugage pour éviter la panique (out of rangeeee!) en changement de phase
			//if ((array_length(_colors)-1 ) < ceil(_cc)) { light_color = _colors[0]; }
			//else {
			
			//Dégradé de c1 à c2, entre chaque valeur entière de l'array (_cc - son floor retourne les décimales)
			light_color = merge_colour(_c1, _c2, (_cc - floor(_cc)) );
			
			
			//show_debug_message(string(hours) + " h " + " moment = " + string(moment) + " %  " + string(phase) + "	cc = " + string(_cc) + "  [ " + string(floor(_cc)) + " ; " + string(ceil(_cc)) + " ]");
		}
		#endregion

		#region // D A R K N E S S
		
		//Cas particulier du moment entre 22h et 6h du mat
		if (_pstart == PHASE.NIGHTTIME) { darkness = _darks[0]; }
		
		else {
		
			//var _dd = 0;	//REINITIALISATION A 0 DE _dd POUR EVITER LES "VAR INDEX [x] OUT OF RANGE [y]"  LORS DU CHGMT DE PHASE
			
			var _dd = ( (hours - _pstart) / (_pend - _pstart) ) * (array_length(_darks) - 1);
			
			var _d1 = _darks[floor(_dd)];	//floor = Arrondi à l'unité inférieure
			var _d2 = _darks[ceil(_dd)];	//ceil = Arrondi à l'unité supérieure
			
			//Cette fois, il existe une fonction qui fait la liaison entre 2 chiffres :
			darkness = lerp(_d1, _d2, (_dd - floor(_dd)));
			
			//show_debug_message("								  dd = " + string(_dd) + "  [ " + string(floor(_dd)) + " ; " + string(ceil(_dd)) + " ]");
		}
		#endregion
	
	#endregion

}


#region SYMBOLE QUI TOURNE
/*
//with(obj_cycle_indication) {
	//draw_self();
	draw_sprite(spr_cycle_indication, 0, global.gui_w - 100, global.gui_h - 100);
	//instance_create_layer(global.gui_w - 100, 100, "INSTANCES_GAME", obj_cycle_indication);
	with(spr_cycle_indication) {
		image_angle = 0;
		image_angle += (- (o_CycleDayNight.hours * 360) /24); }
//draw_sprite(_pendule, 0, global.gui_w - 20, 20);
*/
#endregion


#region CYCLE CHECK
	/*
	if (seconds > 60)
	{
		minutes++;
		seconds = 0;
	}
	if (minutes > 60)
	{
		hours++;
		minutes = 0;
	}*/
	

		//HEATWAVES : Evenement particulier tous les midis
		//if(hours >= 12)	// MIDI
		if(minutes >= 60)
		{
			if(can_set_event_midday == true)	//Qu'une seule fois par jour (can_set... est réinit dans event_user(1))
			{
				event_perform(ev_alarm, 2);
			}
		}
	
	if(hours >= 24) //24 heures par jour
	{
		seconds = 0;
		event_perform(ev_alarm, 1);
		//day++;
		//with(crops) { event_perform(ev_other, ev_user1); } //Pour associer des évents au cycle
		//with(obj_flore_growing_tree) event_perform(ev_alarm, 0); //AGE++.
	}
	if(day > 28)	//30 jours par saison
	{
		day = 1;
		season++;		
	}
	if(season > 4)	//4 saisons par année
	{
		season = 1; 
		year++;
	}
	
	
	/*//ORIGINAL CYCLE CHECK
	if (hours >= 24) 			//24 heures par jour
	{
		seconds = 0;
	
		event_perform(ev_alarm, 1);
		//day++;
		//with(crops) { event_perform(ev_other, ev_user1); } //Pour associer des évents au cycle
		//with(obj_flore_growing_tree) event_perform(ev_alarm, 0); //AGE++.
	
		if (day > 28)		//30 jours par saison
		{
			day = 1;
			season++;
		
			if (season > 4 )	//4 saisons par année
			{
				season = 1; 
				year++;
			}
		}
	}*/
	
	
#endregion


#region VARIATION TAILLE ET ORIENTATION DES OMBRES (width et height) (cf. obj_shadows)

	//var sec_par_jour = 86400;
	//var secondes_a_midi = sec_par_jour/2; //Secondes par jours = 86400
	var _percentday = (seconds * 1) / 86400; //Pourcentage de la journée
	
	if(draw_daylight == true) && (1 == 2)
	{
		with(obj_c_shadows) 
		{
			var _CYCLE = obj_c_cycle_day_night;
		//	var _pourcent = ((obj_c_cycle_day_night.seconds * 1) / 86400); //Pourcentage de la journée
		
			//TEST
			var _pourcent = obj_c_cycle_day_night.avancement; //Pourcentage de la journée
		
			
			//POSITION A 0H ou MINUIT
			//	shadow_w = w_max	- _CYCLE.hours;
			//	shadow_h = 0		+ _CYCLE.hours;
			
		
			w_max = 60;
			h_max = 40;
		
			//while(shadow_w <= w_max){
		
			//for (i = w_max*60; i >= 0; i--)
			//{
		
			shadow_w = lerp(w_max, 0, _pourcent*2); //*2 car on veut arriver à 12h au lieu de 24h
			shadow_h = lerp(0, h_max, -_pourcent*2);
		
			//GESTION ALPHA DE L'OMBRE QUI DISPARAIT A MINUIT
			if(_CYCLE._pstart == PHASE.SUNSET) //Si quasi nuit, on met alpha à 0.
			{
				shadow_alpha = 0.1;
			}
			if(_CYCLE._pstart == PHASE.NIGHTTIME){	shadow_alpha = 0.05; }
			if(_CYCLE._pstart == PHASE.SUNRISE){	shadow_alpha = 0.1;	}	//Si matin, on monte alpha à shadow_alpha (0.2)
			
		
		
			/*
			if(_pourcent <= 0.5){	
			
			}
			else if(_pourcent > 0.5){
				shadow_w = lerp(0, w_max, _pourcent*2); //*2 car on veut arriver à 12h au lieu de 24h
				shadow_h = lerp(h_max, 0, _pourcent*2);
			}*/
		
			//}
			//shadow_h = lerp(0, h_max, _CYCLE.hours);
		
			/*
			shadow_w = lerp(w_max, 0, _CYCLE.hours);
			shadow_h = lerp(h_max, 0, _CYCLE.hours);
			*/
		
		
			/*
			//VARIATION TAILLE DES OMBRES EN FONCTION DU CYCLE JOUR/NUIT
			while(_CYCLE.seconds <= (86400/2))	//De 0 sec à midi (86400 secondes par jours)... 
			{ 
				shadow_w = _CYCLE.minutes;		//w diminue
				shadow_h = _CYCLE.minutes;		//h augmente (dans le négatif)	
			}*/
			/*
			while(_CYCLE.seconds > (86400/2) and _CYCLE.seconds < 86400)
			{
				shadow_w -=	_CYCLE.minutes;		//w diminue
				shadow_h += _CYCLE.minutes;		//h augmente (dans le négatif)	
			}
			*/
		}
	}

#endregion

#region SPAWN OBJECT EN FONCTION DE LA PHASE DE LA JOURNEE


	var _current_color = draw_get_color();

	if(phase == "Night")
	{
	
	//	draw_set_color(c_yellow);
		//global.color_gui = c_yellow;
	
	//	draw_text(50, 50, "Il va faire tout noir");
	
		/*with(o_spawn_object_when_night)
		{
			var _pos_x = random_range(50, global.gui_w-50);
			var _pos_y = random_range(50, global.gui_h-50);
		
		
			//instance_create_layer(_pos_x, _pos_y, "Instances", obj_flore_lys_rouge);
			//draw_text(global.gui_w/2, global.gui_h/2, "NUIIIIT");
		}*/
	}
	else{ draw_set_color(_current_color); }

#endregion