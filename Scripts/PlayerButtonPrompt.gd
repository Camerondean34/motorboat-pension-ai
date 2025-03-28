extends Node2D

var Enabled = false	

signal togglePrompt

func _ready() -> void:
	$Timer.timeout.connect(_toggle_visibility)
	togglePrompt.connect(_toggle_enabled)
	
func _toggle_enabled():
	Enabled = !Enabled
	if !Enabled:
		$ButtonSprite.visible = false

func _toggle_visibility():
	if Enabled:
		$ButtonSprite.visible = !$ButtonSprite.visible
