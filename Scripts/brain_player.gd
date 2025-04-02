extends CharacterBody2D
class_name Brain

const max_speed = 50
@export var speed = max_speed
@export var rotation_speed = deg_to_rad(1)
const friction = 1;
var prev_speed = 0;

signal brain_collided

func _physics_process(_delta):
	var input_y = Input.get_axis("Up", "Down")
	var input_rotation = Input.get_axis("Left", "Right")
	
	rotation += input_rotation * rotation_speed
	
	if input_y != 0:
		speed = max_speed
		velocity.y = input_y * speed
		velocity.x = 0
	else:
		speed = prev_speed - friction
		if speed < 0:
			speed = 0
		velocity = velocity.normalized() * speed
	prev_speed = speed
	
	velocity = velocity.rotated(rotation)
	var result = move_and_slide()
	if result:
		brain_collided.emit()
