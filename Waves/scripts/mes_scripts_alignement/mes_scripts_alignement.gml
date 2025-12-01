

///@desc Raccourcis pour le setup des alignements. Si aucun argument n'est mis, c'est le reset (top-left)
///@arg {real} _horizontal	draw_set_halign -->  -1 (left),  0 (center),  1 (right)
///@arg {real} _vertical	draw_set_valign -->  -1 (top),  0 (middle),  1 (bottom)

function draw_set_align(_horizontal = -1, _vertical = -1)
{
	if (_horizontal = -1) { draw_set_halign(fa_left); }
	if (_horizontal = 0) { draw_set_halign(fa_center); }
	if (_horizontal = 1) { draw_set_halign(fa_right); }
	
	if (_vertical = -1) { draw_set_valign(fa_top); }
	if (_vertical = 0) { draw_set_valign(fa_middle); }
	if (_vertical = 1) { draw_set_valign(fa_bottom); }
	
	/*
	if (_horizontal = "left") { draw_set_halign(fa_left); }
	if (_horizontal = "center") { draw_set_halign(fa_center); }
	if (_horizontal = "right") { draw_set_halign(fa_right); }
	
	if (_vertical = "top") { draw_set_valign(fa_top); }
	if (_vertical = "middle") { draw_set_valign(fa_middle); }
	if (_vertical = "bottom") { draw_set_valign(fa_bottom); } */
}


