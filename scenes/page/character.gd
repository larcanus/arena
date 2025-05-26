extends Control

var tableInfoPathNode = 'ControlStateInfo/MarginContainer/ScrollContainer/TableColumn/'

# Called when the node enters the scene tree for the first time.
func _ready():
	change_scale_aspect_to_keep();
	set_lvl();
	set_exp();
	set_user_name();
	set_info_state();
	subscribe_signals();

func change_scale_aspect_to_keep():
	if(get_tree().root.content_scale_aspect == Window.CONTENT_SCALE_ASPECT_KEEP):
		get_tree().root.content_scale_aspect = Window.CONTENT_SCALE_ASPECT_EXPAND;
		print('change scale_aspect = expand')

func _on_signal_set_lvl() -> void:
	set_lvl();

func set_lvl():
	var lvlStr = UserStoreGlobal.get_string_lvl();
	get_node("ControlLvl/MarginContainer/VBoxContainer/LabelLvl").text = lvlStr;
	set_info_state();

func set_exp():
	var lvlXp = UserStoreGlobal.get_exp();
	get_node("ControlLvl/MarginContainer/VBoxContainer/TextureProgressBar").value = lvlXp;

func set_user_name() -> void:
	get_node('ControlAvatar/BorderName/LabelName').text = UserStoreGlobal.state.name;

func set_info_state():
	get_node(tableInfoPathNode + 'RowInt/Count').set_text(String.num(UserStoreGlobal.get_intellect()));
	get_node(tableInfoPathNode + 'RowWill/Count').set_text(String.num(UserStoreGlobal.get_will()));
	get_node(tableInfoPathNode + 'RowPower/Count').set_text(String.num(UserStoreGlobal.get_power()));
	get_node(tableInfoPathNode + 'RowDex/Count').set_text(String.num(UserStoreGlobal.get_dexterity()));
	get_node(tableInfoPathNode + 'RowPArmor/Count').set_text(String.num(UserStoreGlobal.get_physArmor()));
	get_node(tableInfoPathNode + 'RowPCSC/Count').set_text(String.num(UserStoreGlobal.get_pCSC()) + '%');
	get_node(tableInfoPathNode + 'RowMCSC/Count').set_text(String.num(UserStoreGlobal.get_mCSC()) + '%');


func subscribe_signals() -> void:
	UserStoreGlobal.signals.update_exp.connect(_update_exp);
	UserStoreGlobal.signals.update_lvl.connect(_on_signal_set_lvl);


func _on_button_back_pressed():
	get_tree().change_scene_to_file('res://scenes/page/main.tscn')


func _on_butto_up_pressed():
	UserStoreGlobal.state_controller.up_exp(10);

func _update_exp(value):
	set_exp();
