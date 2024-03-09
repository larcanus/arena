extends Node2D

var userName: String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	userName = User.state.name if User.state.name else ''
	$LineEdit.insert_text_at_caret(userName)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_button_change_pressed() -> void:
	print('on change')


func _on_button_change_avatar_pressed() -> void:
	print('on change ava')
	get_tree().change_scene_to_file('res://change_avatar.tscn')


func _on_button_change_family_pressed() -> void:
	print('on change family')


func _on_button_back_pressed() -> void:
	get_tree().change_scene_to_file('res://menu.tscn')


func _on_color_rect_focus_entered() -> void:
	$ButtonOk.grab_focus()


func _on_line_edit_text_changed(new_text: String) -> void:
	print(new_text)
	User.state.name = new_text;
