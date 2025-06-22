extends Node2D


func _ready() -> void:
	on_change_scale();


func on_change_scale():
	get_tree().get_root().size_changed.connect(_on_resize)
	_on_resize()


func _on_resize():
	var viewport_size = get_viewport_rect().size
	var texture_size = $Background.texture.get_size()
	var scale_x = viewport_size.x / texture_size.x
	var scale_y = viewport_size.y / texture_size.y
	var target_scale = max(scale_x, scale_y)

	$Background.scale = Vector2(target_scale, target_scale)
	var position_y = viewport_size.y / 2;
	var position_x = (viewport_size.x / 5) * 3.1;
	$Background.position = Vector2(position_x, position_y)


func _on_button_pressed() -> void:
	var hp = UserStoreGlobal.get_hp() - 5
	UserStoreGlobal.state_controller.change_hp(hp)


func _on_button_restore_pressed() -> void:
	UserStoreGlobal.state_controller.change_hp(UserStoreGlobal.get_max_hp())


func _on_button_mp_pressed() -> void:
	var mp = UserStoreGlobal.get_mp() - 5
	UserStoreGlobal.state_controller.change_mp(mp)


func _on_button_restore_mp_pressed() -> void:
	UserStoreGlobal.state_controller.change_mp(UserStoreGlobal.get_max_mp())


func _on_button_enemy_pressed() -> void:
	var hp = EnemyStoreGlobal.get_hp() - 5
	EnemyStoreGlobal.state_controller.change_hp(hp)


func _on_button_restore_enemy_pressed() -> void:
	EnemyStoreGlobal.state_controller.change_hp(EnemyStoreGlobal.get_max_hp())


func _on_button_mpenemy_pressed() -> void:
	var mp = EnemyStoreGlobal.get_mp() - 5
	EnemyStoreGlobal.state_controller.change_mp(mp)


func _on_button_restore_mp_enemy_pressed() -> void:
	EnemyStoreGlobal.state_controller.change_mp(EnemyStoreGlobal.get_max_mp())
