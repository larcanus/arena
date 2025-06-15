extends Control

func _ready():
	_update_position()
	get_tree().root.size_changed.connect(_update_position)
	bind_signals()


func bind_signals() -> void:
	BattleStoreGlobal.signals.select_skill.connect(_on_battle_select_skill)
	BattleStoreGlobal.signals.is_move.connect(_on_battle_is_move)


func is_battle_move() -> bool:
	return BattleStoreGlobal.is_move();

func _on_battle_select_skill(skill_id:int) -> void:
	print('BattleMoveControl._on_battle_select_skill ' + str(skill_id))
	var selected_skill_data = ItemStoreGlobal.get_item_by_id(skill_id)
	var texture = load(selected_skill_data.path)
	$Skil.texture = texture

func _on_battle_is_move()-> void:
	print('_on_battle_is_move')

func _update_position():
	var viewport = get_viewport_rect().size
	var margin_x = viewport.x * 0.01
	var margin_y = viewport.y * 0.01

	var btn_size = Vector2(300, 300)
	position = Vector2(
		viewport.x - btn_size.x - margin_x,
		viewport.y - btn_size.y - margin_y
	)
	size = btn_size


func _on_button_pressed() -> void:
	print('_on_button_pressed')
	if not is_battle_move():
		animate_icon_click()
		BattleStoreGlobal.state_controller.start_move();
		BattleStoreGlobal.state_controller.add_log('system', 'move press');

var is_animating = false
func animate_icon_click():
	if is_animating:
		return

	is_animating = true
	var tween = create_tween().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	var click_scale = Vector2(0.85, 0.85)
	var original_pos = position
	var original_scale = scale
	var offset = (self.size * (1.0 - click_scale.x)) / 2

	tween.tween_property(self, "scale", click_scale, 0.06)
	tween.parallel().tween_property(self, "position", original_pos + offset, 0.06)

	tween.tween_property(self, "scale", original_scale, 0.06)
	tween.parallel().tween_property(self, "position", original_pos, 0.06)

	tween.finished.connect(func(): is_animating = false)
