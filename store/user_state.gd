class_name UserStore
extends Node

var state;
var controller := preload("res://controller/user_state_controller.gd");
var stateController;

func _init() -> void:
	print('UserStore._init')
	state = State.new({})
	stateController = controller.new();


func clearState():
	state = State.new({});
	stateController.updateCSC();

func _ready():
	print('UserStore._ready')
	stateController.bindSignals();
	stateController.updateCSC();

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
	
func get_controlOfElements() -> Dictionary:
	return state.get_controlOfElements();

func update_controlOfElementsAvailable(value: int) -> void:
	state.update_controlOfElementsAvailable(value);
	
func update_controlOfElements(value: Dictionary) -> void:
	state.update_controlOfElements(value);
	
func get_intellect() -> int:
	return state.get_intellect();

func update_intellect(value: int) -> void:
	state.update_intellect(value);

func get_will() -> int:
	return state.get_will();

func update_will(value: int) -> void:
	state.update_will(value);

func get_power() -> int:
	return state.get_power();

func update_power(value: int) -> void:
	state.update_power(value);

func get_dexterity() -> int:
	return state.get_dexterity();

func update_dexterity(value: int) -> void:
	state.update_dexterity(value);

func get_physArmor() -> int:
	return state.get_physArmor();

func update_physArmor(value: int) -> void:
	state.update_physArmor(value);
	
func get_mCSC() -> float:
	return state.get_mCSC();

func update_mCSC(value: float) -> void:
	state.update_mCSC(value);
	
func get_pCSC() -> float:
	return state.get_pCSC();

func update_pCSC(value: float) -> void:
	state.update_pCSC(value);

func get_lvl() -> Dictionary:
	return state.get_lvl();

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
	state.update_lvl(value);
	

func get_exp() -> int:
	return state.get_exp();

func update_exp(value: int) -> void:
	state.update_exp(value);

func isBattle() -> bool:
	return state.isBattle;

func setBattle(value: bool) -> void:
	state.isBattle = value;

class State:
	var name: String
	var avatarPath: String
	var controlOfElements: Dictionary = { 'air' : 5, 'water' : 5, 'earth' : 5, 'fire' : 5,  }
	var controlOfElementsAvailable = 0;
	var hp = 100;
	var mana = 100;
	var isNewUser = true;
	var isBattle = false;
	var lvl = { 'stage' : 1, 'step': 1 };
	var exp: int = 10;
	var intellect = 15;
	var will = 10;
	var power = 15;
	var dexterity = 10;
	var physArmor = 0;
	var pCSC = 0.0;
	var mCSC = 0.0;

	func _init(data):
		print('UserStore.State._init ', data)
		self.name = data.get('name', '')
		self.avatarPath = data.get('avatarPath', 'res://images/avawom1.png')
		self.controlOfElements = data.get('controlOfElements', controlOfElements)
		self.controlOfElementsAvailable = data.get('controlOfElementsAvailable', 10)
		self.lvl = data.get('lvl', lvl);
		self.hp = data.get('hp', 100);
		self.mana = data.get('mana', 100);
		self.exp = data.get('xp', exp);
		
		self.intellect = data.get('intellect', intellect);
		self.will = data.get('will', will);
		self.power = data.get('power', power);
		self.dexterity = data.get('dexterity', dexterity);
		self.physArmor = data.get('physArmor', physArmor);
		self.pCSC = data.get('pCSC', pCSC);
		self.mCSC = data.get('mCSC', mCSC);

	func update_hp(value: int) -> void:
		self.hp = value;

	func update_mana(value: int) -> void:
		self.mana = value;

	func get_hp() -> int:
		return self.hp;

	func get_mana() -> int:
		return self.mana;
		

	func get_controlOfElements() -> Dictionary:
		var c = {};
		c.merge(controlOfElements)
		return c;
	
	
	func update_controlOfElements(value: Dictionary) -> void:
		controlOfElements = value;


	func get_controlOfElementsAvailable() -> int:
		return self.controlOfElementsAvailable;

	func update_controlOfElementsAvailable(value: int) -> void:
		self.controlOfElementsAvailable = value;
		

	func get_lvl() -> Dictionary:
		return self.lvl;

	func update_lvl(value: Dictionary) -> void:
		self.lvl = value;
		
	func get_exp() -> int:
		return self.exp;

	func update_exp(value: int) -> void:
		self.exp = value;

	func get_intellect() -> int:
		return self.intellect;

	func update_intellect(value: int) -> void:
		self.intellect = value;

	func get_will() -> int:
		return self.will;

	func update_will(value: int) -> void:
		self.will = value;
		
	func get_power() -> int:
		return self.power;

	func update_power(value: int) -> void:
		self.power = value;
		
	func get_dexterity() -> int:
		return self.dexterity;
		
	func update_dexterity(value: int) -> void:
		self.dexterity = value;
	
	func get_physArmor() -> int:
		return self.physArmor;
		
	func update_physArmor(value: int) -> void:
		self.physArmor = value;
		
	func get_pCSC() -> float:
		return self.pCSC;
		
	func update_pCSC(value: float) -> void:
		self.pCSC = value;
		
	func get_mCSC() -> float:
		return self.mCSC;
		
	func update_mCSC(value: float) -> void:
		self.mCSC = value;
