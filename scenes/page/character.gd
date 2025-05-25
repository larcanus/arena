extends Control

var tableInfoPathNode = 'ControlStateInfo/MarginContainer/ScrollContainer/TableColumn/'

# Called when the node enters the scene tree for the first time.
func _ready():
	changeScaleAspectToKeep();
	set_lvl();
	setXp();
	setName();
	setInfoState();
	subscribeSignals();

func changeScaleAspectToKeep():
	if(get_tree().root.content_scale_aspect == Window.CONTENT_SCALE_ASPECT_KEEP):
		get_tree().root.content_scale_aspect = Window.CONTENT_SCALE_ASPECT_EXPAND;
		print('change scale_aspect = expand')

func _on_signal_set_lvl() -> void:
	set_lvl();

func set_lvl():
	var lvlStr = UserStoreGlobal.get_string_lvl();
	get_node("ControlLvl/MarginContainer/VBoxContainer/LabelLvl").text = lvlStr;
	setInfoState();

func setXp():
	var lvlXp = UserStoreGlobal.get_exp();
	get_node("ControlLvl/MarginContainer/VBoxContainer/TextureProgressBar").value = lvlXp;

func setName() -> void:
	get_node('ControlAvatar/BorderName/LabelName').text = UserStoreGlobal.state.name;

func setInfoState():
	get_node(tableInfoPathNode + 'RowInt/Count').set_text(String.num(UserStoreGlobal.get_intellect()));
	get_node(tableInfoPathNode + 'RowWill/Count').set_text(String.num(UserStoreGlobal.get_will()));
	get_node(tableInfoPathNode + 'RowPower/Count').set_text(String.num(UserStoreGlobal.get_power()));
	get_node(tableInfoPathNode + 'RowDex/Count').set_text(String.num(UserStoreGlobal.get_dexterity()));
	get_node(tableInfoPathNode + 'RowPArmor/Count').set_text(String.num(UserStoreGlobal.get_physArmor()));
	get_node(tableInfoPathNode + 'RowPCSC/Count').set_text(String.num(UserStoreGlobal.get_pCSC()) + '%');
	get_node(tableInfoPathNode + 'RowMCSC/Count').set_text(String.num(UserStoreGlobal.get_mCSC()) + '%');


func subscribeSignals() -> void:
	UserStoreGlobal.signals.update_exp.connect(_update_exp);
	UserStoreGlobal.signals.update_lvl.connect(_on_signal_set_lvl);

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_back_pressed():
	get_tree().change_scene_to_file('res://scenes/page/main.tscn')


func _on_butto_up_pressed():
	UserStoreGlobal.state_controller.up_exp(10);

func _update_exp(value):
	setXp();
