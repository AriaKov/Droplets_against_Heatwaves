///@desc END OF BURNING

//humidity		= humidity_wet_min;
fire_state		= FIRE_STATE.BURNED;
can_start_burn	= true;	//Reinit						

global.fires_number--;
global.fires_stopped++;


/*
//if fire duration +++, death probability +++ (smaller number, to do 1/proba)
if(fire_duration <= 2){	death_probability = 100; }	//Lower chances of death
if(fire_duration > 10){	death_probability = 10; }	
if(fire_duration > 10){	death_probability = 2; }	


