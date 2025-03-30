extends VBoxContainer

@onready var animation_player: AnimationPlayer = $"../CanvasLayer/AnimationPlayer"

@onready var color_rect: ColorRect = $"../CanvasLayer/ColorRect"

func _on_start_game_button_down() -> void:
	color_rect.set_visible(true)
	
	animation_player.play("transition")
	
	await get_tree().create_timer(1).timeout 

	get_tree().change_scene_to_file("res://Scenes/boat_scene.tscn")

func _on_quit_button_down() -> void:
	get_tree().quit()
