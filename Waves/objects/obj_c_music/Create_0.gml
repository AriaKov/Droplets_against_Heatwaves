///@desc MUSIC

if(active == false) instance_destroy();

player	= obj_player;


#region SOUNDS

	#region PLAYER
	
	//Player footsteps
	//	sound_footstep_normal	= snd_chute_pierre_1022_01;
	//	sound_footstep_gain		= random_range(0.1, 0.15);
	//	sound_footstep_pitch	= random_range(0.8, 1.2);
		sounds_footstep_normal	= [
		//	snd_90_footsteps_mud_female_001,
			snd_90_footsteps_mud_female_002,
			snd_90_footsteps_mud_female_003,
			snd_90_footsteps_mud_female_004,
			snd_90_footsteps_mud_female_005,
			snd_90_footsteps_mud_female_006,
		//	snd_90_footsteps_mud_female_007,
			snd_90_footsteps_mud_female_008,
			snd_90_footsteps_mud_female_009,
		//	snd_90_footsteps_mud_female_010,
			snd_90_footsteps_mud_female_011,
			snd_90_footsteps_mud_female_012,
			snd_90_footsteps_mud_female_013,
		//	snd_90_footsteps_mud_female_014,
			snd_90_footsteps_mud_female_015,
			snd_90_footsteps_mud_female_016,
			snd_90_footsteps_mud_female_017,
			snd_90_footsteps_mud_female_018,
			snd_90_footsteps_mud_female_019,
			snd_90_footsteps_mud_female_020,
		]
		s = irandom(array_length(sounds_footstep_normal) - 1);
		sound_footstep_normal	= sounds_footstep_normal[s];
		sound_footstep_rage		= snd_wine_glass_break;	
		sound_footstep_rage		= snd_wood_crack_02;
		sound_footstep			= sound_footstep_normal;
		sound_footstep_gain		= random_range(0.2, 0.3);
		sound_footstep_pitch	= random_range(0.8, 1.2);

	//Player drink water
	//	sound_drink				= snd_swirl_01;
		sound_drink				= snd_aspirar;
		sound_drink_gain		= 0.2;
		sound_drink_pitch		= 0.8;
	
	//Player makes a splash !
		sound_splash			= snd_splash_piste_82_002;
		sound_splash_gain		= random_range(0.1, 0.2);
		sound_splash_pitch		= random_range(0.8, 1.2);
		
	//Player hit
		sound_hit				= snd_wine_glass_break;
	
	#endregion
	
	//Flameche
		sound_flame_appears		= "";
		
	//Fire
	//	sound_fire				= snd_fire;
		sound_fire_soft			= snd_fire_sounds_soft;
		sound_fire_medium		= snd_fire_sounds_medium;
		sound_fire_strong		= snd_fire_sounds_strong;
		sound_fire				= sound_fire_soft;
		sound_fire_gain			= 0.5;
		sound_fire_pitch		= 1;
		
	//Water evaporates
		sound_evaporation		= snd_water_drip_01;
		sound_evaporation		= snd_plastic_roll_01;
		sound_evaporation_gain	= random_range(0.1, 0.2);
		sound_evaporation_pitch = random_range(0.8, 1.2);
	
	//Player dehydratation (DRY state)
		sound_player_dehydration			= snd_vege_leaf_roseau_de_chine_1__ID_1811__LS;
		sound_player_dehydration_gain		= random_range(0.05, 0.1);
		sound_player_dehydration_pitch		= random_range(0.8, 1.2);
		
	//NPC Droplet become FIRE
		sounds_droplet_transform	= [
			snd_umbrella_open_01, 
			snd_umbrella_open_02,
			snd_umbrella_open_03
			];
		s = irandom(array_length(sounds_droplet_transform) - 1);
		sound_droplet_transform		= sounds_droplet_transform[s];
	
	//NPC Fire become DROPLET
		sounds_feufollet_transform	= [
			snd_splash_piste_82_001, 
			snd_splash_piste_82_002,
			];
		s = irandom(array_length(sounds_feufollet_transform) - 1);
		sound_feufollet_transform	= sounds_feufollet_transform[s];
	
	//Wood crack (player breaks flore)
		sounds_wood_crack = [
			//snd_wood_crack_01, 
			snd_wood_crack_02, snd_wood_crack_03];
		s = irandom(array_length(sounds_wood_crack) - 1);
		sound_wood_crack		= sounds_wood_crack[s];
		sound_wood_crack_gain	= random_range(0.1, 0.2);
		sound_wood_crack_pitch	= random_range(0.8, 1.2);
	
	//Rock crack
		sounds_rock_crack = [
			snd_chute_pierre_1022_01,
			snd_chute_pierre_1022_02,
			snd_chute_pierre_1022_03,
			snd_chute_pierre_1022_04,
			snd_chute_pierre_1022_05,
			snd_chute_pierre_1022_06,
			snd_chute_pierre_1022_07,
			snd_chute_pierre_1022_08,
			snd_chute_pierre_1022_09,
			snd_chute_pierre_1022_10,
			snd_chute_pierre_1022_11,
			snd_chute_pierre_1022_12,
			snd_chute_pierre_1022_13,
			snd_chute_pierre_1022_14,
			snd_chute_pierre_1022_15,
			snd_chute_pierre_1022_16,
			snd_chute_pierre_1022_17,
			snd_chute_pierre_1022_18,	
		];
		s = irandom(array_length(sounds_rock_crack) - 1);
		sound_rock_crack		= sounds_rock_crack[s];
		sound_rock_crack_gain	= random_range(0.3, 0.4);
		sound_rock_crack_pitch	= random_range(0.8, 1.2);
					
	
	//Natural ambient sounds
		sound_nature		= snd_ambforst_foret_et_ruisseau_3_id_2716;
		sound_nature_gain	= 0.3;
		sound_nature_pitch	= 1;
	
	
	//QUEST
		sound_quest_done	= snd_sample_logic_pro_korg_synth_nicesynthsoft;
		sound_quest_new		= snd_sample_logic_pro_korg_synth_nicesynthsoft;
		sound_quest_gain	= 0.1;
		sound_quest_pitch	= 1.5;
		
		
