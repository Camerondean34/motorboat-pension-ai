extends Node2D

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
