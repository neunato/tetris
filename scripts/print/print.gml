/// @param value
/// @param ...
var value = argument[0];

var result = ""
for (var i=0; i<argument_count; i++) {
    result += (" " + string(argument[i]))
}
return show_debug_message(result)