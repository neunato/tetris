/// @param object
/// @param xx = 0
/// @param yy = 0
var object = argument[0];
var xx = argument_count > 1 ? argument[1] : 0;
var yy = argument_count > 2 ? argument[2] : 0;

gml_pragma("forceinline")

return instance_create_layer(xx, yy, "Instances", object)