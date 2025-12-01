/// @description EV_PERFORM FIRE

//if can_be_set_in_fire == false exit;
if (fire_state == FIRESTATE.BURNED) exit;

//sinon...
var _rt = 0.1; _rt = 0;	//Random Time
//alarm[5] = resistance_time + random_range(-_rand, _rand);
//alarm[5] = resistance_time;
//event_perform(ev_alarm, 5);
alarm_set(5, resistance_time + random_range(-_rt, _rt));

