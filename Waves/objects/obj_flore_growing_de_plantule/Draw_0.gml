///@desc DEBUG

draw_self();

if(global.debug == false) exit;

var _x		= x;
var _y		= y + 4;
var _sep	= cell*0.75;
var _w		= 1000;
var _scale	= 1;
var _i		= 0;
	
draw_set_color(c_blue);
draw_set_font(fnt_body);
draw_set_alpha(0.6);


//draw_text_ext_transformed(_x, _y + (_i * _sep), string(sprite_normal), _sep, _w, _scale, _scale, 0); _i++;
//draw_text_ext_transformed(_x, _y + (_i * _sep), string(sprite_burning), _sep, _w, _scale, _scale, 0); _i++;
//draw_text_ext_transformed(_x, _y + (_i * _sep), +string(sprite_index), _sep, _w, _scale, _scale, 0); _i++;

//if can_propagate_seed { draw_text_ext_transformed(_x, _y + (_i * _sep), "<3", _sep, _w, _scale, _scale, 0); _i++; }
//draw_text_ext_transformed(_x, _y + (_i * _sep), string(rd), _sep, _w, _scale, _scale, 0); _i++;

//draw_text_ext_transformed(_x, _y + (_i * _sep), "(" +string(plant_size) + ") "+ string(object_get_name(object_index)), _sep, _w, _scale, _scale, 0); _i++;
//draw_text_ext_transformed(_x, _y + (_i * _sep), "(" +string(plant_size) + ") "+ string(plant_name), _sep, _w, _scale, _scale, 0); _i++;
draw_text_ext_transformed(_x, _y + (_i * _sep), "FST : "+string(firestate) + " (" +string(fire_state) +"/"+string(fire_state_max)+")", _sep, _w, _scale, _scale, 0); _i++;

draw_text_ext_transformed(_x, _y + (_i * _sep), "ST  : "+string(state) + " (stage : "+string(stage) +"/"+string(image_number-1)+")", _sep, _w, _scale, _scale, 0); _i++;
//draw_text_ext_transformed(_x, _y + (_i * _sep), "days : "+string(days_in_stage) + "/" + string(duration_stage), _sep, _w, _scale, _scale, 0); _i++;
//draw_text_ext_transformed(_x, _y + (_i * _sep), "stage : "+string(stage) +"/"+string(image_number-1), _sep, _w, _scale, _scale, 0); _i++;
//draw_text_ext_transformed(_x, _y + (_i * _sep), "age : "+string(age)+"/"+string(age_max), _sep, _w, _scale, _scale, 0); _i++;
//draw_text_ext_transformed(_x, _y + (_i * _sep), "SEED RAY : "+string(seed_ray)+" NUM : "+string(seed_num)+" P : "+string(seed_proba), _sep, _w, _scale, _scale, 0); _i++;

draw_set_color(green);
draw_set_alpha(0.5);
//draw_circle(x, y, seed_ray, true);

draw_set_alpha(1);


