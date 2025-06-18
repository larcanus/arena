extends Control

func _ready() -> void:
	on_change_scale();


func on_change_scale():
	get_tree().get_root().size_changed.connect(_update_position)
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
