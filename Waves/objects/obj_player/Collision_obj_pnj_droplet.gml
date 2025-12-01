///@desc HUMIDITY--

//If Player is in Rage, it can dehydrate NPC Droplets
var _npc = other;
if(water_state == PLAYER_HUMIDITY.RAGE)
{
	with(_npc)
	{
		burning();	
	}	
}