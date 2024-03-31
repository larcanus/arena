extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func changeScaleAspectToExpand():
	if(get_tree().root.content_scale_aspect == 1):
		get_tree().root.content_scale_aspect = 4;
		print('change scale_aspect = expand')

func _on_texture_button_pressed():
	changeScaleAspectToExpand();
	get_tree().paused = false;
	get_tree().change_scene_to_file('res://menu.tscn')
