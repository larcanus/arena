extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	changeScaleAspectToKeep();
	setLvl();
	setXp();
	UserStoreSignals.update_exp.connect(_update_exp);
	UserStoreSignals.update_lvl.connect(setLvl);

func changeScaleAspectToKeep():
	if(get_tree().root.content_scale_aspect == Window.CONTENT_SCALE_ASPECT_KEEP):
		get_tree().root.content_scale_aspect = Window.CONTENT_SCALE_ASPECT_EXPAND;
		print('change scale_aspect = expand')

func setLvl():
	var lvlStr = User.get_string_lvl();
	get_node("ControlLvl/MarginContainer/VBoxContainer/LabelLvl").text = lvlStr;


func setXp():
	var lvlXp = User.get_exp();
	get_node("ControlLvl/MarginContainer/VBoxContainer/TextureProgressBar").value = lvlXp;


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_back_pressed():
	get_tree().change_scene_to_file('res://main.tscn')


func _on_butto_up_pressed():
	UserStateSignals.up_exp.emit(10)
	
func _update_exp(value):
	setXp();
