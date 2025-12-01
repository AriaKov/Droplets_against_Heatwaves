///@desc CONTROLS

mx = display_mouse_get_x();
my = display_mouse_get_y();

if(keyboard_check_pressed(ord("D")))	{ global.debug = !global.debug; }

if(keyboard_check_pressed(vk_delete))	{ game_restart(); }
//if(keyboard_check_pressed(vk_add))		{ if(room_exists(room_next(room)) == true){ room_goto_next(); }}
//if(keyboard_check_pressed(vk_subtract))	{ if(room_exists(room_previous(room)) == true){ room_goto_previous(); }}
if(keyboard_check_pressed(vk_numpad1))		{ if(room_exists(room_next(room)) == true){ room_goto_next(); }}
if(keyboard_check_pressed(vk_numpad2))	{ if(room_exists(room_previous(room)) == true){ room_goto_previous(); }}

/*
if(instance_exists(obj_c_cycle_day_night)) { with(obj_c_cycle_day_night) {
		if(keyboard_check_pressed(vk_multiply)){
			if(time_increment >= 1) { time_increment++; }
			if(time_increment < 1)	{ time_increment += 0.1; }
			}	
		if(keyboard_check_pressed(vk_divide)){ 
			if(time_increment >= 2)	{ time_increment--; }
			if(time_increment <= 1) { time_increment -= 0.1; }
			}	
	//Mise à jour de la durée réelle d'une journée
	duration_of_a_day_in_sec	= (60 * 60 * 24) / time_increment / global.game_speed ;
	duration_of_a_day_in_min	= duration_of_a_day_in_sec / 60;
	duration_of_a_day_in_h		= duration_of_a_day_in_min / 60;
}}*/

//METEO
	//	if(keyboard_check_pressed(ord("B"))){ 
	//	var _layer_id = layer_background_get_id("Background_Brume");
	//	var _alpha = choose(0, 0.5, 1);
	//	layer_background_alpha(_layer_id, _alpha);
	//	}

	if(mouse_check_button_pressed(mb_left))
	{
	    var _back = layer_background_get_id("Background_Brume");
	    if (layer_background_get_visible(_back))
	    {
	//		layer_background_visible(_back, false);
	    }
	    else
	    {
	//        layer_background_visible(_back, true);
	    }
	}


//	if(keyboard_check_pressed(ord("U")))	{ instance_activate_object(obj_player); }
//	if(keyboard_check_pressed(ord("I")))	{ instance_deactivate_object(obj_player); }

//	if(keyboard_check_pressed(ord("S")))	{ with(obj_c_camera){ shake_camera = !shake_camera; }}
//	if(keyboard_check_pressed(ord("S")))	{ shake_camera_shortly(); }

if(keyboard_check(ord("F")))
{
	if(mouse_check_button_pressed(mb_left))
	{ 
		//PARTICULE
	//	instance_create_layer(mouse_x, mouse_y, "Instances", obj_fire_small);
		
			//EFFECT
	var _indic = instance_create_layer(mouse_x, mouse_y, "Instances", obj_effect_seed_pickup); //Anime texte : Nom de la plante / quantité
		//_indic.texte = ( string(_quantite) + " x " + _specie );
		//_indic.texte = ( string(_grid[# 0, _ypos]) + " +" +string(_quantite) + " " + _specie );
		_indic.texte = ( "+1 feu !");			
	}
}
if(mouse_check_button_pressed(mb_left))
{ 
//	var _faune = choose(obj_faune_fox, obj_faune_ourson, obj_faune_pigeon);
//	instance_create_layer(mouse_x, mouse_y, "Instances", _faune);
//	instance_create_layer(mouse_x, mouse_y, "Instances", obj_effect_footstep);		
	instance_create_layer(mouse_x, mouse_y, "Instances", obj_fire_particle);		
}
if(mouse_check_button(mb_left))
{
//	instance_create_layer(mouse_x, mouse_y, "Instances", obj_effect_scintillement);
}


	if(keyboard_check_pressed(ord("A"))) { with(obj_player){ humidity = humidity_max; }}
	if(keyboard_check_pressed(ord("Z"))) { with(obj_player){ humidity = humidity_dry_min; }}

//	if(keyboard_check_pressed(ord("A"))) { with(obj_flore_parent){ humidity = humidity_max; }}
	if(keyboard_check_pressed(ord("Q"))) { with(obj_flore_parent){ humidity = humidity_wet_min; }}

//GROW UP
if(keyboard_check_pressed(ord("G"))) { with(obj_flore_parent){ event_perform(ev_alarm, 0); }}

// var _part_mouse = instance_create_layer(mouse_x, mouse_y, layer, obj_particle_constant);

nb_plants		= instance_number(obj_flore_parent);

nb_fauna		= instance_number(obj_faune_solitaire_parent);
nb_fox			= instance_number(obj_faune_fox);
nb_ourson		= instance_number(obj_faune_ourson);
nb_bird			= instance_number(obj_faune_bird);
nb_butterfly	= instance_number(obj_faune_butterfly);
nb_fauna_total	= nb_fox + nb_ourson + nb_bird + nb_butterfly; 

nb_traces		= instance_number(obj_trainee_point);


