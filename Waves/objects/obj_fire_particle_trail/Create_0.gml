

cell = RES.CELLSIZE;

move_x_max = cell/4;
move_y_max = - cell/5;
move_x = random_range(- move_x_max, move_x_max);		//Direction aléatoire
move_y = random_range(move_y_max, move_y_max + 8);	//"Saut" initial
//move_y = random_range(-2, -5);


image_speed = random_range(0.9, 2);

flamable_ray = sprite_get_width(sprite_index);

color = c_white;

