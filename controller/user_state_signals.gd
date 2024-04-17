extends Node

signal change_hp(value: int);
signal change_mana(value: int);
signal update_available_control_count(value: int);
signal up_exp(value: int);

func _ready():
	print('UserStateSignals._ready')

func _init() -> void:
	print('UserStateSignals._init')
