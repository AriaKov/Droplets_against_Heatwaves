///@desc Midday : Fire

/* // Dans obj_c_meteo, qui contrôle également d'autres types d'évents liés au cycle jour/nuit.
var _x, _y;
if(instance_exists(obj_player))	{	_x = obj_player.x;	_y = obj_player.y; }
else							{	_x = 200;			_y = 300; }

instance_create_layer(_x, _y, "Instances", obj_faune_ourson);

can_set_event_midday = false;



