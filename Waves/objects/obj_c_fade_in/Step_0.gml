///@desc ALPHA--


alpha -= alpha_decay;


if(alpha <= alpha_min)
{
	instance_destroy();
}


