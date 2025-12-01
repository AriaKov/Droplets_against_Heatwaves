///@desc CHANGE DIR

if(global.pause == true){ exit; }

	//Choix d'une direction au hasard
//	dir = random_range(1, 360);
	new_dir = random_range(1, 360);

	//Randomisation des instances, et à chaque changement de dir
	//	per = random_range(0.003, 0.007);
	//	amp = random_range(0.7, 1.3);
	//j'enlève car ça saccade le mouvement

	alarm[7] = random_range(1, 3) * global.game_speed;








