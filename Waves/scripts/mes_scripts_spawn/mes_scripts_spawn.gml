///@desc Créé (ou pas) des instances d'un objet dans la room, sur le layer "Instances", sur une grille de taille cellsize, avec une certaine probabilité. Il est possible d'exclure certaines cases d'arrivée (par exemple, si place_meeting(x, y, obj_collision) ).

///@arg object	Objet à créer
///@arg {real} probabilite	Probabilite d'apparition de l'instance (1 sur proba). Défaut : 4.
///@arg	{real} number_max	Nombre maxi d'instances dans la room. Défaut : 100.
///@arg obj_exception	Si cet object ou liste d'object [..., ...] est présent (place_meeting()) on ne crée pas l'instance. Défaut : obj_collision. 
///@arg {real} cellsize	Taille des cases (carrées) de la grille, en pixel. Idéalement multiple de la room. Défaut : 8 px.
///@arg {bool} adjust	Ajustement : nécéssaire (TRUE) si l'instance à créer a son point d'origine centré, sinon (FALSE) c'est qu'il est en top-left. (Valeur = cellsize/2). Défaut : true
///@arg {real} margin_h	Marge à chaque bord (droite-gauche), en nombre de case vides.
///@arg {real} margin_v	Marge à chaque bord (haut-bas), en nombre de case vides.

function spawn_object_randomly_on_grid(argument0 = obj_luciole, argument1 = 4, argument2 = 100, argument3 = obj_collision_parent, argument4 = 8, argument5 = true, argument6 = 0, argument7 = 0)
{
	var _obj_to_create	= argument0;
	var _probabilite	= argument1;	//1 chance sur ...
	var _number_max		= argument2;	//dans la room
	var _obj_exception	= argument3		//Objet qui empêche la création de l'instance si place_meeting() au même endroit
	var _cellsize		= argument4;	//8
	var _adjust			= argument5;	//true
	var _margin_h		= argument6;	//0
	var _margin_v		= argument7;	//0

	//Nombre de cellules en ligne et en colonne dans la room.
//	var _nb_cell_x = room_width / _cellsize;
//	var _nb_cell_y = room_height / _cellsize;
	var _nb_cell_x = global.gui_w / _cellsize;
	var _nb_cell_y = global.gui_h / _cellsize;

	var _ajust_x = 0;
	var _ajust_y = 0;
	
	if (_adjust == true) //Si l'instance à créer a son point d'origine centré et pas en top-left, il faut ajuster
	{
		_ajust_x = _cellsize/2;
		_ajust_y = _cellsize/2;
	}
	
	//CREATION DES INSTANCES
	for		(var _i = 0 + _margin_h; (_i < _nb_cell_x - _margin_h); _i++)	//LIGNES
	{
		for	(var _j = 0 + _margin_v; (_j < _nb_cell_y - _margin_v); _j++)	//COLONNES
		{	 
			{
				var _x = _i * _cellsize + _ajust_x;
				var _y = _j * _cellsize + _ajust_y;
				
				var _rand = irandom(_probabilite);
				if (_rand == 1)
				{
					if(place_meeting(_x, _y, _obj_exception) == false) && (instance_number(_obj_to_create) < _number_max)	//Dernières conditions
					{
						instance_create_layer(_x, _y, "Instances", _obj_to_create); //Création instance
					}
				}
			}
		}
	}
}

//ancien nom : spawn_random_object_on_grid()


///@desc Mais en fait... je vient de coder une bête fonction de collision avec un objet, déjà existante... mdr
function collision_object_rectangle(argument0, argument1)
{
	var _obj = argument0;	//Objet rectangle posé dans la room, qui délimite la zone où peut se mettre l'objet
	var _obj_a_placer = argument1;
	var _obj_w = sprite_get_width(_obj.sprite_index);	//Largeur du sprite
	var _obj_h = sprite_get_height(_obj.sprite_index);	//Hauteur du sprite
	
	var _coll = collision_rectangle(_obj.x, _obj.y, _obj.x + _obj_w, _obj.y + _obj_h, _obj_a_placer, false, true);
	return _coll;
}


