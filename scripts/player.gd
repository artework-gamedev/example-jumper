extends CharacterBody2D


const MAX_SPEED = 300.0
const ACCELERATION = MAX_SPEED * 5
const JUMP_VELOCITY = -400.0

func _ready() -> void:
	pass
	
func _process(_delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	var horizontal_dir = Input.get_axis("move_left", "move_right")
	velocity.x = move_toward(velocity.x, horizontal_dir * MAX_SPEED, ACCELERATION * delta)
	
	
	move_and_slide()
