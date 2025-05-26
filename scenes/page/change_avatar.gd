extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func _on_texture_button_pressed() -> void:
	get_tree().change_scene_to_file('res://scenes/page/create_user.tscn')


func _on_item_list_item_selected(index: int) -> void:
	var icon = $ItemList.get_item_icon(index)
	UserStoreGlobal.set_avatar_path(icon.get_load_path())

func _on_color_rect_gui_input(event):
	if event is InputEventMouseButton and event.get_button_index():
		get_tree().change_scene_to_file('res://scenes/page/create_user.tscn')
