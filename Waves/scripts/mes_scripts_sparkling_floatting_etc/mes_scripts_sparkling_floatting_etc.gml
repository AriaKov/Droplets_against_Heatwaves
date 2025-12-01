// MES SCRIPTS D'EFFETS

///@desc	Create an intense sparkling effect with an asset (ex : obj_eclat) randomly spawned on the top of an object.
///@desc	ATTENTION : Nécéssite de déclarer t = 0; dans le CREATE EVENT de l'objet appelant la fonction :-)
///@arg {asset} sparkling_object	The object on witch create the sparkling effect. (The location of the spawn depends on the size of this object)
///@arg layer	The layer
///@arg {asset} obj_sparkle	The object that will sparkle randomly on the top of the _sparkling_object. This asset must destroy itself after a short amount of time.
///@arg {real} frequence*	The frequence of sparkling (Ex : 0.1 or 0.2) (Defaut : 0.1)
///@arg {real} portion*	The portion of the object's surface to cover with sparkling (0 = TOTAL, 1 = only TOP, 2 = only BOTTOM) (Defaut : 0)
///@arg {real} decalage_h*	Decalage horizontal (in pixel) (Defaut : 0)
///@arg {real} decalage_v*	Decalage vertical (in pixel) (Defaut : 0)
///@arg color	Couleur
///@arg {real}	entire_sprite Se baser sur le sprite entier (-1) ou juste quelques px autour de x, y (entier)
// <3

function intense_sparkling_on_object(argument0, argument1, argument2, argument3 = 0.1, argument4 = 0, argument5 = 0, argument6 = 0, argument7 = c_white, argument8 = -1)
{
	//ATTENTION : Nécéssite de déclarer t = 0; dans CREATE de l'objet appelant la fonction.
				
	var _sparkling_object	= argument0;	
	var _layer				= argument1;	//"Instances"
	var _obj_sparkle		= argument2;	//obj_eclat
	var _frequence			= argument3;	//0.2
	var _portion			= argument4;	//0 = total, 1 = top, 2 = bottom
	var _decalage_h			= argument5;	//en pixel
	var _decalage_v			= argument6;	//en pixel
	var _color				= argument7;
	var _zone_autour_du_centre	= argument8;	//-1 si sprite entier (version d'origine), sinon indiquer zone en pixel
	
	
	var _w = _sparkling_object.sprite_width;
	var _h = _sparkling_object.sprite_height;
	var _rx = random_range( 0, _w);		if(_zone_autour_du_centre != -1){ _rx = random_range(-_zone_autour_du_centre, _zone_autour_du_centre); }
	var _ry;
	
	if(_zone_autour_du_centre == -1)
	{
		//REPARTITION SUR QUELLE PORTION DU SPRITE DE L'OBJET ?
		switch(_portion)
		{
			case "0":	//Répartition sur la totalité de la Surface	
						_ry = random_range( 0, _h);		break;
			case "1":	//Répartition sur LA PARTIE HAUTE de la Surface
						_ry = random_range( 0, _h/2);		break;
			case "2":	//Répartition sur LA PARTIE BASSE de la Surface
						_ry = random_range( _h/2, _h);		break;
		}
		
		/*
		if(_portion == "0")	//Répartition sur la totalité de la Surface
		{
			_ry = random_range( 0, _h);
		}
		if(_portion == "1")	//Répartition sur LA PARTIE HAUTE de la Surface
		{
			_ry = random_range( 0, _h/2);
		}
		if(_portion == "2")	//Répartition sur LA PARTIE BASSE de la Surface
		{
			_ry = random_range( _h/2, _h);
		}
		*/
	}
	else
	{
		_ry = random_range(-_zone_autour_du_centre, _zone_autour_du_centre);
	}
	
	timer += 1;
	if(timer >= (_frequence * game_get_speed(gamespeed_fps)))
	{
		var _ix = x - (_w/2) + _rx + _decalage_h;
		var _iy = y - (_h/2) + _ry + _decalage_v;
		
		if(_zone_autour_du_centre != -1)
		{
			_ix = x + _rx + _decalage_h;
			_iy = y + _ry + _decalage_v;
		}
		
		instance_create_layer(_ix, _iy, _layer, _obj_sparkle);
		//	_inst.image_blend = _color;
		timer = 0;
	}		
}



