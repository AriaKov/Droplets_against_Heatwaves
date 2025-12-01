///@desc GESTION DE LA PAUSE


//Hypothèse de l'incrément
if(humidity >= humidity_max)
|| (place_meeting(x, y, tilemap_water) == true)
{
	instance_destroy();	
}


///@desc PARTICULE


var _spr_h = bbox_bottom - bbox_top;
var _spark = instance_create_layer(x, y - _spr_h - 2, layer, obj_fire_particle);
//	_spark.image_blend = color_burning;	
//alarm_spark_can_be_set = true;



/*
if(global.pause == true)
{
	image_speed		= 0;
	
	if(automatic_destruction == true)
	{
		//Même code que pour obj_splash, qui a aussi une destruction automatique (indépendament de son alpha_decay)
		if(has_just_been_paused == false){ 
			time_remaining	= alarm_get(10);	//On sauve le temps restant
		}
		//alarm[10]				= 1000;				//marche aussi mais moins esthétique lol
		alarm[10]				= time_remaining;	//On incrémente l'alarme à l'infini pour ne pas l'activer
		has_just_been_paused	= true; 
	}
	exit;
}

else
{
	image_speed		= rand_speed;

	if(automatic_destruction == true) {
		if(has_just_been_paused == true) {
			alarm[10]				= time_remaining;
			has_just_been_paused	= false;
		}
	}
}


