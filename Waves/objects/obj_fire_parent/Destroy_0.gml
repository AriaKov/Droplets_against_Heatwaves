///@desc SMOKE

global.fires_stopped++;

instance_create_layer(x, y, layer, obj_effect_sparkle);

global.fires_number--;
global.fires_stopped++;
