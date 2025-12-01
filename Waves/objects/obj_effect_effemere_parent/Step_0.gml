///@desc PAUSE

var _timespeed = 1;
if(depends_on_time_speed == true) { _timespeed = global.time_speed; }


if (global.pause == false)							{ image_speed = 1 * _timespeed; }
if (global.pause == true && stops_if_pause == true)	{ image_speed = 0 * _timespeed; }


if(alpha_diminution == true)
{
	//Diminution de l'alpha
	image_alpha -= alpha_decay;
	if(image_alpha <= 0){ instance_destroy(); }	
}
