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
