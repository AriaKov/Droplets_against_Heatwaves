///@desc CONSTANT SPAWN + MOVE

//Effet oscillant <3
move_x = sin(0.0003 * current_time) * 0.5;
move_y = sin(0.0007 * current_time) * 0.5;

x += move_x;
y += move_y;


part_angle += 1.5;
var _part = instance_create_layer(x, y, layer, obj_to_spawn);
	_part.image_angle = part_angle;





