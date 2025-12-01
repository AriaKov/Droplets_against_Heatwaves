///@desc FAUNE
//Animal indépendant qui pickup des items que player peut prendre aussi.
//L'animal va éviter player autant que possible.

global_var_to_local();

mx = display_mouse_get_x();
my = display_mouse_get_y();

player			= obj_player;
scale			= 1;

//Apparait hors du champ de vision de la caméra,
//Uniquement s'il n'y a pas déjà un voleur ?
//Uniquement si un objet l'intéresse ?
target			= obj_item_parent;
	if(instance_exists(target)){
	target_x		= target.x;
	target_y		= target.y;
	}
	else {
	target_x		= mx;
	target_y		= my;
	}

enum THIEF_STATE { IDLE, WANDER, RAZZIA, RUNAWAY }
state		= THIEF_STATE.IDLE;
state_str	= "IDLE";

counter		= 0;	//Permet le changement d'état sans alarme, dans step ! :)

move_x		= 0;
move_y		= 0;
moving		= false; //true quand idle (???)
move_speed	= 1;
my_dir		= irandom_range(1, 360);

ray_alert	= 64;	//Distance à laquelle iel s'enfuit si on s'approche
ray_razzia	= 128;	//Distance à laquelle il peut remarquer un item convoité
ray_near	= 8;

//FREE
can_change_direction = true;
timer_free = irandom_range(30,60);
timer_free = irandom_range(60,120);
timer_free = random_range(1, 10) * global.game_speed;

//FLY AWAY
//ray_flyaway			= random_range(16, 48);	//Rayon àpduquel l'animal fuit.
ray_max				= 128;	//Rayon à partir duquel l'animal se calme et revient en state FREE.

//PREDATEURS (triggers de fuite). Si l'animal est introverti, il a peur aussi des autres animaux solitaires
introvert = false;
if(introvert == false)	{ predateurs = [obj_player, obj_fire_parent]; }
else					{ predateurs = [obj_player, obj_fire_parent, obj_faune_parent]; }

ds_list_predateurs	= ds_list_create();

flee_dir			 = 0;

//FOLLOW
//proximite_max		= 25;	//si follow

//FLOATTING WHEN FLYING
rand_per = random_range(0.01, 0.02);	//Vitesse (+grand = + lent) //mediane 0.01
rand_amp = random_range(1.8, 2);		//Hauteur de l'onde (+grand = + haut) //mediane 2 (diviseur)
