extends Control

@onready var progress = $MarginContainer/VBoxContainer/HBoxContainer/Control/MarginContainer
@onready var border = $MarginContainer/VBoxContainer/HBoxContainer/Control/HPBarUserLeft
var should_fix_progress_bar = false;

func _ready() -> void:
	await get_tree().process_frame
	on_change_scale();
	UserStoreGlobal.signals.change_hp.connect(_on_change_hp)
	get_tree().get_root().size_changed.connect(_update_position)
	TimerGlobal.add_callback(_on_global_timer_callback);

func _on_change_hp():
	update_hp()

func _on_global_timer_callback():
	if should_fix_progress_bar == true:
		should_fix_progress_bar = false
		print('Force update progress bar')
		update_hp()


func on_change_scale():
	print('on_change_scale')
	should_fix_progress_bar = true;
	_update_position()
	update_hp()

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
	update_hp()


func update_hp():
	var percent_margin = border.size.x * 0.03  # 3% от ширины
	print('percent_margin ' + str(percent_margin))
	progress.add_theme_constant_override("margin_left", percent_margin)
	progress.add_theme_constant_override("margin_right", percent_margin)

	var bar_size_x = border.size.x # 100%
	var max_hp = UserStoreGlobal.get_max_hp();
	var hp = UserStoreGlobal.get_hp();
	progress.visible = true;

	var size_progress_x = hp * (bar_size_x/100);
	if not hp == max_hp and not hp == 0:
		size_progress_x = hp * (bar_size_x/100) + percent_margin;

	if hp == 0:
		size_progress_x = 0
		progress.get_child(0).size.x = 0
		progress.custom_minimum_size.x = 0
		progress.get_child(0).custom_minimum_size.x = 0
		progress.add_theme_constant_override("margin_left", 0)
		progress.add_theme_constant_override("margin_right", 0)
		progress.visible = false;

	progress.size.x = float(size_progress_x);
	progress.position.x = 0;
	print("Frame %d: HP=%d Size=%.1f ChildSize=%.1f" % [
	Engine.get_frames_drawn(),
	hp,
	progress.size.x,
	progress.get_child(0).size.x
	])
