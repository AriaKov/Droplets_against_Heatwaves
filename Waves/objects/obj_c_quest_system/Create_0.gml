///@desc QUESTS MANAGER
//tuto Friendly Cosmonaut : https://www.youtube.com/watch?v=QPOu4hIRCko

//Imaginer un tableau comme ceci :
// (-1 = inactive / > 0 = en cours. Avec autant de sub-quests que définit dans l'array)
//Nom quête			Etat	Détail (sous-quêtes possibles)
//"Paint things"	0		"Paint tree in red", "Paint tree in blue"
//"Paint things"	-1		"Paint tree in red", "Paint tree in blue"

#region Remarques

//GameStormerGX :
//Would it be possible to load quest data into an array from a spreadsheet,
//so that they wouldn't have to be hard coded into the game?
//I am working on planning my first large project and I would like to get the framework complete first
//so that I can just focus on the creative aspect of building a game
//without having to jump into code every time I want to tweak something, say a reward for a quest
//or whether or not a quest should be grouped as a Main Quest or a Side Quest.

//@FriendlyCosmonaut : Yes, very possible! An easy way to do this is to load spreadsheets as .csv files
//as there are some simple functions that convert the data to a ds_grid

//@GameStormerGX : I'll probably do that and then move to JSON further in development. 


////////// https://forum.gamemaker.io/index.php?threads/data-import-csv-or-json.85099/
//Personally, JSON often comes as a first choice. I really dislike CSV, 
//and go with TSV if I have absolutely no other choice and can't use JSON for whatever reason.
//CSV can possibly **** you up if you try to store, for example,[1,6] as a value. 
//At least a TSV will use Tabs, and not commas.
//JSON is fun because it's a literal syntax, easy to write and easy to read, and you can nest infinitely.

//Thanks everyone for chipping in!
//Still (as obscene pointed out) viewing/editing json files doesn't look to me as immediate as with csv. 
//So with jsons, would the workflow look something like the following?
//prepare your data on spreadsheet --> convert to json with some script (python, vba, web) --> read in gml with json_decode or json_parse

//Yup. If you absolutely want to work in CSV, it can be converted without problem.
//Not going to happen IN gm per-se (but could, tho more complex), but the conversion is quite easy.
//CSV To JSON Converter (convertcsv.com) 
// CONVERT : http://www.convertcsv.com/csv-to-json.htm

#endregion 

grid_csv = load_csv("stats.csv");

//////////////

player		= obj_player;
droplet		= obj_pnj_droplet;
seed		= obj_flore_parent;
splash		= obj_splash;

camera		= obj_c_camera;
gui			= obj_c_gui;


global.items		= 0;
global.item_array	= [];
found_weapon		= false;
monster_killed		= false;

can_activate_quest_zoom		= true;
can_activate_quest_fire		= true;
can_activate_quest_rage		= true;

alarm_end_text_can_be_set = true; //cf. hide_textbar_after_a_moment()

