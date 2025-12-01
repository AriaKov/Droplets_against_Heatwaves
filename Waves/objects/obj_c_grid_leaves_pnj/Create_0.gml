///@desc 

//Player doit trouve 5 PNJ feuilles qui le suivent de cette manière : 
//Le premier pnj dans la liste suit player, le suivant suit le premier, etc. Ribambelle
//Si un pnj est manquant, le suivant prends sa place dans la file.
//Il faut une liste des PNJ trouvés
//Ou alors on les mets dans l'ordre de découverte ! C'est + horizontal :p

leaves = [	
	obj_pnj_leaf_bilobabil,
	obj_pnj_leaf_figuieta,
	obj_pnj_leaf_ligulio,
	obj_pnj_leaf_robur,
	obj_pnj_leaf_sepaline
	];

grid_w			= 2;
leaves_number	= array_length(leaves);
grid_h			= leaves_number - 1;
	
global.grid_pnj	= ds_grid_create(grid_w, grid_h);	

for(h = 0; h < grid_h; h++)	//Pour chaque ligne...
{
	global.grid_pnj[# 0, h] = leaves[h];	//Colonne 0 : le nom des obj pnj
	global.grid_pnj[# 1, h] = false;		//Colonne 1 : l'état found / or not
}

//Reprends tous les PNJ trouvés et le classe dans cet ordre
file_dattente = [];

//if contact > leaf found > ajout dans l'array à la fin
//if !contact > leaf lost > retrait de l'array > réorganisation des pnj
//mais on ne devrait avoir que le dernier qui se perd j'imagine.
//Si le 1 se perds, le 2 arrête de le suivre et est perdu aussi ?

//Ensuite chaque PNJ se verra attribuer un objet à suivre (player ou l'un des PNJ)
