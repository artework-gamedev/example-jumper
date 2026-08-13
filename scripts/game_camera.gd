extends Camera2D

var player: Player = null
var viewport_size: Vector2

# References for the platform destroyer
@onready var platform_destroyer: Area2D = $PlatformDestroyer
@onready var destroyer_shape: CollisionShape2D = $PlatformDestroyer/CollisionShape2D

const CAMERA_MARGIN: int = 460

func _ready() -> void:
	viewport_size = get_viewport_rect().size
	
	# Set the camera position
	limit_bottom = int(viewport_size.y)
	limit_left = 0
	limit_right = int(viewport_size.x)
	global_position.x = viewport_size.x / 2
	
	# Setup the platform destroyer
	platform_destroyer.position.y = viewport_size.y # Keep the destroyer one viewport height below the player
	var rect_shape = RectangleShape2D.new()
	rect_shape.size = Vector2(viewport_size.x, 200)
	destroyer_shape.shape = rect_shape

func _process(_delta: float) -> void:
	# Stop the camera from moving down
	if player:
		if limit_bottom > player.global_position.y + CAMERA_MARGIN:
			limit_bottom = int(player.global_position.y + CAMERA_MARGIN)
	
	var overlapping_areas: Array[Area2D] = platform_destroyer.get_overlapping_areas()
	for area in overlapping_areas:
		if area is Platform:
			area.queue_free()
			# print("Deleting " + area.name)

func _physics_process(_delta: float) -> void:
	if player == null:
		return
	# Track the player's position
	global_position.y = player.global_position.y

func setup_camera(_player: Player) -> void:
	if _player == null:
		print("Error: Camera cannot accept null value for player")
		return
	player = _player
