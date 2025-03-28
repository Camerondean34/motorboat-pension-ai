extends Node2D
var PlayerByWheel = false
var PlayerByStairs = false
var PlayerInBasement = false

func _ready() -> void:
	SceneManager.set_up.emit(self)
	$Basement/PromptArea.body_entered.connect(_on_stair_prompt_area_body_entered)
	$Basement/PromptArea.body_exited.connect(_on_stair_prompt_area_body_exited)

func _on_prompt_area_body_entered(body: Node2D) -> void:
	if body is Player:
		$Player/ButtonPrompt.togglePrompt.emit()
		PlayerByWheel = true
func _on_prompt_area_body_exited(body: Node2D) -> void:
	if body is Player:
		$Player/ButtonPrompt.togglePrompt.emit()
		PlayerByWheel = false

func _on_stair_prompt_area_body_entered(body: Node2D) -> void:
	if body is Player:
		$Player/ButtonPrompt.togglePrompt.emit()
		PlayerByStairs = true
func _on_stair_prompt_area_body_exited(body: Node2D) -> void:
	if body is Player:
		$Player/ButtonPrompt.togglePrompt.emit()
		PlayerByStairs = true

func _input(event: InputEvent) -> void:
	if PlayerByWheel and event.is_action_pressed("Interact"):
		SceneManager.change_scene.emit()
	if PlayerByStairs and event.is_action_pressed("Interact"):
		if PlayerInBasement:
			$Player.position.y -= 1000
			$Player.CameraXMax = 0
			$Player.CameraXMin = -625
		else:
			$Player.position.y += 1000
			$Player.CameraXMax = -670
			$Player.CameraXMin = -825
		PlayerInBasement = !PlayerInBasement
