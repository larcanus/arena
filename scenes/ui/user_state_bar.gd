extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	_set_mana_state(UserStoreGlobal.get_mana());
	_set_hp_state(UserStoreGlobal.get_hp());
	bind_signals();
	set_lvl();

func _process(delta):
	pass


func bind_signals() -> void :
	UserStoreGlobal.signals.change_hp.connect(_change_hp_from_store);
	UserStoreGlobal.signals.change_mana.connect(_change_mana_from_store);

func set_lvl():
	var lvlStr = UserStoreGlobal.get_string_lvl();
	get_node("MarginContainer/MarginContainer/Label").text = lvlStr;

func _on_texture_button_pressed():
	print('_on_texture_button_pressed')
	#var state = UserStoreGlobal.get_hp() - 10;
	#UserStateSignals.change_hp.emit(state);
	#UserStateSignals.change_mana.emit(state);
	get_tree().change_scene_to_file('res://scenes/page/character.tscn')

func _set_mana_state(value):
	var count: float = (value * 2 / 100.0) + (-1.0);
	$MarginContainer/TextureRect/VBoxContainer/MarginContainer1/Mana/LabelCount.set_text(String.num(value));
	$MarginContainer/TextureRect/VBoxContainer/MarginContainer1/Mana.material.set_shader_parameter("fill_value", count)


func _set_hp_state(value):
	var count: float = (value * 2 / 100.0) + (-1.0);
	$MarginContainer/TextureRect/VBoxContainer/MarginContainer3/HP/LabelCount.set_text(String.num(value));
	$MarginContainer/TextureRect/VBoxContainer/MarginContainer3/HP.material.set_shader_parameter("fill_value", count)

func _change_hp_from_store(value):
	_set_hp_state(value);


func _change_mana_from_store(value):
	_set_mana_state(value);
