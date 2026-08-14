extends CanvasLayer

@onready var console_log: Control = $Debug/ConsoleLog


func _ready() -> void:
	# Console is off at the beginning of the game
	console_log.visible = false


func _process(_delta: float) -> void:
	pass


# Console is toggled on button press
func _on_toggle_console_pressed() -> void:
	console_log.visible = not console_log.visible
