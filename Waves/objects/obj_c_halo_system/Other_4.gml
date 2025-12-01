	//Pour HALO SYSTEM
	//("Other_4" dans le dossier = DEBUT DE LA PIECE)
	camera = view_get_camera(0);
	cam_w = camera_get_view_width(camera);
	cam_h = camera_get_view_height(camera);
	
	light_surface = surface_create(cam_w, cam_h);

