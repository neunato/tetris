/// @param matrix
/// @param dir
var matrix = argument0, dir = argument1;

var n = len(matrix) - 1
var result = array_create(n + 1)
for (var r=n; r>=0; r--) {
    result[r] = array_create(n + 1)
}

if dir == 1 {
    for (var r=n; r>=0; r--) {
        for (var c=n; c>=0; c--) {
            set(result, c, n - r, get(matrix, r, c))
        }
    }
}

else if dir == -1 {
    for (var r=n; r>=0; r--) {
        for (var c=n; c>=0; c--) {
            set(result, n - c, r, get(matrix, r, c))
        }
    }
}

return result