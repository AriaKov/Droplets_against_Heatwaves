

cell = RES.CELLSIZE;

#region LIGHT SYSTEM

	//tuto : https://www.youtube.com/watch?v=Q_RAGnirITo (Simple 2D Lighting - GameMaker Tutorial, DragoniteSpam)
	//La surface dépend fortement de l'ordre de lecture des events de GM
	application_surface_draw_enable(false);
	
	camera	= view_get_camera(0);
	cam_w	= camera_get_view_width(camera);
	cam_h	= camera_get_view_height(camera);
	
	light_surface = surface_create(cam_w, cam_h);
	//global.particle_system = 0;
	
	alpha_surface_dark	= 0; //Varie parallèlement avec o_cycle_day_night.darkness;
	
	draw_halo_light		= true;
	
#endregion


#region PARAMETRES

	scale		= 1;
	
	//halo = spr_radial_light_5;
	halo		= spr_halo_subdivise;
	halo_small	= spr_halo_subdivise_small;
	halo_spark	= spr_halo_16;
	//halo = spr_halo_512_intense; 
	//halo = spr_halo_160_subdiv_10;
	
	//Lightsources
	player		= obj_player;
	flore		= obj_flore_parent;
	pnj			= obj_pnj_leaf_parent;
	fire_medium		= obj_fire_medium;
	fire_small	= obj_fire_medium;
	spark		= obj_fire_particle;
	pnj			= obj_pnj_droplet;
	faune		= obj_faune_solitaire_parent;

	alpha_medium	= 0.3;
	alpha_low		= 0.1;
	
	
	color_dark	= merge_color(COL.BLACK, COL.INDIGO, 0.5);
	color_dark	= COL.BLACK;

#endregion
