extends CharacterBody2D
class_name Player


const MAX_SPEED = 300.0
const ACCELERATION = MAX_SPEED * 5
const JUMP_VELOCITY = -800.0
const MAX_FALL_SPEED = -JUMP_VELOCITY * 2
const GRAVITY = 15.0

var viewport_size: Vector2
const TELEPORT_MARGIN = 20

var use_accelerometer: bool = false
const ACCELEROMETER_LIMIT: float = 2.0

@onready var animator : AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	viewport_size = get_viewport_rect().size
	
	var os_name = OS.get_name()
	if os_name == "Android" or os_name == "iOS":
		use_accelerometer = true
	
	
func _process(_delta: float) -> void:
	# Set the correct animation
	if velocity.y > 0:
		set_animation("fall")
	else:
		set_animation("jump")

func _physics_process(delta: float) -> void:
	# Vertical falling
	velocity.y = clampf(velocity.y + GRAVITY, -MAX_FALL_SPEED, MAX_FALL_SPEED)
	
	# Horiziontal motion
	if use_accelerometer:
		var horizontal_dir = clampf(Input.get_accelerometer().x / ACCELEROMETER_LIMIT, -1.0, +1.0)
		velocity.x = move_toward(velocity.x, horizontal_dir * MAX_SPEED, ACCELERATION * delta)
	else:
		var horizontal_dir = Input.get_axis("move_left", "move_right")
		velocity.x = move_toward(velocity.x, horizontal_dir * MAX_SPEED, ACCELERATION * delta)
	
	# Teleport between edges of screen
	if global_position.x < -TELEPORT_MARGIN:
		global_position.x = viewport_size.x + TELEPORT_MARGIN - 1
	elif global_position.x > viewport_size.x + TELEPORT_MARGIN:
		global_position.x = -TELEPORT_MARGIN + 1
	
	move_and_slide()

func jump() -> void:
	velocity.y = JUMP_VELOCITY

func set_animation(anim_name: String) -> void:
	if animator.current_animation != anim_name:
		animator.play(anim_name)
