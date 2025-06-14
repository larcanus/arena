extends Control

func _ready():
	_update_position()
	get_tree().root.size_changed.connect(_update_position)
	BattleStoreGlobal.signals.battle_select_skill.connect(_on_battle_select_skill)


func _on_battle_select_skill(skill_id:int) -> void:
	print('BattleMoveControl._on_battle_select_skill ' + str(skill_id))
	var selected_skill_data = ItemStoreGlobal.get_item_by_id(skill_id)
	var texture = load(selected_skill_data.path)
	$TextureRect/TextureButton.texture_normal = texture

func _update_position():
	var viewport = get_viewport_rect().size
	var margin_x = viewport.x * 0.02
	var margin_y = viewport.y * 0.01

	var btn_size = Vector2(100, 50)

	position = Vector2(
		viewport.x - btn_size.x - margin_x,
		viewport.y - btn_size.y - margin_y
	)
	size = btn_size
