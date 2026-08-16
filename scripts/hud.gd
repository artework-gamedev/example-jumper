extends Control

@onready var topbar: Control = $TopBar
@onready var topbar_bg: ColorRect = $TopBarBG


func _ready() -> void:
	var os_name: String = OS.get_name()
	if os_name == "Android" or os_name == "iOS":
		var safe_area: Rect2i = DisplayServer.get_display_safe_area()
		
		topbar.position.y += safe_area.position.y
		topbar_bg.size.y += safe_area.position.y
		
		JumperUtility.add_log_message("Safe area: %s" % safe_area)
		JumperUtility.add_log_message("Window size: %s" % DisplayServer.window_get_size())


func _on_pause_button_pressed() -> void:
	pass # Replace with function body.
