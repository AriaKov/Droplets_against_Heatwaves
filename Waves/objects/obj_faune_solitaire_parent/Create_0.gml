///@desc FAUNE
/*Comportement voulu pour tous les volatiles (oiseaux, papillons, chauves-souris...) :
- Volent dans direction aléatoires, chacun
- On tendance à voler en groupe
- Peuvent changer légèrement de direction toutes les x frames
- Ont de vitesses différentes, définies aléatoirement
- En vol : sprite ..._vol
- Au sol : sprite ..._sol
- Si approche du obj_player : envol et fuite, ou juste envol, ou juste écartement progressif au sol.
- Si clic de la souris somewhere : attrait et vont vers le clic


/*
speed = random(5)-10;
direction = random(30)-15; //aléatoire entre 0 et 30° mais -15° pour centrer sur l'origine
*/

global_var_to_local();

player			= obj_player;
target			= player;

scale			= 1;
image_xscale	= scale;
image_yscale	= scale; 
image_blend		= color_blend;

enum FAUNA_SOLO_STATE { FREE, FLYAWAY, FOLLOW };
state		= FAUNA_SOLO_STATE.FREE;
state_str	= "FREE";


direction	= dir_init; //direction initiale du state FREE (pour que tous les oiseaux
// (d'un même groupe (cf. o_spawn_oiseaux)) aillent +/- dans la même direction.
move_x		= 0;
move_y		= 0;

moving		= false; //true quand idle (???)

//FREE
can_change_direction = true;
timer_free = irandom_range(30,60);
timer_free = irandom_range(60,120);
timer_free = random_range(1, 10) * global.game_speed;

//FLY AWAY
//ray_flyaway			= random_range(16, 48);	//Rayon àpduquel l'animal fuit.
ray_max				= 128;	//Rayon à partir duquel l'animal se calme et revient en state FREE.

//PREDATEURS (triggers de fuite). Si l'animal est introverti, il a peur aussi des autres animaux solitaires
if(introvert == false)	{ predateurs = [obj_player, obj_fire_parent]; }
else					{ predateurs = [obj_player, obj_fire_parent, obj_faune_parent]; }
ds_list_predateurs	= ds_list_create();

flee_dir			 = 0;

//FOLLOW
proximite_max		= 25;	//si follow

//FLOATTING WHEN FLYING
rand_per = random_range(0.01, 0.02);	//Vitesse (+grand = + lent) //mediane 0.01
rand_amp = random_range(1.8, 2);		//Hauteur de l'onde (+grand = + haut) //mediane 2 (diviseur)
