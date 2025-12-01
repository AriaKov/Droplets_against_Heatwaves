///@desc



can_break		= true;
break_latency	= 1 * global.game_speed;

image_speed		= 0;

break_level_max	= image_number - 1;
break_level		= 0;
image_index		= break_level;

image_xscale	= choose(-1, 1);
image_blend		= merge_color(COL.WHITE, COL.BLACK, 0.5 + random(0.1));

