///@desc FLOAT + MOVE

// Inherit the parent event
event_inherited();

//y -= 0.1;
y += move_y;

floatting_sinusoidal_x(self, self, 0.01 + rand_per, 0.51 + rand_amp);



