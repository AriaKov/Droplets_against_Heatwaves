///@desc

//	if(global.pause == false) exit;


if(storage_by_grid == true)
{
	grid = global.grid_seeds;

	#region AFFICHAGE DU TABLEAU DES CARACTERISTIQUES DE TOUTES LES PLANTES

		var _x		= cell/2;
		var _y		= cell*8;
		var _sc		= 1;
		var _sep	= cell;
		var _w		= 1000;
		var _i		= 0;
		var _s		= 1;
	
		draw_set_color(c_blue);
		draw_set_alpha(0.5);
		//draw_rectangle(_x - cell, _y - cell, _x + cell*6, _y + cell*6 + _sep, false);
		draw_set_alpha(1);
	
		//draw_sprite(spr_coeur_receptacle, grid_flore[# 0, 0], _x, _y + _sep * _i); _i++;
		//draw_sprite(spr_coeur_receptacle, grid_flore[# 0, 1], _x, _y + _sep * _i); _i++;
		//draw_sprite(spr_coeur_receptacle, grid_flore[# 0, 2], _x, _y + _sep * _i); _i++;
		//draw_sprite(spr_coeur_receptacle, grid_flore[# 0, 3], _x, _y + _sep * _i); _i++;
		//Pour info, coeurs_grid[# 0, 0] peut être remplacé par l'inesthétique : ds_grid_get(coeurs_grid, 0, 0)

		draw_set_align();
	
		//SPR BOUTON
		draw_sprite_stretched(spr_ui_button_16_64, 0, _x - cell/2 - cell*2, _y - cell/2, cell*7 + cell*2, cell*grid_h + cell);
	
	
		var _object, _name, _sprite, _quantity; 

		//repeat(grid_h)
		for(var _p = 0; _p < grid_h; _p++)
		{
			_object		= global.grid_seeds[# yy_object, _p];
			_name		= string(global.grid_seeds[# yy_plant_name, _p]);
			_quantity	= floor(global.grid_seeds[# yy_quantity, _p]);
			_sprite		= global.grid_seeds[# yy_sprite, _p]; 
		
			draw_text_ext_transformed(_x, _y + (_sep * _i), string(_quantity) + " " + string(_name) + ", " + string(_object), _sep, _w, _s, _s, 0);	_i++;
		//	draw_sprite_ext(_sprite, 1, _x, _y, _s, _s, 0, c_white, 1);
		}


	/*
	
		var _c = 0; var _l = 0;
		//var ds_plants = global.grid_plants;
	
		repeat(grid_h)	//YOUPI CA MARCHE :-))))
		{
		
			//SEED SPRITES WITH SPR_SEEDS (toutes les graines dans un seul sprite, le numéro de ligne de la plante == image_index)
				//seed_sprite = asset_get_index(ds_plants[# 4, _l]);	//à priori c'est spr_seeds partout. Mais bon.
				seed_sprite = spr_seeds;
				image = ds_plants[# 0, _l];	//sprite image == numéro de la plante, car les images sont classées dans le même ordre.
				//show_debug_message("SEED SPRITE : " + string(seed_sprite) + "  image : " + string(image));
		
				var _sca = 1;
				var _centrage_spr = 8; _centrage_spr = 0;
		
			draw_sprite_ext(spr_seeds, image, _x + _centrage_spr, _y + _centrage_spr + (_l * _sep), _sca, _sca, 0, c_white, 1);
		
		
			draw_text_transformed(_x + cell, _y + _sep * _l,
				string(ds_plants[# 0, _l])		 	//quantity
				 +" "+ string(ds_plants[# 1, _l])	//name
				// +" "+ string(ds_plants[# 2, _l])	//plant_size
				// +" "+ string(ds_plants[# 3, _l])	//description
				// +" "+ string(ds_plants[# 4, _l])	//sprite
				, _sc, _sc, 0);
			
				_l++;	//Incrémente numéro de la plante et ligne
		}
	
	
		/*
		var _c = 0; var _l = 0;
		draw_text_transformed(_x, _y + _sep * _i, string(global.seeds[# 0, _l]) +" "+ string(global.seeds[# 1, _l]), _sc, _sc, 0); _l++; _i++;
		draw_text_transformed(_x, _y + _sep * _i, string(global.seeds[# 0, _l]) +" "+ string(global.seeds[# 1, _l]), _sc, _sc, 0); _l++; _i++;
		draw_text_transformed(_x, _y + _sep * _i, string(global.seeds[# 0, _l]) +" "+ string(global.seeds[# 1, _l]), _sc, _sc, 0); _l++; _i++;
		draw_text_transformed(_x, _y + _sep * _i, string(global.seeds[# 0, _l]) +" "+ string(global.seeds[# 1, _l]), _sc, _sc, 0); _l++; _i++;
		*/
		//draw_text_transformed(_x + _sep, _y + _sep * _i, "found : " + string(grid_flore[# 1, 0]), _sc, _sc, 0); _i++;
		//draw_text_transformed(_x + _sep, _y + _sep * _i, "found : " + string(grid_flore[# 1, 1]), _sc, _sc, 0); _i++;
		//draw_text_transformed(_x + _sep, _y + _sep * _i, "found : " + string(grid_flore[# 1, 2]), _sc, _sc, 0); _i++;
		//draw_text_transformed(_x + _sep, _y + _sep * _i, "found : " + string(grid_flore[# 1, 3]), _sc, _sc, 0); _i++;

		draw_set_align();

	#endregion

}

