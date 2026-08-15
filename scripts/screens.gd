extends CanvasLayer

@onready var console_log: Control = $Debug/ConsoleLog

@onready var title_screen: Control = $TitleScreen
@onready var pause_screen: Control = $PauseScreen
@onready var game_over_screen: Control = $GameOverScreen

var current_screen: BaseScreen = null

func _ready() -> void:
	# Console is off at the beginning of the game
	console_log.visible = false
	
	register_buttons()
	change_screen(title_screen)


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


# Switches the currently active screen
func change_screen(new_screen: BaseScreen) -> void:
	if current_screen != null:
		var disappear_tween: Tween = current_screen.disappear()
		await disappear_tween.finished
	current_screen = new_screen
	if current_screen != null:
		current_screen.appear()


# Callback for when a ScreenButton is pressed
func _on_screen_button_pressed(button: ScreenButton) -> void:
	match button.name:
		"TitlePlayBtn" :
			change_screen(pause_screen) # debug
		"PauseRetryBtn":
			change_screen(game_over_screen) # debug
		"PauseMenuBtn":
			change_screen(title_screen) # debug
		"PauseCloseBtn":
			change_screen(null) # debug
		"GameOverRetryBtn":
			change_screen(pause_screen) # debug
		"GameOverMenuBtn":
			change_screen(title_screen) # debug
