extends Node2D

var brain_wall = preload("res://Scenes/brain_wall.tscn")
var maze_array = []
var maze_width = 19 # Both of these should be odd
var maze_height = 19

func _ready() -> void:
	_init_maze()
	_generate_maze(0, 0)
	for x in range(floor(maze_width / 2.0) - 1, ceil(maze_width / 2.0) + 1):
		for y in range(floor(maze_height / 2.0) - 1, ceil(maze_height / 2.0) + 1):
			maze_array[x][y] = 0
	
	var background = brain_wall.instantiate()
	background.find_child("StaticBody2D").get_child(0).disabled = true
	background.set_scale(Vector2(maze_width, maze_height))
	background.modulate.a = 0.5
	$Maze.add_child(background)
	$Maze/MazeArea.set_scale(Vector2(maze_width, maze_height))
	$Maze/MazeArea.set_position(Vector2((maze_width / 2.0) * 200, (maze_height / 2.0) * 200))
	for x in range(maze_width):
		for y in range(maze_height):
			if maze_array[x][y] == 1:
				var wall = brain_wall.instantiate()
				wall.set_position(Vector2(x * 200, y * 200))
				$Maze.add_child(wall)
	$Maze/Brain.set_position(Vector2((maze_width / 2.0) * 200, (maze_height / 2.0) * 200))
	$Maze/Brain.brain_collided.connect(_on_brain_collided)
	
func _init_maze() -> void:
	for x in range(maze_width): # 0 = empty, 1 = wall
		maze_array.append([])
		for y in range(maze_height):
			maze_array[x].append(1)

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
			maze_array[floor((x + nx) / 2.0)][floor((y + ny) / 2.0)] = 0
			_generate_maze(nx, ny)

func _on_brain_collided() -> void: # Player has died
	SceneManager.change_scene.emit("BOAT", true)


func _on_maze_area_body_exited(body: Node2D) -> void: # Player has escaped the maze
	if body is Brain:
		if PensionerPrison.prisoners.size() == PensionerPrison.pensionerCapacity:
			PensionerPrison.prisoners.shuffle();
			PensionerPrison.prisoners.pop_back();
		var pensioner = Pensioner.new()
		PensionerPrison.prisoners.append(pensioner)
		PlayerVariables.accountBalance += pensioner.payout;
		SceneManager.change_scene.emit("BOAT", true)
