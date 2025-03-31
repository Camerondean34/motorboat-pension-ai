extends Node2D
var PlayerByWheel = false
var PlayerByStairs = false
var PlayerInBasement = false
@onready var animation_player: AnimationPlayer = $CanvasLayer/AnimationPlayer
@onready var color_rect: ColorRect = $CanvasLayer/ColorRect

func _ready() -> void:
	animation_player.play("reverse_transition")
	color_rect.set_visible(false)
	$Basement/StairPromptArea.body_entered.connect(_on_stair_prompt_area_body_entered)
	$Basement/StairPromptArea.body_exited.connect(_on_stair_prompt_area_body_exited)

func _on_prompt_area_body_entered(body: Node2D) -> void:
	if body is Player:
		$Player/ButtonPrompt.togglePrompt.emit()
		PlayerByWheel = true
func _on_prompt_area_body_exited(body: Node2D) -> void:
	if body is Player:
		$Player/ButtonPrompt.togglePrompt.emit()
		PlayerByWheel = false

func _on_stair_prompt_area_body_entered(body: Node2D) -> void:
	if body is Player and !PlayerByStairs:
		$Player/ButtonPrompt.togglePrompt.emit()
		PlayerByStairs = true
func _on_stair_prompt_area_body_exited(body: Node2D) -> void:
	if body is Player and PlayerByStairs:
		$Player/ButtonPrompt.togglePrompt.emit()
		PlayerByStairs = false

func _input(event: InputEvent) -> void:
	if PlayerByWheel and event.is_action_pressed("Interact"):
		SceneManager.change_scene.emit("OCEAN", false)
	if PlayerByStairs and event.is_action_pressed("Interact"):
		if PlayerInBasement:
			$Player.position.y -= 1000
			$Player.CameraXMax = 0
			$Player.CameraXMin = -625
		else:
			$Player.position.y += 1000
			$Player.position.x = -525
			$Player.CameraXMax = -670
			$Player.CameraXMin = -825
			$Basement._on_player_entered_basement()
		PlayerInBasement = !PlayerInBasement
