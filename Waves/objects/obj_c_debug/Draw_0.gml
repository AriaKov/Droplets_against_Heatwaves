///@desc BBOX

if(global.debug == true)
{
	with(obj_vfx_parent_of_objects_3d)
	{
		draw_set_alpha(0.1);
		draw_set_color(c_white);
		draw_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, false);
		draw_set_alpha(1);
	}

}


