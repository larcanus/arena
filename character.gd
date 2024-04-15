extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	changeScaleAspectToKeep();
	setLvl();

func changeScaleAspectToKeep():
	if(get_tree().root.content_scale_aspect == Window.CONTENT_SCALE_ASPECT_KEEP):
		get_tree().root.content_scale_aspect = Window.CONTENT_SCALE_ASPECT_EXPAND;
		print('change scale_aspect = expand')

func setLvl():
	var lvlStr = User.get_string_lvl();
	get_node("MarginContainer4/VBoxContainer/LabelLvl").text = lvlStr;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_back_pressed():
	get_tree().change_scene_to_file('res://main.tscn')
