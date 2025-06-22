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

func _ready() -> void:
	await get_tree().process_frame
	on_change_scale();
	UserStoreGlobal.signals.change_hp.connect(_on_user_change_hp)
	UserStoreGlobal.signals.change_mp.connect(_on_user_change_mp)
	EnemyStoreGlobal.signals.change_hp.connect(_on_enemy_change_hp)
	EnemyStoreGlobal.signals.change_mp.connect(_on_enemy_change_mp)
	get_tree().get_root().size_changed.connect(_update_position)
	TimerGlobal.add_callback(_on_global_timer_callback);

func _on_user_change_hp(value):
	print('_on_user_change_hp')
	update_user_hp()

func _on_user_change_mp(value):
	update_user_mp()

func _on_enemy_change_hp(value):
	print('_on_enemy_change_hp')
	update_enemy_hp()

func _on_enemy_change_mp(value):
	update_enemy_mp()

func _on_global_timer_callback():
	if should_fix_progress_bar == true:
		should_fix_progress_bar = false
		print('Force update progress bar')
		update_user_hp()
		update_user_mp()
		update_enemy_hp()
		update_enemy_mp()


func on_change_scale():
	print('on_change_scale')
	should_fix_progress_bar = true;
	_update_position()
	update_user_hp()
	update_user_mp()
	update_enemy_hp()
	update_enemy_mp()

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
	update_user_hp()
	update_user_mp()
	update_enemy_hp()
	update_enemy_mp()


func update_user_hp():
	var percent_margin = border_hp.size.x * 0.03  # 3% от ширины
	progress_hp.add_theme_constant_override("margin_left", percent_margin)
	progress_hp.add_theme_constant_override("margin_right", percent_margin)

	var bar_size_x = border_hp.size.x # 100%
	var max_hp = UserStoreGlobal.get_max_hp();
	var hp = UserStoreGlobal.get_hp();
	count_hp.text = str(hp) + '/' + str(max_hp);
	progress_hp.visible = true;

	var size_progress_x = hp * (bar_size_x/100);
	if not hp == max_hp and not hp == 0:
		size_progress_x = hp * (bar_size_x/100) + percent_margin;

	if hp == 0:
		size_progress_x = 0
		progress_hp.get_child(0).size.x = 0
		progress_hp.custom_minimum_size.x = 0
		progress_hp.get_child(0).custom_minimum_size.x = 0
		progress_hp.add_theme_constant_override("margin_left", 0)
		progress_hp.add_theme_constant_override("margin_right", 0)
		progress_hp.visible = false;

	progress_hp.size.x = float(size_progress_x);
	progress_hp.position.x = 0;
	print("Frame %d: HP=%d Size=%.1f ChildSize=%.1f" % [
	Engine.get_frames_drawn(),
	hp,
	progress_hp.size.x,
	progress_hp.get_child(0).size.x
	])

func update_user_mp():
	var percent_margin = border_mp.size.x * 0.03  # 3% от ширины
	progress_mp.add_theme_constant_override("margin_left", percent_margin)
	progress_mp.add_theme_constant_override("margin_right", percent_margin)

	var bar_size_x = border_mp.size.x # 100%
	var max_mp = UserStoreGlobal.get_max_mp();
	var mp = UserStoreGlobal.get_mp();
	count_mp.text = str(mp) + '/' + str(max_mp);
	progress_mp.visible = true;

	var size_progress_x = mp * (bar_size_x/100);
	if not mp == max_mp and not mp == 0:
		size_progress_x = mp * (bar_size_x/100) + percent_margin;

	if mp == 0:
		size_progress_x = 0
		progress_mp.get_child(0).size.x = 0
		progress_mp.custom_minimum_size.x = 0
		progress_mp.get_child(0).custom_minimum_size.x = 0
		progress_mp.add_theme_constant_override("margin_left", 0)
		progress_mp.add_theme_constant_override("margin_right", 0)
		progress_mp.visible = false;

	progress_mp.size.x = float(size_progress_x);
	progress_mp.position.x = 0;
	print("Frame %d: MP=%d Size=%.1f ChildSize=%.1f" % [
	Engine.get_frames_drawn(),
	mp,
	progress_mp.size.x,
	progress_mp.get_child(0).size.x
	])


func update_enemy_hp():
	print('Update_enemy_hp')
	var percent_margin = enemy_border_hp.size.x * 0.03  # 3% от ширины
	enemy_progress_hp.add_theme_constant_override("margin_left", percent_margin)
	enemy_progress_hp.add_theme_constant_override("margin_right", percent_margin)

	var bar_size_x = enemy_border_hp.size.x # 100%
	var max_hp = EnemyStoreGlobal.get_max_hp();
	var hp = EnemyStoreGlobal.get_hp();
	enemy_count_hp.text = str(hp) + '/' + str(max_hp);
	enemy_progress_hp.visible = true;

	var size_progress_x = hp * (bar_size_x/100);
	if not hp == max_hp and not hp == 0:
		size_progress_x = hp * (bar_size_x/100) + percent_margin;

	if hp == 0:
		size_progress_x = 0
		enemy_progress_hp.get_child(0).size.x = 0
		enemy_progress_hp.custom_minimum_size.x = 0
		enemy_progress_hp.get_child(0).custom_minimum_size.x = 0
		enemy_progress_hp.add_theme_constant_override("margin_left", 0)
		enemy_progress_hp.add_theme_constant_override("margin_right", 0)
		enemy_progress_hp.visible = false;

	enemy_progress_hp.size.x = float(size_progress_x);
	enemy_progress_hp.position.x = 0;
	print("Update_enemy_hp Frame %d: HP=%d Size=%.1f ChildSize=%.1f" % [
	Engine.get_frames_drawn(),
	hp,
	enemy_progress_hp.size.x,
	enemy_progress_hp.get_child(0).size.x
	])

func update_enemy_mp():
	var percent_margin = enemy_border_mp.size.x * 0.03  # 3% от ширины
	enemy_progress_mp.add_theme_constant_override("margin_left", percent_margin)
	enemy_progress_mp.add_theme_constant_override("margin_right", percent_margin)

	var bar_size_x = border_mp.size.x # 100%
	var max_mp = EnemyStoreGlobal.get_max_mp();
	var mp = EnemyStoreGlobal.get_mp();
	enemy_count_mp.text = str(mp) + '/' + str(max_mp);
	enemy_progress_mp.visible = true;

	var size_progress_x = mp * (bar_size_x/100);
	if not mp == max_mp and not mp == 0:
		size_progress_x = mp * (bar_size_x/100) + percent_margin;

	if mp == 0:
		size_progress_x = 0
		enemy_progress_mp.get_child(0).size.x = 0
		enemy_progress_mp.custom_minimum_size.x = 0
		enemy_progress_mp.get_child(0).custom_minimum_size.x = 0
		enemy_progress_mp.add_theme_constant_override("margin_left", 0)
		enemy_progress_mp.add_theme_constant_override("margin_right", 0)
		enemy_progress_mp.visible = false;

	enemy_progress_mp.size.x = float(size_progress_x);
	enemy_progress_mp.position.x = 0;
	print("Frame %d: MP=%d Size=%.1f ChildSize=%.1f" % [
	Engine.get_frames_drawn(),
	mp,
	enemy_progress_mp.size.x,
	enemy_progress_mp.get_child(0).size.x
	])
