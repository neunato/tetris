/// @param array
/// @param value
var array = argument0, value = argument1;

n = len(array)
for (var i=0; i<n; i++) {
    if array[i] == value {
        return true
    }
}

return false