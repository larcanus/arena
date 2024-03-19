extends Node2D
var backgroundScene = Color('1e113c');


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play('blackinScene')
	$AnimationPlayerBtn.play('battleIcon')
	$BackgroundColor.set_color(backgroundScene)
	$textLabelUserState.text = User.state.name + '  ' + JSON.stringify(User.state.controlOfElements);


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_animation_player_animation_finished(anim_name):
	if anim_name == 'blackoutScene':
		print('out main scene')
		
	if anim_name == 'blackinScene':
		$BlackoutSceneColor.visible = false


func _on_battle_btn_pressed():
	print('on_battle_btn_pressed')
