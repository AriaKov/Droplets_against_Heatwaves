///@desc FADE OUT - Controlé par Player

if(fade_out == true){ fade_out_active	= true; }	//Activer le fade out (STEP, DGUI)

else				
{ 
	if(room_exists(target_room) == true){ room_goto(target_room); }		//Tout de suite aller à la target room
}
