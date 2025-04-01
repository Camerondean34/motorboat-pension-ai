extends Node2D
var PlayerByWheel = false
var PlayerByStairs = false
var PlayerInBasement = false

var BoatIsDocked = false

var island_scene = preload("res://Scenes/island_scene.tscn")

@onready var boat_music = load("res://Assets/Music/Inside.wav")
@onready var basement_music = load("res://Assets/Music/TheBasement.wav")
@onready var island_music = load("res://Assets/Music/IslandLoop.wav")

@onready var animation_player: AnimationPlayer = $CanvasLayer/AnimationPlayer
@onready var color_rect: ColorRect = $CanvasLayer/ColorRect

func _ready() -> void:
	$AudioStreamPlayer.stream = boat_music
	$AudioStreamPlayer.play()
	animation_player.play("reverse_transition")
	color_rect.set_visible(false)
	$Basement/StairPromptArea.body_entered.connect(_on_stair_prompt_area_body_entered)
	$Basement/StairPromptArea.body_exited.connect(_on_stair_prompt_area_body_exited)
	PlayerVariables.boat_has_docked.connect(_on_boat_docked)

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
		_undock_boat()
		SceneManager.change_scene.emit("OCEAN", false)
	if PlayerByStairs and event.is_action_pressed("Interact"):
		if PlayerInBasement:
			$Player.position.y -= 1000
			$Player.CameraXMax = 0
			$Player.CameraXMin = -625
			$AudioStreamPlayer.stop()
			$AudioStreamPlayer.stream = boat_music
			$AudioStreamPlayer.play()
		else:
			$Player.position.y += 1000
			$Player.position.x = -525
			$Player.CameraXMax = -670
			$Player.CameraXMin = -825
			$Basement._on_player_entered_basement()
			$AudioStreamPlayer.stop()
			if PensionerPrison.prisonerOnBed:
				$AudioStreamPlayer.stream = basement_music
				$AudioStreamPlayer.play()
		PlayerInBasement = !PlayerInBasement
		
func _on_boat_docked() -> void:
	if !BoatIsDocked:
		BoatIsDocked = true
		if $IslandContainer.get_child_count() != 0:
			var currentIsland = 	$IslandContainer.get_child(0)
			if currentIsland != null:
				currentIsland.queue_free()
		$DoorWall/CollisionShape2D.disabled = true
		$Background.animation = "door_open"
		var new_island = island_scene.instantiate()
		$IslandContainer.add_child(new_island)
		$Player.CameraXMin = -2380
	
func _undock_boat() -> void:
	if BoatIsDocked:
		BoatIsDocked = false
		if $IslandContainer.get_child_count() != 0:
			var currentIsland = 	$IslandContainer.get_child(0)
			if currentIsland != null:
				currentIsland.queue_free()
		$DoorWall/CollisionShape2D.disabled = false	
		$Background.animation = "door_closed"
		$Player.CameraXMin = -625

func _on_music_area_body_exited(body: Node2D) -> void:
	if body is Player:
		$AudioStreamPlayer.stop()
		if body.position > $MusicArea.position:
			$AudioStreamPlayer.stream = boat_music
		else:
			$AudioStreamPlayer.stream = island_music
		$AudioStreamPlayer.play()
