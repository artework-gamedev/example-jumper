extends Node2D

# Camera globals
var camera_scene: Resource = preload("res://scenes/game_camera.tscn")
var camera: Camera2D = null

# Player instantiation
var player_scene: Resource = preload("res://scenes/Player.tscn")
var player: Player = null
const player_spawn_offset: int = 100 # How high above the ground player spawns
var player_spawn_pos: Vector2

# Level generator instantiation
@onready var level_generator: Node2D = $LevelGenerator


func _ready() -> void:
	var viewport_size = get_viewport_rect().size
	player_spawn_pos.x = viewport_size.x / 2.0
	player_spawn_pos.y = viewport_size.y - player_spawn_offset
	
	new_game()


func _process(_delta: float) -> void:
	# Process debug commands to quit and reset game
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	if Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()


func new_game() -> void:
	player = player_scene.instantiate()
	player.global_position = player_spawn_pos
	add_child(player)
	
	camera = camera_scene.instantiate()
	camera.setup_camera(player)
	add_child(camera)
	
	level_generator.setup(player)
