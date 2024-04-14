extends Node

signal change_hp(value: int);
signal change_mana(value: int);
signal update_available_control_count(value: int);

func _ready():
	print('UserStoreSignals._ready')

func _init() -> void:
	print('UserStoreSignals._init')
