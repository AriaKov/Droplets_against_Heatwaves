///@desc 

//global.seeds est incrémenté dans le script à chaque graine récoltée (et inversement)

/*
if (keyboard_check_pressed(ord("A"))) { // Si la touche "A" est pressée
    var _index = ds_list_find_index(toutes_plantes, "Lys"); // Remplace "Lys" par le nom exact
    if (_index != -1) //Si la plante existe dans l'array
	{
		global.flore_grid[# 0, _index] += 1;
        var _current_quantity = global.flore_grid[# 0, _index]; //ds_grid_get(global.flore_grid, 0, _index);
        ds_grid_set(global.flore_grid, 0, _index, _current_quantity + 1); // Incrémente la quantité
    }
}






