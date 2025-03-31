extends Node2D

var maze_array = []
var maze_width = 35 # Both of these should be odd
var maze_height = 35

func _ready() -> void:
	_init_maze()
	_generate_maze(0, 0)
	
func _init_maze() -> void:
	for x in range(maze_width): # 0 = empty, 1 = wall
		maze_array.append([])
		for y in range(maze_height):
			maze_array[x].append(1)
			
	maze_array[round(maze_width / 2.0) ][round(maze_width / 2.0)] = 0
	maze_array[round(maze_width / 2.0)][round(maze_width / 2.0) + 1] = 0
	maze_array[round(maze_width / 2.0) + 1][round(maze_width / 2.0)] = 0
	maze_array[round(maze_width / 2.0) + 1][round(maze_width / 2.0) + 1] = 0

func _shuffle(array : Array) -> void:
	var rng = RandomNumberGenerator.new()
	for i in range(array.size() - 1, 0, -1):
		var swapIndex = rng.randi_range(0, i)
		var temp = array[swapIndex]
		array[swapIndex] = array[i]
		array[i] = temp

func _is_in_bounds(x: int, y : int) -> bool:
	return x >= 0 and x < maze_width and y >= 0 and y < maze_height
	
func _generate_maze(x : int, y : int) -> void:
	maze_array[x][y] = 0
	var directions = [ 0, 1, 2, 3 ]
	_shuffle(directions);

	for direction in directions:
		var nx = x
		var ny = y;

		match direction:
			0:
				nx = x + 2
			1:
				nx = x - 2
			2:
				ny = y + 2
			3:
				ny = y - 2
				
		if _is_in_bounds(nx, ny) and maze_array[nx][ny] == 1:
			maze_array[(x + nx) / 2][(y + ny) / 2] = 0
			_generate_maze(nx, ny)
			