#region DEFINITION DES QUETES
	
	//Enum qui sert uniquement de référence visuelle (et pas de chiffres) pour mentionner les quêtes dans STEP.
	//Plusieurs quêtes peuvent êtres actives en même temps, alors l'enum ne sert qu'à définir des chiffres, et pas des states !
	//Attention : leur n° doit == à l'indice dans l'array ci dessous.
	enum QUEST 
	{
		MENU,				
		TUTO,				
		ABSORB_WATER,			
		ZOOM,					
		ARBORIST,							
		STOP_FIRE,					
		HYDRATE_PLANT,			
		RAGE,					
		BURN_THE_FORET,				
		FIND_RARE_PLANTS,			
		SAVE_LEAVES,			
	} 
	//quest = QUEST.PAINT;	//FACULTATIF : c'est juste pour draw le numéro de la quête (= enum)

	//pickup 10 waterpixels
	//Porter médouce vers une flaque d'eau
	
	//Array qui contient toutes  les quêtes
	quests_array = [ 
		[
			"MENU",
			0,
			["Pressed PLAY button", "The title appeared", "Camera moved to player", "UI --> HUD", "Move with WASD or the arrows"],
		],
		[
			//UN BLOC COMME CA ==> _i
			"Tuto",					//Nom de la quête 				==> _grid[# 0, _i]
			-1,						//Etat d'avancement...			==> _grid[# 1, _i]
									//...dans les sous-quêtes		==> _grid[# 2, _i][stage]
			["Move with the arrows", "Press [ENTER] to pause the game", "Resume with [ENTER] again", "Zoom with + and -", "Now explore ! But beware of dehydration !"],
			//La dernière sub-quest est simplement ce qui s'affiche à la fin à l'écran
		],
		[
			"Water Master",			
			-1,							
			["Find water", "Drink as much water as you can !", "Now, SPLASH with [SPACE]", "Great ! You can start watering things..."],
		],
		[
			"Zoom",			
			-1,							
			["Find the loupe", "Zoom with + and -", "Bravo !"],
		],
		[
			"Arborist",
			-1,
			["Find a seed", "Pickup a seed with [SHIFT]", "Sow a seed in the ground by pressing [SPACE]", "Water a baby plant by splashing it", "Hourra !"]
		],
		[
			"Fire",
			-1,
			["Witness a fire", "Stop a fire by splashing it with water !", "Stop a forest fire by splashing it", "Hourra !"]
		],
		[
			"Hydratation",
			-1,
			["Hydrate 10 plants", "Hydrate 100 plants", "Hydrate at least 50% of the garden", "Rehydrate a burnt plant", "Rehydrate 100 burnt plants", "Yeah ! Witness a fire now !"]
		],
		[
			"Become enraged",
			-1,
			["Let yourself become enraged"],
		],
		[
			"Burn the forest",
			-1,
			["Let 100 forest plant burn", "Let 200 forest plant burn" ],
		],
		[
			"Find rare plants...",
			-1,
			["Find a Fire Lys", "Find a Wisp Voluta", "Thank you"],
		],
		[
			"Save NPCs Leaves",
			-1,
			["Find a little lost Leaf", "Talk to the Leaf", ":-)"],
		],
		
		
	/*	[	
			//UN BLOC COMME CA ==> _i
			"Paint",				//Nom de la quête 				==> _grid[# 0, _i]
			0,						//Etat d'avancement...			==> _grid[# 1, _i]
									//...dans les sous-quêtes		==> _grid[# 2, _i][stage]
			["Paint a tree in red", "Paint a tree in blue", "Paint an NPC in fuschia", "You've painted a lot of things !"],		
			//La dernière sub-quest est simplement ce qui s'affiche à la fin de l'écran
		],
		
		[
			"Kill Boss",									
			0,												
			["Find the special weapon", 
			"Find the Boss", 
			"Kill the Boss with the special weapon", 
			"Return talking to PNJ", 
			"You saved the village !"],
		],
		
	*/
	];

#endregion

#region CREATION DU TABLEAU

	//ds_quests = ds_grid_create( ... meilleure méthode ci-dessous avec un script
	ds_quests = create_ds_grid_from_array(quests_array);
	//il nous faut la taille de cette grille pour STEP, et on ne l'a pas fait dans le script
	ds_quests_number = ds_grid_height(ds_quests);

#endregion

//////TEST pour comparer les length de l'array / et tableau
array_quests_number = array_length(quests_array);

////TEST : NOMENCLATURE (ne servent pas dans le reste du code,
	// puisque les quêtes peuvent se superposer et ces variables sont déclarées dans STEP)
//	i = 0;
//	grid = ds_quests;
//	quest_name			= grid[# 0, i];					//Nom de la quête
//	quest_stage			= grid[# 1, i];					//Etat de la quête
//	quest_stage_nb		= array_length(grid[# 2, i]);	//Nombre de sous-quêtes
//	quest_stage_desc	= grid[# 2, i][quest_stage];	//Description de la sous-quête


////INITIALISER toutes les quêtes à INACTIVE (-1) au début
q = 0; repeat(array_length(quests_array))
{
	ds_quests[# 1, q] = -1;
	q++;
}


