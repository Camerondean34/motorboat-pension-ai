extends Node2D

# Initialize a 2D array
# Initialize a 2D array
var array_2d = []

@export var rocks: Array[PackedScene] = []

# Define the dimensions (for example, 3x3)
var rows = 80
var columns = 160

var all_squads = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in range(rows):
		var row = []
		for j in range(columns):
			row.append(0)  # You can append any default value here
			array_2d.append(row)

	# Print the 2D array
# Example: Mark some contested spaces (1 means contested)
	array_2d[2][2] = 1  # Contested space
	array_2d[3][3] = 1  # Contested space
	array_2d[6][6] = 1  # Contested space
	
	# Step 1: Find all uncontested 2x2 squads
	find_all_squads()

	# Step 2: Randomly pick 10 squads
	var selected_squads = pick_random_squads(15)

	# Step 3: Print the selected squads for debugging
	print("Selected Squads:", selected_squads)
	for squad in selected_squads:
		# Step 3a: Calculate the center of the 2x2 block (average of all 4 positions)
		var center_pos = calculate_center(squad)

		# Step 3b: Pick a random rock (PackedScene) from the array
		var random_rock_scene = rocks[randi() % rocks.size()]
		
		# Step 3c: Instantiate the random rock scene
		var rock_instance = random_rock_scene.instantiate()
		
		# Step 3d: Set the position of the rock to the center of the squad
		rock_instance.position = center_pos * 16  # Assuming each tile is 32x32 pixels

		# Add the rock instance to the scene
		add_child(rock_instance)


func find_all_squads():
	# Loop through the 2D array to find all 2x2 uncontested blocks
	for i in range(rows - 1):  # Loop up to the second-to-last row
		for j in range(columns - 1):  # Loop up to the second-to-last column
			# Check if a 2x2 block starting at (i, j) is uncontested (all 0s)
			if array_2d[i][j] == 0 and array_2d[i][j+1] == 0 and array_2d[i+1][j] == 0 and array_2d[i+1][j+1] == 0:
				# If the block is uncontested, it's a valid squad
				all_squads.append([[i, j], [i, j+1], [i+1, j], [i+1, j+1]])

func pick_random_squads(num_squads: int) -> Array:
	var selected_squads = []
	
	# Ensure we have enough squads to choose from
	if all_squads.size() < num_squads:
		print("Not enough squads found!")
		return all_squads  # Return all squads if there aren't enough to choose from
	
	# Pick random squads using rand_range
	while selected_squads.size() < num_squads:
		var random_index = randi() % all_squads.size()  # Get a random index
		var squad = all_squads[random_index]
		
		# Make sure the selected squad is unique (not already picked)
		if squad not in selected_squads and is_squad_uncontested(squad):
			selected_squads.append(squad)
			mark_squad_as_contested(squad)
			
	return selected_squads
	
func is_squad_uncontested(squad: Array) -> bool:
	for point in squad:
		var x = point[0]
		var y = point[1]
		if array_2d[x][y] == 1:  # If any point is contested (1), return false
			return false
	return true  # Return true if all positions are uncontested
	
func calculate_center(squad: Array) -> Vector2:
	var x_total = 0
	var y_total = 0
	
	# Sum the coordinates of the four points
	for point in squad:
		x_total += point[0]
		y_total += point[1]
	
	# Calculate the average position
	var center_x = x_total / 4
	var center_y = y_total / 4
	
	# Return the center position
	return Vector2(center_y, center_x)

func mark_squad_as_contested(squad: Array):
	for point in squad:
		var x = point[0]
		var y = point[1]
		
		# Mark the position as contested (1)
		array_2d[x][y] = 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
