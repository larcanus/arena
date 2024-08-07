class_name UserStateController
extends Node

# Called when the node enters the scene tree for the first time.
func _init():
	print('UserStateController._init')

func bindSignals() -> void :
	UserStateSignals.change_hp.connect(_change_hp);
	print("UserStateSignals.change_hp bind done")
	UserStateSignals.change_mana.connect(_change_mana);
	print("UserStateSignals.change_mana bind done")
	UserStateSignals.update_available_control_count.connect(_update_available_control_count);
	print("UserStateSignals.update_available_control_count bind done")
	UserStateSignals.update_elem_control.connect(_update_elem_control);
	print("UserStateSignals.update_elem_control bind done")
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


func _update_elem_control(value) -> void:
	var prevState = User.get_controlOfElements();
	User.update_controlOfElements(value);
	var format_string = "control elements %s ---> %s"
	var actual_string = format_string % [prevState, User.get_controlOfElements()]
	print(actual_string);

	UserStoreSignals.update_elem_control.emit(value);


func _up_exp(value) -> void:
	var prevState = User.get_exp();
	var newState = prevState + value;
	if newState >= 100 && User.get_lvl().stage == 5:
		return;

	if newState >= 100:
		newState = 0;
		new_lvl()


	User.update_exp(newState);
	var format_string = "exp %s ---> %s"
	var actual_string = format_string % [String.num(prevState), String.num(newState)]
	print(actual_string);

	UserStoreSignals.update_exp.emit(newState);

func new_lvl() -> void:
	var prevLvl = User.get_lvl();
	var avlCount = User.get_controlOfElementsAvailable();
	var intellect = User.get_intellect();
	var will = User.get_will();
	var power = User.get_power();
	var dexterity = User.get_dexterity();

	# up for step
	prevLvl.step += 1;
	avlCount += 5;
	intellect += 5;
	will += 2;
	power += 5;
	dexterity += 2;

	# up for stage
	if prevLvl.step > 3:
		prevLvl.step = 1;
		prevLvl.stage += 1;
		avlCount += 5;
		intellect += 5;
		will += 4;
		power += 5;
		dexterity += 4;

	# up for infinity
	if prevLvl.stage >= 5:
		prevLvl.stage = 4;
		prevLvl.step = 3;
		intellect += 5;
		will += 5;
		power += 5;
		dexterity += 5;

	User.update_lvl(prevLvl);
	User.update_intellect(intellect);
	User.update_will(will);
	User.update_power(power);
	User.update_dexterity(dexterity);
	User.update_hp(100);
	updateCSC();
	UserStoreSignals.update_lvl.emit();
	_update_available_control_count(avlCount);


func updateCSC():
	var intellectPercentP = User.get_intellect() / 100.0;
	var powerPercent = User.get_power() / 100.0;
	var dexPercent = User.get_dexterity() / 10.0;
	var pcsc = intellectPercentP + powerPercent + dexPercent;

	var intellectPercentM = User.get_intellect() / 100.0;
	var willPercent = User.get_will() / 10.0;
	var mcsc = intellectPercentM + willPercent;
	print( willPercent )
	print( pcsc, mcsc )
	User.update_pCSC(snappedf(pcsc, 0.1));
	User.update_mCSC(snappedf(mcsc, 0.1));

