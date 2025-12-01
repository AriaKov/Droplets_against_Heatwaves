///@desc DS DESTROY


if(storage_by_grid == true) exit;
if(ds_exists(global.grid_seeds, ds_type_grid) == true){ ds_grid_destroy(global.grid_seeds); }


