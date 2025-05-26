extends Control

var user_name: String
var scene_background = Color('1e113c');

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	UserStoreGlobal.state.isNewUser = true;
	user_name = UserStoreGlobal.state.name if UserStoreGlobal.state.name else ''

	$AnimationPlayer.play('blackinScene');
	$Background.set_color(scene_background)
	$BorderInput/InputName.insert_text_at_caret(user_name)
	$ElementsTable/ElementsTable.set_scale(Vector2(0.5, 0.5));
	handler_button_ok();
	subscribe_event();

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func subscribe_event():
	UserStoreGlobal.signals.update_available_control_count.connect(_update_available_control_count);


func handler_button_ok() -> void:
	if is_scene_ready() == true:
		$ButtonOk.set_disabled(false);
		$ButtonOk/LabelButtonOk.set("theme_override_colors/font_color",Color("ffffff"))
	else:
		$ButtonOk.set_disabled(true);
		$ButtonOk/LabelButtonOk.set("theme_override_colors/font_color",Color("ffffff77"))

func is_scene_ready() -> bool:
	if UserStoreGlobal.state.name.length() > 1 && get_controlOfElementsAvailable() == 0:
		return true;
	else :
		return false;

func get_controlOfElementsAvailable() -> int:
	return UserStoreGlobal.get_controlOfElementsAvailable();

func _update_available_control_count(value) -> void:
	handler_button_ok();

func _on_button_change_pressed() -> void:
	print('on change')


func _on_button_change_avatar_pressed() -> void:
	print('on change ava')
	get_tree().change_scene_to_file('res://scenes/page/change_avatar.tscn')


func _on_button_change_family_pressed() -> void:
	print('on change family')


func _on_button_back_pressed() -> void:
	$BlackoutScene.visible = true;
	$AnimationPlayer.play('blackoutScene');


func _on_color_rect_focus_entered() -> void:
	$ButtonOk.grab_focus()


func _on_line_edit_text_changed(new_text: String) -> void:
	print('_on_line_edit_text_changed' + new_text)
	UserStoreGlobal.state.name = new_text;
	handler_button_ok()


func _on_button_ok_pressed():
	UserStoreGlobal.state.isNewUser = false;
	print('user ready: ', UserStoreGlobal.state.name, UserStoreGlobal.state.controlOfElements)
	get_tree().change_scene_to_file('res://scenes/page/main.tscn')


func _on_animation_player_animation_finished(anim_name):
	print(anim_name)
	if anim_name == 'blackoutScene':
		get_tree().change_scene_to_file('res://scenes/page/menu.tscn')

	if anim_name == 'blackinScene':
		$BlackoutScene.visible = false


func _on_input_name_text_submitted(new_text):
	UserStoreGlobal.state.name = new_text;
	handler_button_ok();


func _on_input_name_text_change_rejected(value):
	print(value)
	UserStoreGlobal.state.name = $BorderInput/InputName.get_text();
	handler_button_ok();


func _on_input_name_focus_entered():
	UserStoreGlobal.state.name = $BorderInput/InputName.get_text();
	handler_button_ok();


func _on_input_name_focus_exited():
	UserStoreGlobal.state.name = $BorderInput/InputName.get_text();
	handler_button_ok();
