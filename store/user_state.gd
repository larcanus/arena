@tool
class_name UserStore
extends Node

var state;
var controller := preload("res://controller/user_state_controller.gd");
var stateController;

func _init() -> void:
	print('UserStore._init')
	state = State.new({})
	stateController = controller.new();
	

func _ready():
	print('UserStore._ready')
	stateController.bindSignals();

func get_hp() -> int:
	return state.get_hp();
	
func update_hp(value: int) -> void:
	state.update_hp(value);

func get_mana() -> int:
	return state.get_mana();
	
func update_mana(value: int) -> void:
	state.update_mana(value);
	
func get_controlOfElementsAvailable() -> int:
	return state.get_controlOfElementsAvailable();

func update_controlOfElementsAvailable(value: int) -> void:
	state.update_controlOfElementsAvailable(value);
	

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






class State:
	var name: String
	var avatarPath: String
	var controlOfElements = { 'air' : 5, 'water' : 5, 'earth' : 5, 'fire' : 5,  }
	var controlOfElementsAvailable = 0;
	var hp = 100;
	var mana = 100;
	var isNewUser = true;
	var lvl = { 'stage' : 2, 'step': 2 };

	func _init(data):
		print('UserStore.State._init ', data)
		self.name = data.get('name', '')
		self.avatarPath = data.get('avatarPath', 'res://images/avawom1.png')
		self.controlOfElements = data.get('controlOfElements', controlOfElements)
		self.controlOfElementsAvailable = data.get('controlOfElementsAvailable', 0)
		self.lvl = data.get('lvl', lvl);
		self.hp = data.get('hp', 100);
		self.mana = data.get('mana', 100)
		
	func update_hp(value: int) -> void:
			self.hp = value;
			
	func update_mana(value: int) -> void:
			self.mana = value;

	func get_hp() -> int:
		return self.hp;

	func get_mana() -> int:
		return self.mana;
		
		
	func get_controlOfElementsAvailable() -> int:
		return self.controlOfElementsAvailable;

	func update_controlOfElementsAvailable(value: int) -> void:
		self.controlOfElementsAvailable = value;
		

	func get_lvl() -> Dictionary:
		return self.lvl;

	func update_lvl(value: Dictionary) -> void:
		self.lvl = value;
		
