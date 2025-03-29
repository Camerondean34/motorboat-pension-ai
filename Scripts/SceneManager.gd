extends Node

var boat_scene
var ocean_scene = preload("res://Scenes/ocean-scene.tscn").instantiate()
var current_scene

signal change_scene
signal set_up(scene)

func _ready() -> void:
	change_scene.connect(_on_scene_change)
	set_up.connect(_set_up)
	
func _set_up(scene) -> void:
	boat_scene = scene
	current_scene = boat_scene
	
func _on_scene_change() -> void:
	if current_scene == boat_scene:
		call_deferred("_deferred_goto_scene", ocean_scene)
	else:
		call_deferred("_deferred_goto_scene", boat_scene)
	
func _deferred_goto_scene(scene):
	get_tree().root.remove_child(current_scene)
	get_tree().root.add_child(scene)
	current_scene = scene
