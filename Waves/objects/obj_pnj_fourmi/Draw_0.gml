///@desc QUEST

event_inherited();

/*

var _s = 1;

if(state == FOURMI.NORMAL)
{
	if(show_details == true)
	{
		//Bulle
		draw_sprite_ext(bulle, bulle_img_smile, bulle_x, bulle_y, _s, _s, 0, bulle_color, 1);
	}
}

if(state == FOURMI.ASKING)
{
	//Bulle
		var _bulle_img;
		if(show_details == false)	{	_bulle_img = bulle_img_ask;		}
		if(show_details == true)	{	_bulle_img = bulle_img_plant;	}
	draw_sprite_ext(bulle, _bulle_img, bulle_x, bulle_y, _s, _s, 0, bulle_color, 1);
			
	if(show_details == true)
	{
		//Demande de plante
		var _yy;
		if(plant_img == 0)	{ _yy = plant_y; }
		if(plant_img > 0)	{ _yy = plant_y + (bulle_h/3); }
		draw_sprite_ext(plant_spr, plant_img, plant_x, _yy, _s, _s, 0, c_white, 1);
	}
}


	
