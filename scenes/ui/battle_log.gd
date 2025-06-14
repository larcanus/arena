extends Control

@onready var log_container = $ScrollContainer/LogContent

func _ready():
	_update_size()
	get_tree().root.size_changed.connect(_update_size)
	connect("resized", _update_margins)

	TimerGlobal.add_callback(add_log_message);

func _update_size():
	var viewport_size = get_viewport_rect().size
	custom_minimum_size = Vector2(viewport_size.x * 0.25, viewport_size.y)
	_update_margins()
	add_log_message('_update_size' + JSON.stringify(viewport_size))


func _update_margins():
	if not is_inside_tree():
		await ready

	var margin_lef_right_px = self.size * 0.1
	var margin_top_bottom_px = self.size * 0.05
	$ScrollContainer.set("offset_left", margin_lef_right_px.x)
	$ScrollContainer.set("offset_right", -margin_lef_right_px.x)
	$ScrollContainer.set("offset_top", margin_top_bottom_px.y)
	$ScrollContainer.set("offset_bottom", -margin_top_bottom_px.y)

	$ScrollContainer.queue_redraw()


func add_log_message(text: String = 'log_message'):
	var label = Label.new()
	label.text = text
	label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	label.horizontal_alignment = HORIZONTAL_ALIGNMENT_LEFT
	label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	log_container.add_child(label)

	await get_tree().process_frame
	$ScrollContainer.scroll_vertical = $ScrollContainer.get_v_scroll_bar().max_value
