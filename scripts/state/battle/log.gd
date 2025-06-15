class_name LogState extends RefCounted

var type: String
var text: String
var timestamp: float

func _init(p_type: String, p_text: String) -> void:
	type = p_type
	text = p_text
	timestamp = Time.get_unix_time_from_system()
