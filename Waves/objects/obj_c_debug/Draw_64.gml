///@desc INFOS

	draw_set_font(fnt_body);
	draw_set_color(c_ltgray);
	draw_set_alpha(1);
	draw_set_align();
		
	var _s		= 2;
		
	var _sep	= 32;
	var _x		= 16;
	var _y		= 64;
	var _i		= 0;

	//draw_text(_x, _y + 16, string(global.flore_dead));


	var _mx = mx;
	var _my = my;
	
	_x = _mx;
	_y = _my;
	
//	if(instance_exists(obj_c_music) == true){ with(obj_c_music) {
//	_i++;
//	draw_text_transformed(_x, _y + (_i * _sep), "audio_is_playing(music_rage) : " + string(audio_is_playing(music_rage)), _s, _s, 0);	_i++;
//	draw_text_transformed(_x, _y + (_i * _sep), "music_rage_pitch : " + string(music_rage_pitch), _s, _s, 0);	_i++;
//	draw_text_transformed(_x, _y + (_i * _sep), "can_play_rage_music : " + string(can_play_rage_music), _s, _s, 0);	_i++;
//	}}

if(global.debug == true)
{	

	
	//	if(instance_exists(obj_pnj_droplet)) { with(obj_pnj_droplet) {
	//	draw_text_transformed(_mx, _my + (_sep * _i), "drop_y_per : " + string(drop_y_per), _s, _s, 0);	_i++;
	//	draw_text_transformed(_mx, _my + (_sep * _i), "drop_y_amp : " + string(drop_y_amp), _s, _s, 0);	_i++;
	//	}}
		
		draw_text_transformed(_x, _y + (_i * _sep), string(global.time_acceleration), _s, _s, 0);	_i++;
		draw_text_transformed(_x, _y + (_i * _sep), string(room_get_name(room)), _s, _s, 0);	_i++;

		if(instance_exists(obj_c_music)) {
		//	draw_text_transformed(_x, _y + (_i * _sep), "normal : " + string(obj_c_music.music_normal_gain), _s, _s, 0);	_i++;
		//	draw_text_transformed(_x, _y + (_i * _sep), "rage : " + string(obj_c_music.music_rage_gain), _s, _s, 0);	_i++;

			_i++;
		}
		
		if(instance_exists(obj_c_gui)) {
			draw_text_transformed(_x, _y + (_i * _sep), "UI." + string(obj_c_gui.state_str), _s, _s, 0);	_i++;
	//		draw_text_transformed(_x, _y + (_i * _sep), "text : " + string(obj_c_gui.text), _s, _s, 0);	_i++;
			_i++;
		}
		if(instance_exists(obj_c_camera)) { with(obj_c_camera) {
			draw_text_transformed(_x, _y + (_i * _sep), "CAMMODE." + string(mode), _s, _s, 0);	_i++;
			draw_text_transformed(_x, _y + (_i * _sep), "cx, cy = " + string(cx) + ", " + string(cy), _s, _s, 0);	_i++;
	//		draw_text_transformed(_x, _y + (_i * _sep), "target = " + string((target_x - (view_w/2))) + ", " + string((target_y - (view_h/2))), _s, _s, 0);	_i++;
	//		draw_text_transformed(_x, _y + (_i * _sep), "dist_x, y = " + string((target_x - (view_w/2))) + ", " + string((target_y - (view_h/2))), _s, _s, 0);	_i++;
	//		draw_text_transformed(_x, _y + (_i * _sep), "dist = " + string(dist), _s, _s, 0);	_i++;
	//		draw_text_transformed(_x, _y + (_i * _sep), "shake_camera = " + string(shake_camera), _s, _s, 0);	_i++;
			_i++;
		}}
		
		draw_text_transformed(_x, _y + (_i * _sep), "g.game_speed : " + string(global.game_speed), _s, _s, 0);	_i++;
		draw_text_transformed(_x, _y + (_i * _sep), "g.time_speed : " + string(global.time_speed), _s, _s, 0);	_i++;
		_i++;
		
		if(instance_exists(obj_c_cycle_day_night)) { with(obj_c_cycle_day_night) {
			draw_text_transformed(_x, _y + (_i * _sep), "time_increment : " + string(time_increment), _s, _s, 0);	_i++;
	//		draw_text_transformed(_x, _y + (_i * _sep), "real_duration_of_a_day : " + string(duration_of_a_day_in_sec) + " sec, " + string(duration_of_a_day_in_min) + " min, " + string(duration_of_a_day_in_h) + " heures", _s, _s, 0);	_i++;
	//		draw_text_transformed(_x, _y + (_i * _sep), "hours : " + string(hours), _s, _s, 0);	_i++;
			draw_text_transformed(_x, _y + (_i * _sep), string(phase), _s, _s, 0);	_i++;
	//		draw_text_transformed(_x, _y + (_i * _sep), "can_set_event_midday : " + string(can_set_event_midday), _s, _s, 0);	_i++;
	//		draw_text_transformed(_mx, _my + (_sep * _i), "(1 jour = " + string(duration_of_a_day_in_min) + " min)", _s, _s, 0);	_i++;
			draw_text_transformed(_mx, _my + (_sep * _i), "day : " + string(day), _s, _s, 0);	_i++;
			_i++;
		}}
		if(instance_exists(obj_c_meteo)) { with(obj_c_meteo) {
	//		draw_text_transformed(_x, _y + (_i * _sep), "meteo_brume : " + string(meteo_brume), _s, _s, 0);	_i++;
	//		draw_text_transformed(_x, _y + (_i * _sep), "alpha_brume : " + string(alpha_brume), _s, _s, 0);	_i++;
	//		draw_text_transformed(_x, _y + (_i * _sep), "can_set_event_fire : " + string(can_set_event_fire), _s, _s, 0);	_i++;
	//		_i++;
		}}

		draw_text_transformed(_x, _y + (_sep * _i), "FLORE : " + string(instance_number(obj_flore_parent)), _s, _s, 0);	_i++;
		draw_text_transformed(_x, _y + (_sep * _i), "FAUNE : " + string(instance_number(obj_faune_solitaire_parent)), _s, _s, 0);	_i++;
	//	draw_text_transformed(_x, _y + (_i * _sep), "   fox : " + string(nb_fox), _s, _s, 0);	_i++;
	//	draw_text_transformed(_x, _y + (_i * _sep), "   bear : " + string(nb_ourson), _s, _s, 0);	_i++;
	//	draw_text_transformed(_x, _y + (_i * _sep), "   bird : " + string(nb_bird), _s, _s, 0);	_i++;
	//	draw_text_transformed(_x, _y + (_i * _sep), "   bfly : " + string(nb_butterfly), _s, _s, 0);	_i++;
		draw_text_transformed(_x, _y + (_sep * _i), "FLAMECHE : " + string(instance_number(obj_pnj_feu_follet)), _s, _s, 0);	_i++;
		_i++;
		
		draw_text_transformed(_x, _y + (_i * _sep), "FIRES : " + string(global.fires_number) + " (stopped : " + string(global.fires_stopped) + ")", _s, _s, 0);	_i++;
		draw_text_transformed(_x, _y + (_i * _sep), "plants_hydrated_by_splash : " + string(global.plants_hydrated_by_splash), _s, _s, 0);	_i++;
		
		_i++;


	//	draw_text_transformed(_x, _y + (_i * _sep), "p l a y e r : " + string(instance_number(player)), _s, _s, 0);	_i++;
		draw_text_transformed(_mx, _my + (_i * _sep), "g.humidity : " + string(ceil(global.humidity)), _s, _s, 0);	_i++;
		if(instance_exists(player)) with(player) {
		{
		//	draw_text_transformed(_x, _y + (_i * _sep), "can_move : " + string(can_move), _s, _s, 0);	_i++;
		//	draw_text_transformed(_x, _y + (_i * _sep), "evaporation_spd : " + string(evaporation_speed), _s, _s, 0);	_i++;
			draw_text_transformed(_mx, _my + (_i * _sep), "humidity : " + string(ceil(humidity)), _s, _s, 0);	_i++;
			draw_text_transformed(_mx, _my + (_i * _sep), "fires... " + string(num_of_fire_simultaneously_burning_player), _s, _s, 0);	_i++;
			draw_text_transformed(_mx, _my + (_i * _sep), "fires... " + string(array_last(num_of_fire_simultaneously_burning_player)), _s, _s, 0);	_i++;
		//	draw_text_transformed(mx, my + (_sep), "traces : " + string(nb_traces), _s, _s, 0);	_i++;
			_i++;
		}}
		
}






