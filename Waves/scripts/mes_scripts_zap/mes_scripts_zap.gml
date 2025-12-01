/// @description zap_constant_move(x_from, y_from, x_to, y_to, N, amt);
/// @function circle_constant_move
/// @param x_from	/ x coordinate of the start point
/// @param y_from	/ y coordinate of the start point
/// @param x_to		/ x coordinate of the end point
/// @param y_to		/ y coordinate of the end point
/// @param N		/ Number of jumps
/// @param amt		/ The amount to interpolate
function zap_constant_move(argument0, argument1, argument2, argument3, argument4, argument5)
{
	/*
	    This script returns an array contaiing the x ccordinate and the y coordinate of the interpolated point 

	    argument0 : x coordinate of the start point
	    argument1 : y coordinate of the start point
	    argument2 : x coordinate of the end point
	    argument3 : y coordinate of the end point
	    argument5 : number of jumps
	    argument6 : the amount to interpolate
	*/

	var _x_from = argument0;
	var _y_from= argument1;
	var _x_to = argument2;
	var _y_to = argument3;
	var _n = argument4;
	var _amt = argument5;

	var _taux = _amt/100;
	var _dir = point_direction(_x_from, _y_from, _x_to, _y_to);
	var _total_distance = point_distance(_x_from, _y_from, _x_to, _y_to);
	var _piece_dist = _total_distance/_n;

	if (_total_distance != 0)
	{
		var _x_l = _total_distance * _taux;
		var _x_temp = _piece_dist * floor(_x_l/_piece_dist);
		var _y_temp = 0;

		coord[0] = _x_from + _x_temp * cos(degtorad(_dir)) - _y_temp * sin(degtorad(_dir));
		coord[1] = _y_from - _x_temp * sin(degtorad(_dir)) - _y_temp * cos(degtorad(_dir));
	}
	else
	{
		coord[0] = _x_from;
		coord[1] = _y_from;
	}
	
	return coord;
}