///@desc Créé (ou pas) des instances d'un objet dans la room, sur le layer "Instances", sur une grille de taille cellsize, avec une certaine probabilité. Il est possible d'exclure certaines cases d'arrivée (par exemple, si place_meeting(x, y, obj_collision) ).

///@arg object	Objet à créer
///@arg {real} probabilite	Probabilite d'apparition de l'instance (1 sur proba). Défaut : 4.
///@arg	{real} number_max	Nombre maxi d'instances dans la room. Défaut : 100.
///@arg obj_exception	Si cet object ou liste d'object [..., ...] est présent (place_meeting()) on ne crée pas l'instance. Défaut : obj_collision. 
///@arg {real} cellsize	Taille des cases (carrées) de la grille, en pixel. Idéalement multiple de la room. Défaut : 8 px.
///@arg {bool} adjust	Ajustement : nécéssaire (TRUE) si l'instance à créer a son point d'origine centré, sinon (FALSE) c'est qu'il est en top-left. (Valeur = cellsize/2). Défaut : true
///@arg {real} margin_h	Marge à chaque bord (droite-gauche), en nombre de case vides.
///@arg {real} margin_v	Marge à chaque bord (haut-bas), en nombre de case vides.
///@arg {real} scale	Echelle. Défaut : 1.
///@arg {expression} blend_color	Couleur pour blending. Défaut : c_white.

function spawn_object_randomly_on_grid_ext(argument0 = obj_luciole, argument1 = 4, argument2 = 100, argument3 = obj_collision, argument4 = 8, argument5 = true, argument6 = 0, argument7 = 0, argument8 = 1, argument9 = c_white)
{
	var _obj_to_create	= argument0;
	var _probabilite	= argument1;	//1 chance sur ...
	var _number_max		= argument2;	//dans la room
	var _obj_exception	= argument3		//Objet qui empêche la création de l'instance si place_meeting() au même endroit
	var _cellsize		= argument4;	//8
	var _adjust			= argument5;	//true
	var _margin_h		= argument6;	//0
	var _margin_v		= argument7;	//0
	var _scale			= argument8;	//1
	var _blend_color	= argument9;	//c_white

	//Nombre de cellules en ligne et en colonne dans la room.
	var _nb_cell_x = room_width / _cellsize;
	var _nb_cell_y = room_height / _cellsize;

	var _ajust_x = 0;
	var _ajust_y = 0;
	
	if _adjust == true //Si l'instance à créer a son point d'origine centré et pas en top-left, il faut ajuster
	{
		_ajust_x = _cellsize/2;
		_ajust_y = _cellsize/2;
	}
	
	//CREATION DES INSTANCES
	for		(var _i = 0 + _margin_h; (_i < _nb_cell_x - _margin_h); _i++)	//LIGNES
	{
		for	(var _j = 0 + _margin_v; (_j < _nb_cell_y - _margin_v); _j++)	//COLONNES
		{	 
			{
				var _x = _i * _cellsize + _ajust_x;
				var _y = _j * _cellsize + _ajust_y;
				
				var _rand = irandom(_probabilite);
				if _rand == 1
				{
					if !place_meeting(_x, _y, _obj_exception) && (instance_number(_obj_to_create) < _number_max)	//Dernières conditions
					{
						var _obj = instance_create_layer(_x, _y, "Instances", _obj_to_create); //Création instance
							_obj.image_xscale = _scale;
							_obj.image_yscale = _scale;
							_obj.image_blend = _blend_color;
					}
				}
			}
		}
	}
}

//ancien nom : spawn_random_object_on_grid_ext()


///@desc Créé régulièrement des instances d'un objet dans la room, sur le layer "Instances", sur une grille de taille cellsize. Il est possible d'exclure certaines cases d'arrivée (par exemple, si place_meeting(x, y, obj_collision) ).

