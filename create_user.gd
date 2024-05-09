extends Control

var userName: String
var backgroundScene = Color('1e113c');
var controlOfElementsAvailable = User.get_controlOfElementsAvailable();

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	User.state.isNewUser = true;
	userName = User.state.name if User.state.name else ''
	
	$AnimationPlayer.play('blackinScene');
	$Background.set_color(backgroundScene)
	$BorderInput/InputName.insert_text_at_caret(userName)
	$ElementsTable/ElementsTable.set_scale(Vector2(0.5, 0.5));
	handlerButtonOk();
	subscribeEvent();


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func subscribeEvent():
	UserStoreSignals.update_available_control_count.connect(_update_available_control_count);


func handlerButtonOk() -> void:
	if checkReadyScene() == true:
		$ButtonOk.set_disabled(false);
		$ButtonOk/LabelButtonOk.set("theme_override_colors/font_color",Color("ffffff"))
	else:
		$ButtonOk.set_disabled(true);
		$ButtonOk/LabelButtonOk.set("theme_override_colors/font_color",Color("ffffff77"))

func checkReadyScene() -> bool:
	if User.state.name.length() > 1 && get_controlOfElementsAvailable() == 0:
		return true;
	else :
		return false;

func get_controlOfElementsAvailable() -> int:
	return User.state.controlOfElementsAvailable;;

func _update_available_control_count(value) -> void:
	handlerButtonOk();

func _on_button_change_pressed() -> void:
	print('on change')


func _on_button_change_avatar_pressed() -> void:
	print('on change ava')
	get_tree().change_scene_to_file('res://change_avatar.tscn')


func _on_button_change_family_pressed() -> void:
	print('on change family')


func _on_button_back_pressed() -> void:
	User.state.controlOfElementsAvailable = controlOfElementsAvailable;
	$BlackoutScene.visible = true;
	$AnimationPlayer.play('blackoutScene');


func _on_color_rect_focus_entered() -> void:
	$ButtonOk.grab_focus()


func _on_line_edit_text_changed(new_text: String) -> void:
	print('_on_line_edit_text_changed' + new_text)
	User.state.name = new_text;
	handlerButtonOk()


func _on_button_ok_pressed():
	User.state.isNewUser = false;
	print('user ready: ', User.state.name, User.state.controlOfElements)
	get_tree().change_scene_to_file('res://main.tscn')


func _on_animation_player_animation_finished(anim_name):
	print(anim_name)
	if anim_name == 'blackoutScene':
		get_tree().change_scene_to_file('res://menu.tscn')
		
	if anim_name == 'blackinScene':
		$BlackoutScene.visible = false


func _on_input_name_text_submitted(new_text):
	User.state.name = new_text;
	handlerButtonOk();


func _on_input_name_text_change_rejected(value):
	print(value)
	User.state.name = $BorderInput/InputName.get_text();
	handlerButtonOk();


func _on_input_name_focus_entered():
	User.state.name = $BorderInput/InputName.get_text();
	handlerButtonOk();


func _on_input_name_focus_exited():
	User.state.name = $BorderInput/InputName.get_text();
	handlerButtonOk();
