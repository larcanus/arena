extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func changeScaleAspectToExpand():
	if(get_tree().root.content_scale_aspect == Window.CONTENT_SCALE_ASPECT_KEEP):
		get_tree().root.content_scale_aspect = Window.CONTENT_SCALE_ASPECT_EXPAND;
		print('change scale_aspect = expand')

func _on_texture_button_pressed():
	changeScaleAspectToExpand();
	get_tree().paused = false;
	get_tree().change_scene_to_file('res://scenes/page/menu.tscn')
