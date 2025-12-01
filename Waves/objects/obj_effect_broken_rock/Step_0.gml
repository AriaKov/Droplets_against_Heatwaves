///@desc MOVE

if(global.pause == true)
{
	if(has_just_been_paused == false){ 
		time_remaining	= alarm_get(10);		//On sauve le temps restant
	}
	alarm[10]				= time_remaining;	//On incrémente l'alarme à l'infini pour ne pas l'activer
	has_just_been_paused	= true; 
	exit;
}
else
{
	if(has_just_been_paused == true)
	{
		alarm[10]				= time_remaining;
		has_just_been_paused	= false;
	}
}

//move_y += global.gravite/4;
//move_y += global.gravite/5;
move_y += global.gravite/2;

x += move_x; 
y += move_y;


//Diminution de l'alpha
image_alpha		-= alpha_decay;
if(image_alpha <= 0){ instance_destroy(); }

