extends Control

@onready var progress_hp = $MarginContainer/VBoxContainer/HBoxHP/HPLeft/Margins
@onready var border_hp = $MarginContainer/VBoxContainer/HBoxHP/HPLeft/Border
@onready var count_hp = $MarginContainer/VBoxContainer/HBoxHP/HPLeft/Count
@onready var progress_mp = $MarginContainer/VBoxContainer/HBoxMP/MPLeft/Margins
@onready var border_mp = $MarginContainer/VBoxContainer/HBoxMP/MPLeft/Border
@onready var count_mp = $MarginContainer/VBoxContainer/HBoxMP/MPLeft/Count
@onready var enemy_progress_hp = $MarginContainer/VBoxContainer/HBoxHP/HPRight/Margins
@onready var enemy_border_hp = $MarginContainer/VBoxContainer/HBoxHP/HPRight/Border
@onready var enemy_count_hp = $MarginContainer/VBoxContainer/HBoxHP/HPRight/Count
@onready var enemy_progress_mp = $MarginContainer/VBoxContainer/HBoxMP/MPRight/Margins
@onready var enemy_border_mp = $MarginContainer/VBoxContainer/HBoxMP/MPRight/Border
@onready var enemy_count_mp = $MarginContainer/VBoxContainer/HBoxMP/MPRight/Count

var should_fix_progress_bar = false;
var health_material: ShaderMaterial

func _ready() -> void:
	await get_tree().process_frame
	on_change_scale();
	UserStoreGlobal.signals.change_hp.connect(_on_user_change_hp)
	UserStoreGlobal.signals.change_mp.connect(_on_user_change_mp)
	EnemyStoreGlobal.signals.change_hp.connect(_on_enemy_change_hp)
	EnemyStoreGlobal.signals.change_mp.connect(_on_enemy_change_mp)
	get_tree().get_root().size_changed.connect(_update_position)
	TimerGlobal.add_callback(_on_global_timer_callback);


func add_blink_shader(node):
	node.material = ShaderMaterial.new()
	health_material = node.material
	health_material.shader = preload("res://assets/shaders/raund-state-panel-blink.gdshader")


func _on_user_change_hp(value):
	update_user_hp()

func _on_user_change_mp(value):
	update_user_mp()

func _on_enemy_change_hp(value):
	update_enemy_hp()

func _on_enemy_change_mp(value):
	update_enemy_mp()


func update_all_bars():
	update_user_hp()
	update_user_mp()
	update_enemy_hp()
	update_enemy_mp()

func _on_global_timer_callback():
	if should_fix_progress_bar == true:
		should_fix_progress_bar = false
		print('Force update progress bar')
		update_all_bars()

func on_change_scale():
	print('on_change_scale')
	should_fix_progress_bar = true;
	_update_position()

@export var width_ratio: float = 0.60    # Ширина панели (60% от ширины экрана)
@export var min_width: float = 400       # Минимальная ширина в пикселях
@export var height_pixels: float = 140    # Фиксированная высота в пикселях
@export var top_margin_ratio: float = 0.02  # Отступ от верха (2% от высоты экрана)
@export var center_offset_ratio: float = 0.117 # Смещение от центра (12% вправо)

func _update_position():
	var viewport = get_viewport_rect().size
	var panel_width = max(viewport.x * width_ratio, min_width)
	var panel_height = height_pixels
	var pos_y = viewport.y * top_margin_ratio
	var pos_x = (viewport.x * 0.5) + (viewport.x * center_offset_ratio) - (panel_width * 0.5)

	size = Vector2(panel_width, panel_height)
	position = Vector2(pos_x, pos_y)

	should_fix_progress_bar = true;
	update_all_bars()


func update_user_hp():
	_update_progress_bar(
		progress_hp,
		border_hp,
		count_hp,
		UserStoreGlobal.get_hp(),
		UserStoreGlobal.get_max_hp(),
		false
	)
	enable_hp_blink_shader()

func update_user_mp():
	_update_progress_bar(
		progress_mp,
		border_mp,
		count_mp,
		UserStoreGlobal.get_mp(),
		UserStoreGlobal.get_max_mp(),
		false
	)

func update_enemy_hp():
	_update_progress_bar(
		enemy_progress_hp,
		enemy_border_hp,
		enemy_count_hp,
		EnemyStoreGlobal.get_hp(),
		EnemyStoreGlobal.get_max_hp(),
		true
	)

func update_enemy_mp():
	_update_progress_bar(
		enemy_progress_mp,
		enemy_border_mp,
		enemy_count_mp,
		EnemyStoreGlobal.get_mp(),
		EnemyStoreGlobal.get_max_mp(),
		true
	)

func _update_progress_bar(progress, border, count_label, current_value, max_value, is_enemy):
	if border.size.x <= 0:
		return

	var percent_margin = border.size.x * 0.03
	progress.add_theme_constant_override("margin_left", percent_margin)
	progress.add_theme_constant_override("margin_right", percent_margin)

	var bar_size_x = border.size.x
	count_label.text = "%d/%d" % [current_value, max_value]
	progress.visible = true

	var size_progress_x = current_value * (bar_size_x / 100.0)

	if not current_value == max_value and not current_value == 0:
		size_progress_x += percent_margin

	if current_value == 0:
		size_progress_x = 0
		progress.get_child(0).size.x = 0
		progress.custom_minimum_size.x = 0
		progress.get_child(0).custom_minimum_size.x = 0
		progress.add_theme_constant_override("margin_left", 0)
		progress.add_theme_constant_override("margin_right", 0)
		progress.visible = false

	progress.size.x = float(size_progress_x)

	if is_enemy:
		progress.position.x = border.position.x + bar_size_x - progress.size.x
	else:
		progress.position.x = 0

	print("Update %s Frame %d: Value=%d Size=%.1f ChildSize=%.1f" % [
		progress.name,
		Engine.get_frames_drawn(),
		current_value,
		progress.size.x,
		progress.get_child(0).size.x
	])

func enable_hp_blink_shader():
	var current_value =	UserStoreGlobal.get_hp();
	var max_value =	UserStoreGlobal.get_max_hp();
	var hp_percent = float(current_value) / float(max_value)
	if hp_percent <= 0.3:
		set_blinking(true)
		return
	if hp_percent < 0.1:
		health_material.set_shader_parameter("intensity", 0.6)
		return
	else:
		set_blinking(false)


func set_blinking(active: bool):
	if not health_material:
		add_blink_shader(progress_hp.get_child(0))

	if active:
		health_material.set_shader_parameter("speed", 6.0)
		health_material.set_shader_parameter("intensity", 0.5)
	else:
		health_material.set_shader_parameter("intensity", 0.0)
