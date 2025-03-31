extends Node2D

var array_2d = []
@export var rocks: Array[PackedScene] = []
@export var islands: Array[PackedScene] = []  # List of island scenes

var rows = 80
var columns = 160
var all_squads = []
var all_large_squads = []

func _ready() -> void:
	initialize_grid()
	find_all_large_squads()
	place_random_island()
	place_random_island()
	place_random_island()
	find_all_squads()
	var selected_squads = pick_random_squads(15)
	place_rocks(selected_squads)

func initialize_grid():
	for i in range(rows):
		var row = []
		for j in range(columns):
			row.append(0)
		array_2d.append(row)

	array_2d[2][2] = 1
	array_2d[3][3] = 1
	array_2d[6][6] = 1

func find_all_squads():
	for i in range(rows - 1):
		for j in range(columns - 1):
			if array_2d[i][j] == 0 and array_2d[i][j+1] == 0 and array_2d[i+1][j] == 0 and array_2d[i+1][j+1] == 0:
				all_squads.append([[i, j], [i, j+1], [i+1, j], [i+1, j+1]])

func find_all_large_squads():
	for i in range(rows - 15):
		for j in range(columns - 15):
			var is_valid = true
			var squad = []
			for x in range(16):
				for y in range(16):
					if array_2d[i + x][j + y] == 1:
						is_valid = false
						break
					else:
						squad.append([i + x, j + y])
				if not is_valid:
					break
			if is_valid:
				all_large_squads.append(squad)

func pick_random_squads(num_squads: int) -> Array:
	var selected_squads = []
	if all_squads.size() < num_squads:
		return all_squads

	while selected_squads.size() < num_squads:
		var random_index = randi() % all_squads.size()
		var squad = all_squads[random_index]
		if squad not in selected_squads and is_squad_uncontested(squad):
			selected_squads.append(squad)
			mark_squad_as_contested(squad)

	return selected_squads

func is_squad_uncontested(squad: Array) -> bool:
	for point in squad:
		if array_2d[point[0]][point[1]] == 1:
			return false
	return true

func mark_squad_as_contested(squad: Array):
	for point in squad:
		array_2d[point[0]][point[1]] = 1

func calculate_center(squad: Array) -> Vector2:
	var x_total = 0
	var y_total = 0
	for point in squad:
		x_total += point[0]
		y_total += point[1]
	return Vector2(y_total / squad.size(), x_total / squad.size())

func place_rocks(selected_squads):
	for squad in selected_squads:
		var center_pos = calculate_center(squad)
		var random_rock_scene = rocks[randi() % rocks.size()]
		var rock_instance = random_rock_scene.instantiate()
		rock_instance.position = center_pos * 16
		add_child(rock_instance)

func place_random_island():
	if all_large_squads.size() == 0 or islands.size() == 0:
		print("No valid 16x16 squad or islands available!")
		return

	var random_index = randi() % all_large_squads.size()
	var large_squad = all_large_squads[random_index]
	var center_pos = calculate_center(large_squad)
	var random_island_scene = islands[randi() % islands.size()]
	var island_instance = random_island_scene.instantiate()
	island_instance.position = center_pos * 16
	add_child(island_instance)
	mark_squad_as_contested(large_squad)

func _input(event: InputEvent) -> void:
	if event.is_action("Escape"):
		SceneManager.change_scene.emit("BOAT", false)
