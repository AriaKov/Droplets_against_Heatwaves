

//MANETTE SWITCH <3

#region SET UP INITIAL gamepads_settings_in_async_system()
	///@desc Ce bout de code doit être mis dans l'évent ASYNC SYSTEM de OBJ_GLOBAL.
	///@desc Il sert à mettre en place la manette / joystick / gamepad.
	///@desc Il faut avoir déclaré (global ou pas mais ici oui) : global.gamepads = []; qui va contenir toutes les manettes disponibles
	///@arg global.gamepads Array [] contenant toutes les manettes disponibles
	function gamepads_settings_in_async_system(argument)
	{
		//tuto : https://manual.gamemaker.io/lts/en/Quick_Start_Guide/Movement_And_Controls.htm
		var _gamepads_array = argument;
	
		if(async_load[? "event_type"] == "gamepad discovered")	//Connection du joystick et intégration dans l'array
		{
		    var _pad = async_load[? "pad_index"];
		    gamepad_set_axis_deadzone(_pad, 0.2);
		    array_push(_gamepads_array, _pad);
		}
		else if(async_load[? "event_type"] == "gamepad lost")	//Déconnection du joystick et suppr dans l'array
		{
		    var _pad = async_load[? "pad_index"];
		    var _index = array_get_index(_gamepads_array, _pad);
		    array_delete(_gamepads_array, _index, 1);
		}

		//When a gamepad is discovered, it adds its index to the array, and when it's lost,
		//its finds the gamepad index from the array and then deletes it.
		//Notice that in the above code we set the deadzone for the gamepad.
		//This is because analog sticks on different makes of gamepads will have different sensibility,
		//and sometimes they can be so sensitive that if you don't set a deadzone
		//then they can cause unwanted movement in your games.
		//So we set the deadzone to a value like 0.2 to tell GameMaker to ignore any gamepad stick values under that absolute value.
	}
	
#endregion


///@desc Retourne TRUE si au moins une manette est connectée.
function gamepad_exists()
{
	var _gamepad_exists = (array_length(global.gamepads) > 0);
	if _gamepad_exists	 //S'il y a un joystick connecté...
	{
		return true;
	}
	else return false;
}
								
								//toutes les fonctions suivantes dépendent de gamepad_exists().

///@desc Retourne le nombre de manettes connectées.
function gamepads_number()
{
	if gamepad_exists()	 //S'il y a un joystick connecté...
	{
		var _number = array_length(global.gamepads);
		return _number;
	}
}



///@desc Retourne TRUE si on a input CHECK_PRESSED, avec le keyboard (_input_key) ou une des MANETTES (_input_gp). 
///@desc Et dans ce cas, cette fonction vérifie que gamepad_exists() == true.
///@arg _input_key Input qu'on veut checker pour le KEYBOARD. Défaut : global.key_pause
///@arg _input_gp Input qu'on veut checker pour le GAMEPAD. Défaut : global.gp_pause
///@arg {real} _numero_manette Numéro de la manette (0 si seule, 1, 2...). ALL = false, undefined, -1.  (Défaut : 0)
///@arg _gamepads_array Array qui contient les manettes disponibles. (Défaut : global.gamepads)
function input_keyboard_or_gamepad_check_pressed(_input_key = undefined, _input_gp = undefined, _numero_manette = 0, _gamepads_array = global.gamepads)
{	
	if (_input_key != undefined)	//Si undefined, c'est qu'on cherchait juste l'autre type d'input (manette)
	{
		if(keyboard_check_pressed(_input_key) == true)
		{
		///	show_debug_message("[SCRIPT] input_keyboard_or_gamepad_check_pressed() : KEYBOARD CHECK PRESSED --> TRUE");
			return true;
		}
	}
	
	if (_input_gp != undefined)	//Si undefined, c'est qu'on cherchait juste l'autre type d'input (clavier)
	{
		if(gamepad_exists() == true)
		{
			if (_numero_manette == -1 || _numero_manette == undefined || _numero_manette == false) //Signifie que toutes les manettes sont concernées en même temps
			{
				//Checker toutes les manettes
				var _num = 0;
				repeat(gamepads_number())
				{	
					if gamepad_button_check_pressed(_gamepads_array[_num], _input_gp) //Chaque manette
					{
					//	show_debug_message("[SCRIPT] input_keyboard_or_gamepad_check_pressed() : GAMEPAD CHECK PRESSED --> TRUE");
						return true;
					}
					_num++;
				}
			}
			else //Une manette spécifique
			{
				if gamepad_button_check_pressed(_gamepads_array[_numero_manette], _input_gp)
				{
				//	show_debug_message("[SCRIPT] input_keyboard_or_gamepad_check_pressed() : GAMEPAD CHECK PRESSED --> TRUE");
					return true;
				}
			}
		}
	}
	else 
	{
	//	show_debug_message("[SCRIPT] input_keyboard_or_gamepad_check_pressed() : AUCUN INPUT --> FALSE");
		return false; 
	}
	
}

