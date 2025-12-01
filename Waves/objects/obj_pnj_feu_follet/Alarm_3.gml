///@desc CREATE FIRE SPARK


repeat(irandom_range(1, 5))
{
	instance_create_layer(x, y, layer, obj_fire_particle);
}
alarm[3] = spark_latency;



