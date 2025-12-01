///@desc FREE : CHANGE DIR

//Probabilité qu'il reste immobile > proba qu'il bouge
//Si est immobile...
	//proba qu'il bouge
//Si bouge déjà...
	//proba qu'il reste en mouvement

var _r = irandom(10);
var _proba_idle = 5;	//se pose ou reste posé (si déjà idle)
var _proba_move = 5;	//vole ou reste en vol (si déjà move)
	
if(moving == true)	
{
	_proba_idle = 5;	//A 1 chance sur 2 de se poser
	_proba_move = 8;
}
else if(moving == false)	
{
	_proba_idle = 8;	//A + de chance de rester idle s'il l'est 
	_proba_move = 5;
}
if(_r <= _proba_idle)	//Alors reste ou devient idle
{
	speed		= move_speed;
	var _range	= 12; //360;	//45;
	//_range est le petit changement de direction de l'oiseau.
	//Dans le cas de groupe d'oiseau, le groupe possède une direction propre, que chaque oiseau additionne à son random _range.
	direction += random_range(-_range, _range);	
	move_x = lengthdir_x(speed, direction);
	move_y = lengthdir_y(speed, direction);
	
	moving = true;
}


/* //Anciennement
speed = choose(0, move_speed);	//Une chance sur 2 de s'arrêter
var _range = 12; //360;	//45;
//_range est le petit changement de direction de l'oiseau.
//Dans le cas de groupe d'oiseau, le groupe possède une direction propre, que chaque oiseau additionne à son random _range.
direction += random_range(-_range, _range);
*/

can_change_direction = true;
	
