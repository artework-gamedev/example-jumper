extends Node

func add_log_message(log_msg: String) -> void:
	var console: Control = get_tree().get_first_node_in_group("debug_console")
	if not console:
		return
	var log_label: Label = console.find_child("LogLabel")
	if not log_label:
		return
	log_label.text += "%s\n" % log_msg
