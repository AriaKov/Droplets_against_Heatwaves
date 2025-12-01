///// C A M E R A   M O D E S
///// Super tuto : https://www.youtube.com/watch?v=Gj6bTqKIsLk

enum CAMMODE {
	FOLLOW_OBJECT		= 0,			
	FOLLOW_MOUSE_DRAG	= 1,		
	FOLLOW_MOUSE_BORDER = 2,	
	FOLLOW_MOUSE_PEEK	= 3,	
	MOVE_TO_TARGET		= 4,	//Avec ralentissement (lerp)
	MOVE_TO_FOLLOW_OBJECT = 5,
	
	FOLLOW_OTHER_PEEK = 6, //<3
	
	MOVE_TO_TARGET_SMOOTH,	//Avec accélération au début et ralentissement (lerp)
	//Dans les enum les équivalences (= 0) peuvent aussi être des strings...
	//Et si on ne met rien, c'est d'office (et implicitement) égal à 0, 1, 2,... dans l'ordre.
	
	INERT,
}

mode							= CAMMODE.FOLLOW_OBJECT;

boundless						= false; //Sans limite = non. Donc position camera limitée (aux bords de la room par ex)
desactive_instance_hors_view	= false; //Pour optimisation, mettre true

player		= obj_player;
otf			= player;

//other_object = obj_fountain;	//POUR LES CUTSCENES
lerp_amount = 0;
counter		= 0; 


//PARAMETRES DE LA CAMERA "view 0". (Activer la vue correspondante dans les paramètres de la room).
cam		= view_camera[0];	
view_w	= camera_get_view_width(cam);
view_h 	= camera_get_view_height(cam);

//Current position of the camera (aller dans les propriétés de la room pour activer view[0])
cx = camera_get_view_x(cam);
cy = camera_get_view_y(cam);

//Pour le mode 4 (move_to_target)
target_x	= 640 + 640/2;
target_y	= 360;

	//Depuis mon projet WAVES...
	if(instance_exists(otf) == true)
	{
		target_x = otf.x - (view_w/2);
		target_y = otf.y - (view_h/2);
	}
	lerp_amount		= 0.02;	//0.1;	//Montant du lerp pour les interpolations (acc et déc)
	speed_constant	= 0.02;			//Vitesse de croisière (constante)
	dir		= point_direction(cx, cy, target_x, target_y);
	dist	= point_distance(cx, cy, target_x, target_y);


//Pour le mode 2 (follow_mouse_drag)
mouse_xprevious = -1;
mouse_yprevious = -1;

counter = 0;


//Pour le travelling automatique
travel_x_from	= 0;
travel_y_from	= 0;
travel_x_to		= 640;
travel_y_to		= 0;


//Shaking screen
can_shake_camera		= true;
shake_camera			= false;
shake_camera_amount		= 3;	//Pixel
shake_camera_duration	= 0.2 * global.game_speed;

//Zoom
can_zoom				= true;		
zoom_instant			= false;	//Lerp progressif ou instantané


#region ZOOM +/- DURANT LE JEU
	
	//global.key_zoom		= ord("Z");	//Input pour zoomer & dézoomer
	//global.gp_zoom		= gp_shoulderl;
	zoom_lerp_speed	= 0.05;	//0.1;
	
		vs				= 0;
		views_scales	= [1, 0.75, 0.5];
		view_scale		= views_scales[vs];

	////ZOOM
	cam_w_init	= RES.W;	//320;	//RES.WIDTH
	cam_h_init	= RES.H;	//180;	//RES.HEIGHT
	
	//Toutes les tailles possibles de la camera (du plus grand zoom +++ au plus lointain ---)
	nombre_de_zooms = 2;
	
	if(nombre_de_zooms == 2)
	{
		cam_w_sizes		= [cam_w_init,		cam_w_init*2];	//Multiples x2 x2 x2 ...
		cam_h_sizes		= [cam_h_init,		cam_h_init*2];	
	}
	
	if(nombre_de_zooms == 3)
	{
		cam_w_sizes			= [cam_w_init/2,	cam_w_init,		cam_w_init*2];	//Multiples x2 x2 x2 ...
		cam_h_sizes			= [cam_h_init/2,	cam_h_init,		cam_h_init*2];	
	}
	
	//cam_multiple		= 0;
	cam_multiple_max	= array_length(cam_w_sizes) - 1;
	cam_multiple		= cam_multiple_max;
	cam_multiple		= clamp(cam_multiple, 0, array_length(cam_w_sizes));
	
	//Taille (zoom) actuelle de la caméra
	cam_w = cam_w_sizes[cam_multiple];
	cam_h = cam_h_sizes[cam_multiple];
	
	//show_message("ZOOM : vs = " + string(vs) + ".  cam_w x cam_h = " + string(cam_w) +" x " + string(cam_h) + "  ");
//	show_debug_message("ZOOM : cam_multiple = " + string(cam_multiple) + ".  (cam_w x cam_h = " + string(cam_w) +" x " + string(cam_h) + ")");
		
#endregion



