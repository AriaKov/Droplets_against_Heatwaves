///@desc ALPHA++


if(fade_out_active == true)
{
	alpha += alpha_add;
}

if(alpha >= alpha_max)
{
	room_goto(target_room);
}

indic_img_counter++;
/*
if(place_meeting(x, y, obj_collision_parent) == true)
{
//	instance_deactivate_object(self);
}
else
{
//	instance_activate_object(self);	
}





