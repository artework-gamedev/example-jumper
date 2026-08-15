extends Control
class_name BaseScreen

func _ready() -> void:
	visible = false


func appear() -> void:
	visible = true


func disappear() -> void:
	visible = false
