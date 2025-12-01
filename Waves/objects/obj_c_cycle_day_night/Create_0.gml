#region C Y C L E   D A Y   N I G H T   A V E C   C H A N G E M E N T   D  E   C O U L E U R S
// tuto 1 : https://www.youtube.com/watch?v=tlEJt5e62Q4&list=PLSFMekK0JFgzbFfj1vAsyluKTymnBiriY&index=14
// tuto 2 : https://www.youtube.com/watch?v=-T6ThEED-L0&list=PLSFMekK0JFgzbFfj1vAsyluKTymnBiriY&index=15

//Cycle contrôlé par les heures (hours) qui découlent des secondes (time_increment)

//Une partie du Step Event contrôle obj_shadows pour l'inclinaison des ombres
//Une partie du Step Event contrôle obj_spawn_object_when_night
#endregion

global_var_to_local();
mx = display_mouse_get_x();
my = display_mouse_get_y();

	c = 0;
	calendar_colors = [green, yellow, orange, blue];	//printemps, été, automne, hiver
	calendar_colors = [blue, blue, blue, blue];

time_pause		= false;	//Contrôlé par o_DebugControl
draw_daylight	= false;

//Heure de début du cycle quand on appuie sur "T"
phase			= "Day";
//heure_initiale	= 12;	//Dans les variables
//time_increment_init = 30;	//Dans les variables : nombre de secondes en + par frame
//time_increment_init = 6;	//Dans les variables
time_increment		= time_increment_init;
time_increment_max	= 200;	//Lorsque accélération
//Si je veux un temps réel, il faut que chaque frame, on ajoute 60 / global.game_speed;

can_accelerate_time = true;
enum TIME { NORMAL, ACCELERATED }
state		= TIME.NORMAL;
state_str	= "NORMAL";

moment		= 0;	//Position dans le temps, dans la phase donnée (en %)
avancement	= 0;	//Position dans la journée, en %

seconds		= heure_initiale * (60 * 60);
minutes		= 0;
hours		= 0;		//Commencer le cycle à partir de midi : oui mais hours est liée à seconds --> que_hora_es

global.hours			= hours;
	//Combien de temps réel dure une journée dans le jeu ?
	// 86400 secondes = 1440 minutes = 24 heures = 1 jour 
	//Si time_increment == global.game_speed, 1 jour = 1 jour réel
	//Si time_increment == 1, 1 jour = 24 minutes réelles
	//Si time_increment == 2, 1 jour = 12 minutes réelles
	//Si time_increment == 4, 1 jour = 6 minutes réelles
	//Si time_increment == 8, 1 jour = 3 minutes réelles
//	duration_of_a_day_in_sec	= (time_increment * 60 * 60 * 24);
//	duration_of_a_day_in_min	= duration_of_a_day_in_sec / 60;
//	duration_of_a_day_in_h		= duration_of_a_day_in_min / 60;
	duration_of_a_day_in_sec	= (60 * 60 * 24) / time_increment / global.game_speed ;
	duration_of_a_day_in_min	= duration_of_a_day_in_sec / 60;
	duration_of_a_day_in_h		= duration_of_a_day_in_min / 60;

can_set_event_midday = true;


//Jour, saison, année en cours
day			= 1;	days_total = day; //compteur de tous les jours passés (pour le calendrier)
season		= 1;
year		= 1;

//VITESSE DU CYCLE
//(seconds/step) (1/global.game_speed = vitesse réelle)
//time_increment = 1000/global.game_speed;	//Attention : 100/60 = 1.66666... 1000/60 = 16.6666
//time_increment = 60/2;	//Dans les variables

//DARK
darkness		= 0;
darkness_max	= 0.3;	//0.35; //0.3;	//0.7;	
light_color		= c_white;

//COLORS
	//sombre		= merge_color(c_black, c_navy, 0.3);	
	sombre			= merge_color(black, blue, 0.3);	
	color_night		= [sombre];
	colors_sunrise	= [sombre, orange];
	colors_day		= [orange, orange, white, orange, #fb5305];
	colors_sunset	= [ #fb5305, blue, sombre];

	sombre			= merge_color(black, blue, 0.3);	
	color_night		= [sombre];
	colors_sunrise	= [sombre, orange];
	colors_day		= [orange, yellow, cyan, green, white, orange];
	colors_sunset	= [orange, blue, sombre];


gui_w = global.game_width;
gui_h = global.game_height;


enum PHASE {	//"Heures" de début des différentes phases de la journée
//	SUNRISE		= 6,
//	DAYTIME		= 9,	//8.5
//	SUNSET		= 18,
//	NIGHTTIME	= 21,	//22
	
	SUNRISE		= 4,
	DAYTIME		= 9,	
	SUNSET		= 18,
	NIGHTTIME	= 23,	
}


//Je les déclare ici pour pouvoir les appeler sans bug dans le with(obj_shadows) dans STEP.
_darks = 0; _colors = c_blue; _pstart = PHASE.SUNRISE; _pend = PHASE.DAYTIME;



