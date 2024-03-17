extends Node2D
var backgroundScene = Color('1e113c');

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimationPlayer.play('blackinScene')
	$Background.set_color(backgroundScene)


func on_press_btn_new_game():
	$BlackoutScene.visible = true
	$AnimationPlayer.play('blackoutScene')
	


func _on_animation_player_animation_finished(anim_name):
	if anim_name == 'blackoutScene':
		get_tree().change_scene_to_file('res://create_user.tscn')
		
	if anim_name == 'blackinScene':
		$BlackoutScene.visible = false
	