///@desc	Crée un flottement cos-sinusoidal sur x (cos) et y (sin) d'un objet (_floatting_obj) autour d'un autre (_target_obj). Note : Si _target_obj = _floatting_obj, alors l'obj floatting oscille sur place.
///@desc	ATTENTION, IL FAUT DECLARER t = 0; dans le CREATE de l'objet appelant la fonction :-)
///@arg floatting_object	L'objet qui flotte ( autour de _target_object )
///@arg target_object	Objet autour duquel oscille le premier ( peut être le même objet ou un objet différent )
///@arg {real} period	Longueur d'onde (+ grand = + lent) Par défaut : 0.05
///@arg	{real} amplitud	Hauteur de l'onde (+ grand = + haute) Par défaut : 0.1
///@arg	{real} ratio	Facteur de différence (de periode et amplitude) entre sinus (y) et cos (x). Par défaut : 2

function floatting_sinusoidal_xy(argument0, argument1, argument2 = 0.05, argument3 = 0.1, argument4 = 2)
{	
	var _floatting_object	= argument0;	//L'objet qui flotte (autour de la target)
	var _target_object		= argument1;	//Target (Peut être le même objet ou un objet différent)
	var _period				= argument2;	//0.05
	var _amplitud			= argument3;	//0.1
	var _ratio				= argument4;	//Le ration entre le cosinus et le sinus

	_floatting_object.x = _target_object.x + cos(current_time * _period * _ratio) * _amplitud/_ratio;
	_floatting_object.y = _target_object.y + sin(current_time * _period) * _amplitud;
	//timer++;
}


///@desc	Crée un flottement cos-sinusoidal d'un objet (_floatting_obj) autour d'un autre (_target_obj). Note : Si _target_obj = _floatting_obj, alors l'obj floatting oscille sur place.
///@desc	ATTENTION, IL FAUT DECLARER t = 0; dans le CREATE de l'objet appelant la fonction :-)
///@arg floatting_object	L'objet qui flotte ( autour de _target_object )
///@arg target_object	Objet autour duquel oscille le premier ( peut être le même objet ou un objet différent )
///@arg {real} period	Longueur d'onde (+ grand = + lent) Ex : 0.05
///@arg	{real} amplitud	Hauteur de l'onde (+ grand = + haute) Ex : 0.1

function floatting_sinusoidal_y(argument0, argument1, argument2 = 0.05, argument3 = 0.1)
{	
	var _floatting_object	= argument0;	//L'objet qui flotte (autour de la target)
	var _target_object		= argument1;	//Target (Peut être le même objet ou un objet différent)
	var _period				= argument2;	//0.05
	var _amplitud			= argument3;	//0.1

	//_floatting_object.x = _target_object.x + cos(timer * _period*2) * _amplitud/2;
	_floatting_object.y = _target_object.y + sin(current_time * _period) * _amplitud;
	//timer++;
}


///@desc	Crée un flottement cos-sinusoidal d'un objet (_floatting_obj) autour d'un autre (_target_obj). Note : Si _target_obj = _floatting_obj, alors l'obj floatting oscille sur place.
///@desc	ATTENTION, IL FAUT DECLARER t = 0; dans le CREATE de l'objet appelant la fonction :-)
///@arg _floatting_object	L'objet qui flotte ( autour de _target_object )
///@arg _target_object	Objet autour duquel oscille le premier ( peut être le même objet ou un objet différent )
///@arg {real} _period	Longueur d'onde (+ grand = + lent) Ex : 0.05
///@arg	{real} _amplitud	Hauteur de l'onde (+ grand = + haute) Ex : 0.1

function floatting_sinusoidal_x(argument0, argument1, argument2 = 0.05, argument3 = 0.1)
{	
	var _floatting_object	= argument0;	//L'objet qui flotte (autour de la target)
	var _target_object		= argument1;	//Target (Peut être le même objet ou un objet différent)
	var _period				= argument2;	//0.05
	var _amplitud			= argument3;	//0.1

	//_floatting_object.x = _target_object.x + cos(timer * _period*2) * _amplitud/2;
	_floatting_object.x = _target_object.x + sin(current_time * _period) * _amplitud;
	//timer++;
}





			