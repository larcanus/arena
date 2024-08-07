extends Control
var backgroundScene = Color('1e113c');

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if User.state.name.length() > 1:
		$CanvasLayer/"ButtonСontinue".visible = true;
	else :
		$CanvasLayer/"ButtonСontinue".visible = false;

	$AnimationPlayer.play('blackinScene')
	$Background.set_color(backgroundScene)


func on_press_btn_new_game():
	User.clearState();
	$CanvasLayer/BlackoutScene.visible = true
	$AnimationPlayer.play('blackoutScene')
	


func _on_animation_player_animation_finished(anim_name):
	if anim_name == 'blackoutScene':
		if User.state.isNewUser == true:
			get_tree().change_scene_to_file('res://create_user.tscn')
		else:
			get_tree().change_scene_to_file('res://main.tscn')
		
	if anim_name == 'blackinScene':
		$CanvasLayer/BlackoutScene.visible = false
	


func _on_button_re_pressed():
	$CanvasLayer/BlackoutScene.visible = true
	$AnimationPlayer.play('blackoutScene')
