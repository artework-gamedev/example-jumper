extends Camera2D

var player: Player = null
var viewport_size: Vector2

const CAMERA_MARGIN: int = 460

func _ready() -> void:
	viewport_size = get_viewport_rect().size
	
	# Set the camera position
	limit_bottom = int(viewport_size.y)
	limit_left = 0
	limit_right = int(viewport_size.x)

func _process(_delta: float) -> void:
	# Stop the camera from moving down
	if player:
		if limit_bottom > player.global_position.y + CAMERA_MARGIN:
			limit_bottom = int(player.global_position.y + CAMERA_MARGIN)

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
