extends Node

var boat_scene = preload("res://Scenes/boat_scene.tscn").instantiate()
var ocean_scene = preload("res://Scenes/ocean-scene.tscn").instantiate()
var current_scene

signal change_scene(path, deleteCurrent)

func _ready() -> void:
	change_scene.connect(_on_scene_change)
	
func _setup(scene) -> void:
	current_scene = scene
	
func _on_scene_change(pPath, pDeleteCurrent) -> void:
	var new_scene
	if pPath == "BOAT":
		new_scene = boat_scene
	elif pPath == "OCEAN":
		new_scene = ocean_scene
	else:
		var s = ResourceLoader.load(pPath)
		new_scene = s.instantiate()
	call_deferred("_deferred_goto_scene", new_scene,pDeleteCurrent)
	
func _deferred_goto_scene(scene, pDeleteCurrent):
	if current_scene and current_scene.get_parent():
		get_tree().root.remove_child(current_scene)
	get_tree().root.add_child(scene)
	if pDeleteCurrent:
		current_scene.queue_free()
	current_scene = scene
