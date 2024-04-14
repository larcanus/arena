extends Control
var test := 123;

# Called when the node enters the scene tree for the first time.
func _ready():
	_set_mana_state(User.get_mana());
	_set_hp_state(User.get_hp());
	bindSignals();

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	

func bindSignals() -> void :
	UserStoreSignals.change_hp.connect(_change_hp_from_store);
	UserStoreSignals.change_mana.connect(_change_mana_from_store);

func _on_texture_button_pressed():
	print('_on_texture_button_pressed')
	#var state = User.state.get_hp() - 10;
	#UserStateSignals.change_hp.emit(state);
	#UserStateSignals.change_mana.emit(state);
	get_tree().change_scene_to_file('res://character.tscn')

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
