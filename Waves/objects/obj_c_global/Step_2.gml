///@desc NO DEPTH SYSTEM

//Simple
//with(all) { depth = -bbox_bottom; }

//Elaboré, pour intégrer les jumps
//with(obj_vfx_parent_of_objects_3d) { depth = -bbox_bottom + z*2; }
with(obj_vfx_parent_of_objects_3d) { depth = -bbox_bottom; }
