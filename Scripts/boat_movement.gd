extends CharacterBody2D
const max_speed = 200
@export var speed = max_speed
const friction = 2;
var prev_speed = 0;
func _physics_process(_delta):
	
	#OG code innit
	#look_at(get_global_mouse_position())
	#velocity = Input.get_vector("Left", "Right", "Up", "Down")
	#if velocity.length() > 0:
	#	velocity = velocity.normalized() * speed
	#velocity.x *= 0.0
	#velocity = velocity.rotated(rotation + $Sprite2D.rotation)
	#move_and_slide()
	
	look_at(get_global_mouse_position())
	var input_velocity = Input.get_vector("Left", "Right", "Up", "Down")
	if input_velocity.length() > 0:
		velocity = input_velocity
		speed = max_speed
		velocity = velocity.rotated(rotation + $Sprite2D.rotation)
	else:
		speed = prev_speed - friction
		if speed < 0:
			speed = 0
	prev_speed = speed
	
	velocity = velocity.normalized() * speed
	move_and_slide()
