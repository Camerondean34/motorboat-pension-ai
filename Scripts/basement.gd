extends Node2D

var BedInstance = preload("res://Scenes/bed.tscn")

func _on_player_entered_basement() -> void:
	var currentBed = find_child("Bed")
	if currentBed != null:
		currentBed.queue_free()
	if PensionerPrison.prisonerOnBed:
		currentBed = BedInstance.instantiate()
		currentBed.set_position(Vector2(-142, 206))
		currentBed.set_scale(Vector2(0.3, 0.3))
		add_child(currentBed)
