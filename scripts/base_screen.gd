extends Control
class_name BaseScreen

const _TWEEN_LENGTH = 0.5 #seconds

func _ready() -> void:
	# Disable all buttons at game start
	get_tree().call_group("buttons", "set_disabled", true)
	
	# All screens are invisible at game start
	visible = false
	modulate.a = 0.0

func appear() -> Tween:
	# Animate fading in
	visible = true
	var tween: Tween = get_tree().create_tween()
	tween.tween_property(self, "modulate:a", 1.0, _TWEEN_LENGTH)
	tween.tween_callback(_on_appear_finished)
	return tween


func disappear() -> Tween:
	# Disable all buttons before animating
	get_tree().call_group("buttons", "set_disabled", true)
	
	# Animate fading out
	var tween: Tween = get_tree().create_tween()
	tween.tween_property(self, "modulate:a", 0.0, _TWEEN_LENGTH)
	tween.tween_callback(_on_disappear_finished)
	return tween


func _on_disappear_finished() -> void:
	visible = false


func _on_appear_finished() -> void:
	get_tree().call_group("buttons", "set_disabled", false)
	
