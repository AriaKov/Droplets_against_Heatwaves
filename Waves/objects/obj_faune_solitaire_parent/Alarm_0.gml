///@desc FOLLOW

////LES ANIMAUX SUIVENT LA SOURIS
//Jusqu'à un trigger (appuie sur Enter, approche d'un prédateur)
//if keyboard_check_pressed(vk_enter){	scr_fuir_player(); }

//Pour éviter l'effet "vibration paniquée" une fois la cible atteinte
//peut-être mettre un while la distance est plus grande que ? 
//non --> SOLUTION : https://manual.gamemaker.io/monthly/fr/Quick_Start_Guide/Movement_And_Controls.htm


var _predateur = collision_circle(x, y, ray_flyaway, predateurs, false, true);





/*
if FAUNA_SOLO_STATE.FREE
{
	//Vole aléatoirement OU est statique, posé au sol
	direction = random(30)-15; //aléatoire entre 0 et 30° mais -15° pour centrer sur l'origine
	speed = move_speed;
		
	if _predateur { state = OISEAU_SOLO_STATE.FLYAWAY;	}
}



