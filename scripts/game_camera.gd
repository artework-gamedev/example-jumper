extends Camera2D

var player: Player = null

func _ready() -> void:
	global_position.x = get_viewport_rect().size.x / 2

func _physics_process(_delta: float) -> void:
	if player == null:
		return
	global_position.y = player.global_position.y

func setup_camera(_player: Player) -> void:
	if _player == null:
		print("Error: Camera cannot accept null value for player")
		return
	player = _player
