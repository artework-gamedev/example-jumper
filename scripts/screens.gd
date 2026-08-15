extends CanvasLayer

@onready var console_log: Control = $Debug/ConsoleLog


func _ready() -> void:
	# Console is off at the beginning of the game
	console_log.visible = false
	
	register_buttons()


func _process(_delta: float) -> void:
	pass


# Console is toggled on button press
func _on_toggle_console_pressed() -> void:
	console_log.visible = not console_log.visible


# Find all ScreenButtons and link their signals
func register_buttons() -> void:
	var buttons: Array[Node] = get_tree().get_nodes_in_group("buttons")
	for button in buttons:
		if button is not ScreenButton:
			print("Error: %s is not a ScreenButton" % button.name)
			continue
		button.clicked.connect(_on_screen_button_pressed)


# Callback for when a ScreenButton is pressed
func _on_screen_button_pressed(button: ScreenButton) -> void:
	match button.name:
		"TitlePlayBtn" :
			print("Play button was pressed")
		"PauseRetryBtn":
			print("Pause retry button was pressed")
		"PauseMenuBtn":
			print("Pause menu button was pressed")
		"PauseCloseBtn":
			print("Pause close button was pressed")
		"GameOverRetryBtn":
			print("Gamve over retry button was pressed")
		"GameOverMenuBtn":
			print("Game over menu button was pressed")
