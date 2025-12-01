///@desc MOVE

//Effet oscillant <3
//move_x += sin(0.0003 * current_time) * 0.5;


//move_y += global.gravite/4;
move_y += global.gravite/5;

x += move_x; 
y += move_y;


//Diminution de l'alpha
image_alpha -= alpha_decay;
if(image_alpha <= 0){ instance_destroy(); }


