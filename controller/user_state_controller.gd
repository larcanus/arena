class_name UserStateController
extends Node

# Called when the node enters the scene tree for the first time.
func inite():
	print('UserStateController._init')


func bindSignals() -> void :
	UserStateSignals.change_hp.connect(_change_hp);
	print("UserStateSignals.change_hp bind done")
	UserStateSignals.change_mana.connect(_change_mana);
	print("UserStateSignals.change_mana bind done")
	UserStateSignals.update_available_control_count.connect(_update_available_control_count);
	print("UserStateSignals.update_available_control_count bind done")
	UserStateSignals.up_exp.connect(_up_exp);
	print("UserStateSignals.up_exp bind done")
	

func _change_hp(value) -> void:
		if value < 0:
			return;
		
		var prevState = User.get_hp();
		User.update_hp(value);
		var format_string = "HP %s ---> %s"
		var actual_string = format_string % [String.num(prevState), String.num(User.get_hp())]
		print(actual_string);
		
		UserStoreSignals.change_hp.emit(value);

func _change_mana(value) -> void:
		if value < 0:
			return;
		
		var prevState = User.get_mana();
		User.update_mana(value);
		var format_string = "MANA %s ---> %s"
		var actual_string = format_string % [String.num(prevState), String.num(User.get_mana())]
		print(actual_string);
		
		UserStoreSignals.change_mana.emit(value);
		
func _update_available_control_count(value) -> void:
		var prevState = User.get_controlOfElementsAvailable();
		User.update_controlOfElementsAvailable(value);
		var format_string = "Available count %s ---> %s"
		var actual_string = format_string % [String.num(prevState), String.num(User.get_controlOfElementsAvailable())]
		print(actual_string);
		
		UserStoreSignals.update_available_control_count.emit(value);

func _up_exp(value) -> void:
	var prevState = User.get_exp();
	var newState = prevState + value;
	if newState >= 100 && User.get_lvl().stage == 3:
		return;
	
	if newState >= 100:
		newState = 0;
		new_lvl()
		
	
	User.update_exp(newState);
	var format_string = "Available count %s ---> %s"
	var actual_string = format_string % [String.num(prevState), String.num(newState)]
	print(actual_string);
	
	UserStoreSignals.update_exp.emit(newState);

func new_lvl() -> void:
	var prevLvl = User.get_lvl();
	prevLvl.step += 1;

	if prevLvl.step > 3:
		prevLvl.step = 1;
		prevLvl.stage += 1;
	
	if prevLvl.stage >= 3:
		prevLvl.stage = 3;
		prevLvl.step = 3;
	
	User.update_lvl(prevLvl);
	UserStoreSignals.update_lvl.emit();