///@arg object	Objet à créer
///@arg obj_exception	Objet (ou liste d'object [..., ...]) à éviter (place_meeting()). Défaut si aucun : noone. 
///@arg {string} _layer	Layer sur lequel créer les instances. Défaut : "Instances"
///@arg {real} cellsize	Taille des cases (carrées) de la grille, en pixel. Idéalement multiple de la room. Défaut : 16 px.
///@arg {bool} adjust	Ajustement : nécéssaire (TRUE) si l'instance à créer a son point d'origine centré, sinon (FALSE) c'est qu'il est en top-left. (Valeur = cellsize/2). Défaut : true
///@arg {real} margin_h	Marge à chaque bord (droite-gauche), en nombre de case vides.
///@arg {real} margin_v	Marge à chaque bord (haut-bas), en nombre de case vides.
///@arg {real} scale	Echelle. Défaut : 1.
///@arg {expression} blend_color	Couleur pour blending. Défaut : c_white.

function spawn_object_on_grid_ext(argument0 = obj_darkness, argument1 = noone, argument2 = "Instances", argument3 = 16, argument4 = true,
argument5 = 0, argument6 = 0, argument7 = 1, argument8 = c_white)
//function spawn_object_on_grid_ext(argument0 = obj_darkness, argument = "Instances", argument1 = noone, argument2 = 16, argument3 = true,
//argument4 = 0, argument5 = 0, argument6 = 1, argument7 = c_white)
{
	var _obj_to_create	= argument0;
	var _obj_exception	= argument1;	//Objet qui empêche la création de l'instance si place_meeting() au même endroit
	var _layer			= argument2;	//"Instances"
	var _cellsize		= argument3;	//8
	var _adjust			= argument4;	//true
	var _margin_h		= argument5;	//0
	var _margin_v		= argument6;	//0
	var _scale			= argument7;	//1
	var _blend_color	= argument8;	//c_white

	//Nombre de cellules en ligne et en colonne dans la room.
	var _nb_cell_x = room_width / _cellsize;
	var _nb_cell_y = room_height / _cellsize;

	var _ajust_x = 0;
	var _ajust_y = 0;
	
	if _adjust == true //Si l'instance à créer a son point d'origine centré et pas en top-left, il faut ajuster
	{
		_ajust_x = _cellsize/2;
		_ajust_y = _cellsize/2;
	}
	
	//CREATION DES INSTANCES
	for		(var _i = 0 + _margin_h; (_i < _nb_cell_x - _margin_h); _i++)	//LIGNES
	{
		for	(var _j = 0 + _margin_v; (_j < _nb_cell_y - _margin_v); _j++)	//COLONNES
		{	 
			{
				var _x = ( _i * _cellsize ) + _ajust_x;
				var _y = ( _j * _cellsize ) + _ajust_y;
				
				if _obj_exception != noone
				{
					if !place_meeting(_x, _y, _obj_exception)	//Dernières conditions
					{
						var _obj = instance_create_layer(_x, _y, _layer, _obj_to_create); //Création instance
							//_obj.image_xscale = _scale;
							//_obj.image_yscale = _scale;
							//_obj.image_blend = _blend_color;
					}
				}
				else if _obj_exception == noone
				{
					var _obj = instance_create_layer(_x, _y, _layer, _obj_to_create); //Création instance
						_obj.image_xscale = _scale;
						_obj.image_yscale = _scale;
						_obj.image_blend = _blend_color;
						
				}
			}
		}
	}
}


///@desc Créé régulièrement des instances d'un objet dans la room, sur une grille, et DANS UN RECTANGLE DE LA TAILLE DE L'OBJECT MIS DANS LA ROOM. Il est possible d'exclure certaines cases d'arrivée (par exemple, si place_meeting(x, y, obj_collision) ).

