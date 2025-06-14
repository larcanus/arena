class_name UserStore extends Node

var state;
var state_controller;

var user_default_state_resource: UserDefaultStateResource = UserDefaultStateResource.new();
var user_state_controller := preload("res://scripts/state/user/user_state_controller.gd");
var signals = UserStoreSignal.new();
var signal_names = signals.SIGNAL_NAMES;

func _init() -> void:
	print('UserStore._init')
	state = user_default_state_resource;
	state_controller = user_state_controller.new();

func clearState():
	state = UserDefaultStateResource.new();
	state_controller.updateCSC();

func _ready():
	print('UserStore._ready')
	state_controller.updateCSC();
	state.skills = ItemStoreGlobal.get_all_items();


func get_avatar_path() -> String:
	return state.avatarPath;

func set_avatar_path(value) -> void:
	state.avatarPath = value;

func get_hp() -> int:
	return state.hp;

func update_hp(value: int) -> void:
	state.hp = value;

func get_mana() -> int:
	return state.mana;

func update_mana(value: int) -> void:
	state.mana = value;

func get_controlOfElementsAvailable() -> int:
	return state.controlOfElementsAvailable;

func get_controlOfElements() -> Dictionary:
	var c = {};
	c.merge(state.controlOfElements)
	return c;

func update_controlOfElementsAvailable(value: int) -> void:
	state.controlOfElementsAvailable = value;

func update_controlOfElements(value: Dictionary) -> void:
	state.controlOfElements = value;

func get_intellect() -> int:
	return state.intellect;

func update_intellect(value: int) -> void:
	state.intellect = value;

func get_will() -> int:
	return state.will;

func update_will(value: int) -> void:
	state.will = value;

func get_power() -> int:
	return state.power;

func update_power(value: int) -> void:
	state.power = value;

func get_dexterity() -> int:
	return state.dexterity;

func update_dexterity(value: int) -> void:
	state.dexterity = value;

func get_physArmor() -> int:
	return state.physArmor;

func update_physArmor(value: int) -> void:
	state.physArmor = value;

func get_mCSC() -> float:
	return state.mCSC;

func update_mCSC(value: float) -> void:
	state.mCSC = value;

func get_pCSC() -> float:
	return state.pCSC;

func update_pCSC(value: float) -> void:
	state.pCSC = value;

func get_lvl() -> Dictionary:
	return state.lvl;

func get_string_lvl():
	var string = '';
	if state.lvl.stage == 1:
		string = 'Ученик'

	if state.lvl.stage == 2:
		string = 'Адепт'

	if state.lvl.stage == 3:
		string = 'Маг'

	if state.lvl.stage == 4:
		string = 'АрхиМаг'

	string += ' ' + String.num(state.lvl.step) + ' ур.';
	return string;

func update_lvl(value: Dictionary) -> void:
	state.lvl = value;

func get_exp() -> int:
	return state.exp;

func update_exp(value: int) -> void:
	state.exp = value;

func isBattle() -> bool:
	return state.isBattle;

func setBattle(value: bool) -> void:
	state.isBattle = value;

func get_skills() -> Array:
	return state.skills;
