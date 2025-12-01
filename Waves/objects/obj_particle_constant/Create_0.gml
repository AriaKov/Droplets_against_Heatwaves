

cell = RES.CELLSIZE;


#region SPRITE ♥

	hue		= irandom_range(30, 130);
	hue		= choose(irandom_range(0, 20), irandom_range(230, 255));
	hue		= irandom_range(230, 255);
	sat		= irandom_range(180, 240);	sat	= irandom_range(220, 250);
	val		= irandom_range(50, 200);	val	= irandom_range(200, 255);
	color	= make_color_hsv(hue, sat, val);
	image_blend = color;
	
	alpha = 1;
	alpha_decrease = 0.08;	alpha_decrease = 0.07;

#endregion


move_x_max = cell/4;
move_y_max = - cell/5;
move_x = random_range(- move_x_max, move_x_max);		//Direction aléatoire
move_y = random_range(move_y_max, move_y_max + 8);	//"Saut" initial
//move_y = random_range(-2, -5);


//image_speed = random_range(0.9, 2);



