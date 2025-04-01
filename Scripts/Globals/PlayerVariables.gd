extends Node

var accountBalance = 0
var playerCharge = 100
var boatHealth = 100

signal boat_has_docked

func _ready() -> void:
	boat_has_docked.connect(_on_boat_dock)
	
func _on_boat_dock() -> void:
	pass # I added this to remove the warning about unused signal
