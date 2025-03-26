extends CharacterBody2D

@export var speed = 400

func _physics_process(_delta):
	var input_direction = Input.get_axis("Left", "Right")
	velocity.x = input_direction * speed
	move_and_slide()
