extends CharacterBody2D


const MAX_SPEED = 300.0
const ACCELERATION = MAX_SPEED * 5
const JUMP_VELOCITY = -400.0
const MAX_FALL_SPEED = -JUMP_VELOCITY * 2
const GRAVITY = 15.0

var viewport_size: Vector2
const TELEPORT_MARGIN = 20

func _ready() -> void:
	viewport_size = get_viewport_rect().size
	print(viewport_size)
	
func _process(_delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	# Vertical falling
	velocity.y = clampf(velocity.y + GRAVITY, -MAX_FALL_SPEED, MAX_FALL_SPEED)
	
	# Horiziontal motion
	var horizontal_dir = Input.get_axis("move_left", "move_right")
	velocity.x = move_toward(velocity.x, horizontal_dir * MAX_SPEED, ACCELERATION * delta)
	
	# Teleport between edges of screen
	if global_position.x < -TELEPORT_MARGIN:
		global_position.x = viewport_size.x + TELEPORT_MARGIN - 1
	elif global_position.x > viewport_size.x + TELEPORT_MARGIN:
		global_position.x = -TELEPORT_MARGIN + 1
	
	
	move_and_slide()