//fonctions identiques sauf ce détail : CHECK_PRESSED or juste CHECK

///@desc Retourne TRUE si on a input CHECK, avec le keyboard (_input_key) ou une des MANETTES (_input_gp). 
///@desc Et dans ce cas, cette fonction vérifie que gamepad_exists() == true.
///@arg _input_key Input qu'on veut checker pour le KEYBOARD. Défaut : global.key_pause
///@arg _input_gp Input qu'on veut checker pour le GAMEPAD. Défaut : global.gp_pause
///@arg {real} _numero_manette Numéro de la manette (0 si seule, 1, 2...). ALL = false, undefined, -1. (Défaut : 0)
///@arg _gamepads_array Array qui contient les manettes disponibles. (Défaut : global.gamepads)
function input_keyboard_or_gamepad_check(_input_key = undefined, _input_gp = undefined, _numero_manette = 0, _gamepads_array = global.gamepads)
{	
	if(_input_key != undefined)	//Si undefined, c'est qu'on cherchait juste l'autre type d'input (manette)
	{
		if(keyboard_check(_input_key) == true)
		{
		//	show_debug_message("[SCRIPT] input_keyboard_or_gamepad_check() : KEYB CHECK PRESSED --> TRUE");
			return true;
		}
	}
	
	if(_input_gp != undefined)	//Si undefined, c'est qu'on cherchait juste l'autre type d'input (clavier)
	{
		if(gamepad_exists() == true)
		{
			if(_numero_manette == -1 || _numero_manette == undefined || _numero_manette == false) //Signifie que toutes les manettes sont concernées en même temps
			{
				//Checker toutes les manettes
				var _num = 0;
				repeat(gamepads_number())
				{	
					if(gamepad_button_check_pressed(_gamepads_array[_num], _input_gp) == true) //Chaque manette
					{
					//	show_debug_message("[SCRIPT] input_keyboard_or_gamepad_check() : GAMEPAD CHECK PRESSED --> TRUE");
						return true;
					}
					_num++;
				}
			}
			
			/*
			if gamepad_button_check(_gamepads_array[_numero_manette], _input_gp)
			{
				show_debug_message("[SCRIPT] input_keyboard_or_gamepad_check() : input_keyboard_or_gamepad_check() GAMEP CHECK PRESSED --> TRUE");
				return true;
			}*/
		}
	}
	else 
	{
	//	show_debug_message("[SCRIPT] input_keyboard_or_gamepad_check() : AUCUN INPUT --> FALSE");
		return false; 
	}
	
}





///@desc Vibration avec le gamepad (manette). Left, Right ou les deux en même temps. 
///@desc Cette fonction vérifie si le gamepad existe avant de s'excécuter.
///@desc (Si on ne met qu'une seule intensité, il s'agit de la même pour les deux côtés.)
///@arg {real} _numero_manette Numéro de la manette (0 si seule, 1, 2...) ALL = false, undefined, -1. (Défaut : 0)
///@arg {real} _l_amount Intensité de vibration LEFT, de 0 à 1. (ou pour les deux côtés) (Défaut : 0.1)
///@arg {real} _r_amount Intensité de vibration RIGHT, de 0 à 1. (Défaut : _l_amount)
///@arg {real} _time	Durée en frames (déclenche une alarme). (Défaut : 30)
///@arg {real} _alarm	Numéro de l'alarme qui déclenchera la fin de la vibration (Défaut: 11)
function gamepad_vibration_on(_numero_manette = 0, _l_amount = 0.1, _r_amount = _l_amount, _time = 30, _alarm = 11)
{
	if(global.vibrations == false){ exit; }
	if(gamepad_exists() == true)	 //S'il y a un joystick connecté...
	{
		gamepad_set_vibration(_numero_manette, _l_amount, _r_amount);
		
		alarm[_alarm] = _time; //Devra contenir gamepad_vibration_off();
	}
}


///@desc FIN de toutes les vibrations avec le gamepad (manette). 
///@desc Cette fonction vérifie si le gamepad existe avant de s'excécuter.
///@arg {real} _numero_manette Numéro de la manette (0 si seule, 1, 2...) (false, undefined, -1 si ALL). (Défaut : 0)
function gamepad_vibrations_off(_numero_manette = 0)
{
	if(global.vibrations == false){ exit; }
	if(gamepad_exists() == true)	 //S'il y a un joystick connecté...
	{
		if((_numero_manette == -1) || (_numero_manette == undefined) || (_numero_manette == false)) //Signifie que toutes les manettes sont concernées en même temps
		{
			//Checker toutes les manettes
			var _num = 0;
			repeat(gamepads_number())
			{	
				gamepad_set_vibration(_num, 0, 0); //Chaque manette
				_num++;
			}
		}
			
		else { 	gamepad_set_vibration(_numero_manette, 0, 0);	}
	}
}


