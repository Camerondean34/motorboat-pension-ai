extends Node2D
var PlayerByPensioner = false

func _ready() -> void:
	SceneManager.set_up.emit(self)

func _on_prompt_area_body_entered(body: Node2D) -> void:
	if body is Player:
		$Player/ButtonPrompt.togglePrompt.emit()
		PlayerByPensioner = true

func _on_prompt_area_body_exited(body: Node2D) -> void:
	if body is Player:
		$Player/ButtonPrompt.togglePrompt.emit()
		PlayerByPensioner = false # Replace with function body.

func _input(event: InputEvent) -> void:
	if PlayerByPensioner and event.is_action_pressed("Interact"):
		capture_pensioner();

func capture_pensioner() -> void:
	
	if PensionerPrison.prisoners.size() == PensionerPrison.pensionerCapacity:
		PensionerPrison.prisoners.shuffle();
		PensionerPrison.prisoners.pop_back();
	
	var pensioner = Pensioner.new()
	PensionerPrison.prisoners.append(pensioner)
	
