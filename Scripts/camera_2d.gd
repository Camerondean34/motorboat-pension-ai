extends Camera2D

# Reference to the TileMapLayer node
@export var tile_map_layer: TileMapLayer

# Tile size, assume you define it manually if TileMap is absent
@export var tile_size: Vector2 = Vector2(16, 16)  # Change this according to your tile size

func _ready():
	# Check if TileMapLayer is assigned
	if tile_map_layer == null:
		print("TileMapLayer is not assigned!")
		return

	# Update the camera size to match the TileMapLayer
	match_camera_size_to_tilemap_layer()

func match_camera_size_to_tilemap_layer():
	# Get the bounds of the TileMapLayer based on its tiles
	var layer_size = tile_map_layer.get_used_rect()  # Returns a Rect2 (x, y, width, height) of the used tiles

	# Convert the grid size to pixel size (map's total width and height)
	var map_width = layer_size.size.x * tile_size.x
	var map_height = layer_size.size.y * tile_size.y

	# Get the screen size (the visible area of the camera)
	var screen_size = get_viewport().get_visible_rect().size

	# Calculate the zoom factor to match the camera size to the TileMapLayer size
	var zoom_x = screen_size.x / map_width
	var zoom_y = screen_size.y / map_height

	# Set the camera's zoom property to match the TileMapLayer's size
	zoom = Vector2(zoom_x, zoom_y)

	# Optional: For debugging, print out the zoom factor
	print("Camera zoom set to: %s" % zoom)
