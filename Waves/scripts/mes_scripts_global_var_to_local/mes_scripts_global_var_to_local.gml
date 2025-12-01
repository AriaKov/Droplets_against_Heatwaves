
///@desc Fonction qui crée des variables locales en fonction de constantes du jeu définies dans o_global.
///@desc Concrètement, on déclare : cell = RES.CELLSIZE, mx, my, et les couleurs : black = COL.BLACK...etc.
function global_var_to_local()
{
	cell		= RES.CELLSIZE;
	
	black	= COL.BLACK;
	white	= COL.WHITE;
	blue	= COL.INDIGO;
	cyan	= COL.WATER;
	green	= COL.GREEN;
	yellow	= COL.YELLOW;
	orange	= COL.ORANGE;
	red		= COL.RED;
	
	mx = display_mouse_get_x();
	my = display_mouse_get_y();
	
	player		= obj_player;
	
	show_debug	= false;
}


