extends Control


func _ready():
	$MenuContainer.visible = false;

func _on_menu_btn_pressed() -> void:
	get_tree().paused = !get_tree().paused
	$MenuContainer.visible = !$MenuContainer.visible;

func _on_background_gui_input(event):
	if event is InputEventMouseButton and event.get_button_index():
		get_tree().paused = !get_tree().paused
		$MenuContainer.visible = !$MenuContainer.visible;


func _on_button_1_pressed():
	get_tree().paused = false;
	get_tree().change_scene_to_file('res://scenes/page/menu.tscn')


func _on_button_2_pressed() -> void:
	pass;
