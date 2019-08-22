/// @param matrix
/// @param r
/// @param c
var matrix = argument0, r = argument1, c = argument2;

if r < 0 or r >= len(matrix) {
    return noone
}
var tmp = matrix[r]
if c < 0 or c >= len(tmp) {
    return noone
}
return tmp[c]