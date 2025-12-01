///@desc ACTIVATE QUESTS

var _grid = ds_quests;

with(obj_c_gui){ text = ""; }	//init


if(room == rm_start)
{
	activate_new_quest(_grid, QUEST.MENU);	//FIRST QUEST = CINEMATIC
	activate_new_quest(_grid, QUEST.ABSORB_WATER);
}






