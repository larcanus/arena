extends Node2D
var backgroundScene = Color('1e113c');
var battle_scene := preload("res://scenes/page/battle/battle.tscn");
var startBattleNotificationScene := preload("res://scenes/ui/start_battle_notification.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	changeScaleAspectToKeep();
	$AnimationPlayer.play('blackinScene')
	$AnimationPlayerBtn.play('battleIcon')
	$BackgroundColor.set_color(backgroundScene)
	$CanvasLayerMenu/PopupMenu.visible = false;
	$textLabelUserState.text = UserStoreGlobal.state.name + '  ' + JSON.stringify(UserStoreGlobal.state.controlOfElements);

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func changeScaleAspectToKeep():
	if(get_tree().root.content_scale_aspect != Window.CONTENT_SCALE_ASPECT_KEEP):
		get_tree().root.content_scale_aspect = Window.CONTENT_SCALE_ASPECT_KEEP;
		print('change scale_aspect = keep')

func _on_animation_player_animation_finished(anim_name):
	if anim_name == 'blackoutScene':
		print('out main scene')

	if anim_name == 'blackinScene':
		$CanvasLayerBk/BlackoutSceneColor.visible = false


func _on_battle_btn_pressed():
	print('on_battle_btn_pressed')
	if UserStoreGlobal.get_hp() < 100:
		var inst = startBattleNotificationScene.instantiate()
		add_child(inst);
		$StartBattleNotification/HBoxContainer/MarginContainer/ReturnButton.pressed.connect(_notification_battle_return_btn)
		$StartBattleNotification/HBoxContainer/MarginContainer2/GoButton.pressed.connect(_notification_battle_go_btn)
		return;

	get_tree().change_scene_to_packed(battle_scene);

func _notification_battle_return_btn():
	remove_child($StartBattleNotification);

func _notification_battle_go_btn():
	get_tree().change_scene_to_packed(battle_scene);

func _on_menu_btn_pressed():
	get_tree().paused = !get_tree().paused
	$CanvasLayerMenu/PopupMenu.visible = !$CanvasLayerMenu/PopupMenu.visible;

func _on_popup_menu_gui_input(event):
	if event is InputEventMouseButton and event.get_button_index():
		if $CanvasLayerMenu/PopupMenu.visible:
			get_tree().paused = !get_tree().paused
			$CanvasLayerMenu/PopupMenu.visible = !$CanvasLayerMenu/PopupMenu.visible;
