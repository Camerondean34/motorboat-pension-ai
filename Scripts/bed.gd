extends Node2D

var PlayerByBed = false

func _ready() -> void:
	$Pensioner/AnimatedSprite2D.animation = str(PensionerPrison.typeOnBed)
	match PensionerPrison.typeOnBed:
		0:
			$Pensioner/OxygenMask.set_position(Vector2(-15.0,-215.0))
		1:
			$Pensioner/OxygenMask.set_position(Vector2(-15.0,-190.0))
		2:
			$Pensioner/OxygenMask.set_position(Vector2(-3.0,-255.0))
		3:
			$Pensioner/OxygenMask.set_position(Vector2(-10.0,-230.0))


func _on_prompt_area_body_entered(body: Node2D) -> void:
	if body is Player:
		var PlayerBody = body as Player
		PlayerBody.togglePrompt.emit()
		PlayerByBed = true

func _on_prompt_area_body_exited(body: Node2D) -> void:
	if body is Player:
		var PlayerBody = body as Player
		PlayerBody.togglePrompt.emit()
		PlayerByBed = true
		
func _input(event: InputEvent) -> void:
	if PlayerByBed and event.is_action_pressed("Interact"):
		SceneManager.change_scene.emit()
