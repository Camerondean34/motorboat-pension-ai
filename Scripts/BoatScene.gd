extends Node2D
var PlayerByWheel = false
var ocean_scene = preload("res://Scenes/ocean_scene.tscn").instantiate()

func _on_prompt_area_body_entered(body: Node2D) -> void:
	if body is Player:
		$Player/ButtonPrompt.togglePrompt.emit()
		PlayerByWheel = true

func _on_prompt_area_body_exited(body: Node2D) -> void:
	if body is Player:
		$Player/ButtonPrompt.togglePrompt.emit()
		PlayerByWheel = false

func _input(event: InputEvent) -> void:
	if PlayerByWheel and event.is_action_pressed("Interact"):
		hide()
		get_tree().root.add_child(ocean_scene)
