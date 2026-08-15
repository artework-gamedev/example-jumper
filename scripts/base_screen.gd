extends Control
class_name BaseScreen

const _TWEEN_LENGTH = 0.5 #seconds

func _ready() -> void:
	visible = false
	modulate.a = 0.0

func appear() -> Tween:
	visible = true
	var tween: Tween = get_tree().create_tween()
	tween.tween_property(self, "modulate:a", 1.0, _TWEEN_LENGTH)
	return tween


func disappear() -> Tween:
	var tween: Tween = get_tree().create_tween()
	tween.tween_property(self, "modulate:a", 0.0, _TWEEN_LENGTH)
	tween.tween_callback(_make_invisible)
	return tween


func _make_invisible() -> void:
	visible = false
