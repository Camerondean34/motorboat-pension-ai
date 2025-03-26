extends CharacterBody2D

@export var speed = 400
var IsIdle = false

func _ready() -> void:
	$IdleTimer.timeout.connect(_on_idle)

func _physics_process(_delta):
	var input_direction = Input.get_axis("Left", "Right")
	velocity.x = input_direction * speed
	
	# Set animation
	if velocity.x != 0:
		IsIdle = false
		if !$IdleTimer.is_stopped():
			$IdleTimer.stop()
		$AnimatedSprite2D.flip_h = velocity.x > 0
		$AnimatedSprite2D.animation = "Walk"
	elif !IsIdle:
		if $IdleTimer.is_stopped():
			$IdleTimer.start()
		$AnimatedSprite2D.animation = "FaceLeft"
		
	
	move_and_slide()
	
func _on_idle():
	IsIdle = true
	$AnimatedSprite2D.animation = "Idle"
	$IdleTimer.stop()
