///@desc 

if(actif == false) { instance_destroy(); }


mx = display_mouse_get_x();
my = display_mouse_get_y();

scale	= RES.SCALE;
cell	= RES.CELLSIZE * scale;

player			= obj_player;

nb_plants		= instance_number(obj_flore_parent);

nb_fauna		= instance_number(obj_faune_solitaire_parent);
nb_fox			= instance_number(obj_faune_fox);
nb_ourson		= instance_number(obj_faune_ourson);
nb_bird			= instance_number(obj_faune_bird);
nb_butterfly	= instance_number(obj_faune_butterfly);
nb_fauna_total	= nb_fox + nb_bird + nb_butterfly; 

nb_traces		= instance_number(obj_trainee_point);



