extends TextureButton
class_name ScreenButton

signal clicked(button: ScreenButton)


func _on_pressed() -> void:
	clicked.emit(self)
