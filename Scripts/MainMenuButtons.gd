extends VBoxContainer

@onready var animation_player: AnimationPlayer = $"../CanvasLayer/AnimationPlayer"

@onready var color_rect: ColorRect = $"../CanvasLayer/ColorRect"

func _ready() -> void:
	SceneManager._setup(get_parent())

func _on_start_game_button_down() -> void:
	color_rect.set_visible(true)
	
	animation_player.play("transition")
	
	await get_tree().create_timer(1).timeout 

	SceneManager.change_scene.emit("BOAT", true)

func _on_quit_button_down() -> void:
	get_tree().quit()


func _on_start_game_mouse_entered() -> void:
	pass # Replace with function body.
