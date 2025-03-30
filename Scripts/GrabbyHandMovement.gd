extends Sprite2D

@export var default_texture: Texture2D
@export var clicked_texture: Texture2D

func _ready():
	texture = default_texture  # Set the initial texture
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func _process(delta):
	global_position = get_global_mouse_position()

func _input(event):
	if event is InputEventMouseButton:
		if event.pressed:
			texture = clicked_texture  # Change texture on click
		else:
			texture = default_texture  # Revert texture when released
			 # Restore cursor when exiting


func _exit_tree():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
