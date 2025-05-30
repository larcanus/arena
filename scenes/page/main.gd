extends Node2D
var scene_background = Color('1e113c');
var battle_scene := preload("res://scenes/page/battle/battle.tscn");
var start_battle_notification_scene := preload("res://scenes/ui/start_battle_notification.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	on_change_scale();
	$AnimationPlayer.play('blackinScene')
	$BackgroundSprite/ButtonsControl/AnimationPlayerBtn.play('battleIcon')
	$BackgroundColor.set_color(scene_background)
	$CanvasLayerMenu/PopupMenu.visible = false;
	$textLabelUserState.text = UserStoreGlobal.state.name + '  ' + JSON.stringify(UserStoreGlobal.state.controlOfElements);

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func on_change_scale():
	get_tree().get_root().size_changed.connect(_on_resize)
	# Первоначальное масштабирование
	_on_resize()

	#if(get_tree().root.content_scale_aspect != Window.CONTENT_SCALE_ASPECT_KEEP):
		#get_tree().root.content_scale_aspect = Window.CONTENT_SCALE_ASPECT_KEEP;
		#print('change scale_aspect = keep')

func _on_resize():
	var viewport_size = get_viewport_rect().size
	var texture_size = $BackgroundSprite.texture.get_size()

	# Рассчитываем нужный масштаб
	var scale_x = viewport_size.x / texture_size.x
	var scale_y = viewport_size.y / texture_size.y

	# Берём максимальный масштаб, чтобы закрыть все зоны
	var target_scale = max(scale_x, scale_y)
	# Применяем масштаб
	$BackgroundSprite.scale = Vector2(target_scale, target_scale)
	# Центрируем спрайт
	$BackgroundSprite.position = viewport_size / 2
	#print(target_scale)
	#print($ButtonsControl.position)
	#$BackgroundSprite/ButtonsControl.scale = Vector2(target_scale, target_scale)
	#$ButtonsControl/BattleBtn.scale = Vector2(target_scale, target_scale)
	#$ButtonsControl/SpellBtn.scale = Vector2(target_scale, target_scale)
	$CanvasLayerMenu/MenuBtn.scale = Vector2(target_scale, target_scale)
	#var sizeX = $BackgroundSprite/ButtonsControl.size.x
	#$BackgroundSprite/ButtonsControl.position = Vector2(viewport_size.x/2 - (sizeX/2),viewport_size.y/2)
	print($BackgroundSprite/ButtonsControl.size)

func _on_animation_player_animation_finished(anim_name):
	if anim_name == 'blackoutScene':
		print('out main scene')

	if anim_name == 'blackinScene':
		$CanvasLayerBk/BlackoutSceneColor.visible = false


func _on_battle_btn_pressed():
	print('on_battle_btn_pressed')
	if UserStoreGlobal.get_hp() < 100:
		var inst = start_battle_notification_scene.instantiate()
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