///@arg object	Objet à créer
///@arg obj_exception	Objet (ou liste d'object [..., ...]) à éviter (place_meeting()). Défaut si aucun : noone. 
///@arg {string} _layer	Layer sur lequel créer les instances. Défaut : "Instances"
///@arg {real} cellsize	Taille des cases (carrées) de la grille, en pixel. Idéalement multiple de la room. Défaut : 16 px.
///@arg {bool} adjust	Ajustement : nécéssaire (TRUE) si l'instance à créer a son point d'origine centré, sinon (FALSE) c'est qu'il est en top-left. (Valeur = cellsize/2). Défaut : true

///@arg {real} margin_h	Marge à chaque bord (droite-gauche), en nombre de case vides.
///@arg {real} margin_v	Marge à chaque bord (haut-bas), en nombre de case vides.

///@arg {real} scale	Echelle. Défaut : 1.
///@arg {expression} blend_color	Couleur pour blending. Défaut : c_white.
///@arg {real} probabilite	Probabilite d'apparition de l'instance (1 sur proba). Défaut : 4.

function spawn_object_on_surface_sprite(argument0, argument1 = obj_collision_parent, argument2 = "Instances", argument3 = 16, argument4 = true,
argument5 = 0, argument6 = 0, argument7 = 1, argument8 = c_white, argument9 = 1)
{
	
	var _obj_to_create	= argument0;	
	
	var _obj_exception	= argument1;	//Objet qui empêche la création de l'instance si place_meeting() au même endroit
	var _layer			= argument2;	//"Instances"
	var _cellsize		= argument3;	//8
	var _adjust			= argument4;	//true
	var _margin_h		= argument5;	//0
	var _margin_v		= argument6;	//0
	var _scale			= argument7;	//1
	var _blend_color	= argument8;	//c_white
	var _probabilite	= argument9;	//1 chance sur ...

	//Nombre de cellules en ligne et en colonne dans la room.
	//var _nb_cell_x = room_width / _cellsize;
	//var _nb_cell_y = room_height / _cellsize;
	
	//var _spr_w = sprite_get_width(sprite_index);
	//var _spr_h = sprite_get_height(sprite_index);
	//current_w = sprite_width;
	//current_h = sprite_height;
	var _spr_w = sprite_width;
	var _spr_h = sprite_height;
	//var _spr_w = (sprite_get_bbox_right(sprite_index) - sprite_get_bbox_left(sprite_index)) * scalex;
	//var _spr_h = (sprite_get_bbox_bottom(sprite_index) - sprite_get_bbox_top(sprite_index)) * scaley;
	
	//Nombre de cellules en ligne et en colonne sur le SPRITE.
	var _nb_cell_x = _spr_w / _cellsize;
	var _nb_cell_y = _spr_h / _cellsize;

	var _ajust_x = 0;
	var _ajust_y = 0;
	
	if _adjust == true //Si l'instance à créer a son point d'origine centré et pas en top-left, il faut ajuster
	{
		_ajust_x = _cellsize/2;
		_ajust_y = _cellsize/2;
	}
	
	//CREATION DES INSTANCES
	for		(var _i = 0 + _margin_h; (_i < _nb_cell_x - _margin_h); _i++)	//LIGNES
	{
		for	(var _j = 0 + _margin_v; (_j < _nb_cell_y - _margin_v); _j++)	//COLONNES
		{	 
			{
				var _rand = irandom(_probabilite);
				if _rand == 1
				{
					var _x = x + ( _i * _cellsize ) + _ajust_x;
					var _y = y + ( _j * _cellsize ) + _ajust_y;
				
					if (_obj_exception != noone)
					{
						if !place_meeting(_x, _y, _obj_exception)	//Dernières conditions
						{
							var _obj = instance_create_layer(_x, _y, _layer, _obj_to_create); //Création instance
								//_obj.image_xscale = _scale;
								//_obj.image_yscale = _scale;
								//_obj.image_blend = _blend_color;
						}
					}
					else if (_obj_exception == noone)
					{
						var _obj = instance_create_layer(_x, _y, _layer, _obj_to_create); //Création instance
							_obj.image_xscale = _scale;
							_obj.image_yscale = _scale;
							_obj.image_blend = _blend_color;
						
					}
				}
			}
		}
	}
}


