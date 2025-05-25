class_name UserStoreSignal extends Resource

signal change_hp(value: int);
signal change_mana(value: int);
signal update_available_control_count(value: int);
signal update_elem_control(value: Dictionary);
signal update_exp(value: int);
signal update_lvl(value: Dictionary);

const SIGNALS_NAME := {
	"change_hp": "change_hp",
	"change_mana": "change_mana",
	"update_available_control_count": "update_available_control_count",
	"update_elem_control": "update_elem_control",
	"update_exp": "update_exp",
	"update_lvl": "update_lvl",
}

func _init() -> void:
	print('UserStoreSignals._init')
