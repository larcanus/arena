extends Node2D
var backgroundScene = Color('1e113c');

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$ColorRect.set_color(backgroundScene)
	$AnimatedRectScene.visible = false


func on_press_btn_new_game():
	$AnimatedRectScene.visible = true
	$AnimationPlayer.play('blackoutScene')
	


func _on_animation_player_animation_finished(name):
	get_tree().change_scene_to_file('res://create_user.tscn')