#endregion


#region MUSICS
	
	can_play_normal_music	= true;
	can_play_rage_music		= true;
	
	music_normal		= snd_music_frog;

	//For fade in and fade out
	gain_incr			= 0.01;
	//Lors d'un fondu la musique A disparait (gain-- jusqu'à 0) et la B apparait (gain++ de 0 à 1)
	music_a_gain		= 0;
	music_a_gain_wanted = 1;
	music_b_gain		= 0;
	music_b_gain_wanted = 0;

	gain_max			= 0.5;
	gain_min			= 0;
	fade_speed			= 4 * 100;	fade_speed			= 8 * 100;

	music_normal_gain_goal = 0.5 * global.music_volume;
	music_normal_gain	= music_normal_gain_goal;
	music_normal_pitch	= 1;
	
//Fairy Waltz
	music_fairy			= snd_music_fairy_waltz;
	music_fairy_gain	= 0.7;
	
//Rage
//	music_rage			= snd_music_epic_battle_cut_2;
//	music_rage			= snd_music_drumbo_cut_end;
	musics_rage = [snd_music_rage_alex_v1, snd_music_rage_alex_v2, snd_music_rage_alex_v3];
	s = irandom(array_length(musics_rage) - 1);
	music_rage = musics_rage[s];
	music_rage_gain		= 0 * global.music_volume;
	music_rage_pitch_normal	= 1.15;		music_rage_pitch_normal	= 1;
	music_rage_pitch_max	= 1.2;
	music_rage_pitch_min	= 0.5;
	music_rage_pitch		= music_rage_pitch_normal;

#endregion



