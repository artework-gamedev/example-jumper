extends Node2D

# Camera globals
var camera_scene: Resource = preload("res://scenes/game_camera.tscn")
var camera: Camera2D = null
var viewport_size: Vector2

# Player instantiation
var player_scene: Resource = preload("res://scenes/Player.tscn")
var player: Player = null
const player_spawn_offset: int = 100 # How high above the ground player spawns
var player_spawn_pos: Vector2 = Vector2.ZERO

# Level generator instantiation
@onready var level_generator: Node2D = $LevelGenerator

# Background sprites and parallaxes
@onready var ground_sprite: Sprite2D = $GroundSprite
@onready var parallax1: Parallax2D = $ParallaxBackround/Parallax2D
@onready var parallax2: Parallax2D = $ParallaxBackround/Parallax2D2
@onready var parallax3: Parallax2D = $ParallaxBackround/Parallax2D3


func _ready() -> void:
	viewport_size = get_viewport_rect().size
	player_spawn_pos.x = viewport_size.x / 2.0
	player_spawn_pos.y = viewport_size.y - player_spawn_offset
	
	# Set up the ground sprite dimensions
	ground_sprite.global_position.x = viewport_size.x / 2
	ground_sprite.global_position.y = viewport_size.y
	var ground_sprite_width: float = ground_sprite.texture.get_size().x
	ground_sprite.scale.x = viewport_size.x / ground_sprite_width
	
	# Set up the parallax background layers
	configure_parallax(parallax1, 0.1)
	configure_parallax(parallax2, 0.5)
	configure_parallax(parallax3, 0.85)
	
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

func configure_parallax(parallax: Parallax2D, scroll_scale: float) -> void:
	var sprite: Sprite2D = parallax.find_child("Sprite2D")
	if sprite == null:
		print("Could not configure " + parallax.name)
		return
	var texture_size: Vector2 = sprite.texture.get_size()
	var texture_scale_factor: float = viewport_size.x / texture_size.x
	sprite.position.x = viewport_size.x / 2
	sprite.scale = Vector2.ONE * texture_scale_factor
	parallax.repeat_size = Vector2(0, texture_size.y * texture_scale_factor)
	parallax.scroll_scale.y = scroll_scale
