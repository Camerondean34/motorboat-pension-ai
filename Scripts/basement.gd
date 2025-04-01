extends Node2D

var BedInstance = preload("res://Scenes/bed.tscn")

func _on_player_entered_basement() -> void:
	if $BedContainer.get_child_count() != 0:
		var currentIsland = 	$BedContainer.get_child(0)
		if currentIsland != null:
			currentIsland.queue_free()
	if PensionerPrison.prisonerOnBed:
		var new_bed = BedInstance.instantiate()
		new_bed.set_position(Vector2(-142, 206))
		new_bed.set_scale(Vector2(0.3, 0.3))
		$BedContainer.add_child(new_bed)
