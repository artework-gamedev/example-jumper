extends Node2D

# Platform generation globals
@onready var platform_parent: Node2D = $PlatformParent
var platform_scene: Resource = preload("res://scenes/Platform.tscn")
var next_platform_y_target: float = 0

@export var player: Player
@onready var viewport_size: Vector2 = get_viewport_rect().size


func _ready() -> void:
	next_platform_y_target = generate_level_platforms(20, -1, true)


func _process(_delta: float) -> void:
	# Load the next set of platforms when the player reaches the required height
	if player.global_position.y <= next_platform_y_target + viewport_size.y:
		next_platform_y_target = generate_level_platforms(10, next_platform_y_target, false)


func create_platform(location: Vector2) -> Node2D:
	var platform: Node2D = platform_scene.instantiate()
	platform.global_position = location
	platform_parent.add_child(platform)
	return platform


# Generates the platforms, and returns the height of next platform to be generated
func generate_level_platforms(num_platforms: int, start_y: float, generate_ground: bool) -> float:
	const platform_width: int = 134 + 2 # Hardcoded value, taken from the width of the CollisionShape2D rectangle of the platform
	const platform_height: int = 63 # Hardcoded, taken from the height of the platform sprite
	
	# Generating the ground layer
	if generate_ground:
		# Number of platforms needed to cover the ground
		var num_ground_layer_platforms: float = (viewport_size.x / platform_width) + 1
		var ground_layer_y: float = viewport_size.y - platform_height
		# Cover the ground in the platforms
		for i in range(num_ground_layer_platforms):
			create_platform(Vector2(i * platform_width, ground_layer_y))
	
	# Generate the climbing staircase of platforms
	const first_platform_height: int = 300 # First platform is this height above the ground layer
	const distance_between_platforms: int = 200 # Distance between each rung of ladder
	var platform_min_x: int = 0 # Leftmost position of a platform
	var platform_max_x: int = int(viewport_size.x - platform_width) # Rightmost position of a platform
	var next_platform_y: float
	if generate_ground:
		next_platform_y = viewport_size.y - platform_height - first_platform_height
	else:
		next_platform_y = start_y
	# Create each rung one at a time
	for i in range(num_platforms):
		var next_platform_x = randi_range(platform_min_x, platform_max_x)
		create_platform(Vector2(next_platform_x, next_platform_y))
		next_platform_y = next_platform_y - distance_between_platforms
	
	return next_platform_y
