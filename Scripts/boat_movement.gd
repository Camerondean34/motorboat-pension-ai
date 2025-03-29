extends CharacterBody2D
@export var speed = 250

func _physics_process(_delta):
	look_at(get_global_mouse_position())
	velocity = Input.get_vector("Left", "Right", "Up", "Down")
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
	velocity.x *= 0.0
	velocity = velocity.rotated(rotation)
	move_and_slide()
