extends Node2D
var PlayerByPensioner = false
var PensionerAlive = true
var PensionerType

@export var pensioner_node: Sprite2D
@export var pensioner_img_01: Texture2D
@export var pensioner_img_02: Texture2D
@export var pensioner_img_03: Texture2D
@export var pensioner_img_04: Texture2D

@export var background_node: Sprite2D
@export var island_bg_01: Texture2D
@export var island_bg_02: Texture2D
@export var island_bg_03: Texture2D
@export var island_bg_04: Texture2D

func get_random_pensioner_image() -> Texture2D:
	var options = [pensioner_img_01, pensioner_img_02, pensioner_img_03, pensioner_img_04]
	PensionerType = randi() % options.size()
	return options[PensionerType]
	
func get_random_island_background() -> Texture2D:
	var backgrounds = [island_bg_01, island_bg_02, island_bg_03, island_bg_04]
	return backgrounds[randi() % backgrounds.size()]

func _ready() -> void:
	var backgroundTexture = get_random_island_background();
	background_node.texture = backgroundTexture;
	
	var pensionerImg = get_random_pensioner_image();
	pensioner_node.texture = pensionerImg;
	
	PensionerAlive = true;
	pensioner_node.visible = true;

func _on_prompt_area_body_entered(body: Node2D) -> void:
	if body is Player and PensionerAlive:
		var PlayerBody = body as Player
		PlayerBody.find_child("ButtonPrompt").togglePrompt.emit()
		PlayerByPensioner = true

func _on_prompt_area_body_exited(body: Node2D) -> void:
	if body is Player and PensionerAlive:
		var PlayerBody = body as Player
		PlayerBody.find_child("ButtonPrompt").togglePrompt.emit()
		PlayerByPensioner = false # Replace with function body.

func _input(event: InputEvent) -> void:
	if PlayerByPensioner and PensionerAlive and event.is_action_pressed("Interact"):
		capture_pensioner();
		

		
func update_ui() -> void:
	
	pass

func capture_pensioner() -> void:
	if PensionerPrison.prisoners.size() == PensionerPrison.pensionerCapacity:
		PensionerPrison.prisoners.shuffle();
		PensionerPrison.prisoners.pop_back();
	
	var pensioner = Pensioner.new()
	PensionerPrison.prisoners.append(pensioner)
	PlayerVariables.accountBalance += pensioner.payout;
	PensionerPrison.typeOnBed = PensionerType
	PensionerPrison.prisonerOnBed = true
	
	pensioner_node.visible = false;
	PensionerAlive = false;
	var player_node = get_node("/root/BoatScene/Player")
	if player_node != null:
		player_node.find_child("ButtonPrompt").togglePrompt.emit()
