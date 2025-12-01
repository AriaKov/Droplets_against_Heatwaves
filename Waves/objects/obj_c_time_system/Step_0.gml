///@desc 12:00


mx = display_mouse_get_x();
my = display_mouse_get_y();

hours = global.hours;

//PROJET HEATWAVES : tous les midis un incendie démarre ?
if(hours == 12)
{
	create_fire();
		
}

if(hours == 9) || (hours == 18)
{
//	instance_create_layer(mx, my, "Instances", obj_faune_ourson);
}






