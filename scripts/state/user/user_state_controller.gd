class_name UserStateController

# Called when the node enters the scene tree for the first time.
func _init():
	print('UserStateController._init')

func change_hp(value) -> void:
		if value < 0:
			return;

		var prevState = UserStoreGlobal.get_hp();
		UserStoreGlobal.update_hp(value);
		var format_string = "HP %s ---> %s"
		var actual_string = format_string % [String.num(prevState), String.num(UserStoreGlobal.get_hp())]
		print(actual_string);

		UserStoreGlobal.signals.change_hp.emit(value);

func change_mana(value) -> void:
		if value < 0:
			return;

		var prevState = UserStoreGlobal.get_mana();
		UserStoreGlobal.update_mana(value);
		var format_string = "MANA %s ---> %s"
		var actual_string = format_string % [String.num(prevState), String.num(UserStoreGlobal.get_mana())]
		print(actual_string);

		UserStoreGlobal.signals.change_mana.emit(value);

func update_available_control_count(value) -> void:
		var prevState = UserStoreGlobal.get_controlOfElementsAvailable();
		UserStoreGlobal.update_controlOfElementsAvailable(value);
		var format_string = "Available count %s ---> %s"
		var actual_string = format_string % [String.num(prevState), String.num(UserStoreGlobal.get_controlOfElementsAvailable())]
		print(actual_string);

		UserStoreGlobal.signals.update_available_control_count.emit(value);

func update_elem_control(value) -> void:
	var prevState = UserStoreGlobal.get_controlOfElements();
	UserStoreGlobal.update_controlOfElements(value);
	var format_string = "control elements %s ---> %s"
	var actual_string = format_string % [prevState, UserStoreGlobal.get_controlOfElements()]
	print(actual_string);
	UserStoreGlobal.signals.update_elem_control.emit(value);


func up_exp(value) -> void:
	var prevState = UserStoreGlobal.get_exp();
	var newState = prevState + value;
	if newState >= 100 && UserStoreGlobal.get_lvl().stage == 5:
		return;

	if newState >= 100:
		newState = 0;
		new_lvl()

	UserStoreGlobal.update_exp(newState);
	var format_string = "exp %s ---> %s"
	var actual_string = format_string % [String.num(prevState), String.num(newState)]
	print(actual_string);
	UserStoreGlobal.signals.update_exp.emit(value);


func new_lvl() -> void:
	var prevLvl = UserStoreGlobal.get_lvl();
	var avlCount = UserStoreGlobal.get_controlOfElementsAvailable();
	var intellect = UserStoreGlobal.get_intellect();
	var will = UserStoreGlobal.get_will();
	var power = UserStoreGlobal.get_power();
	var dexterity = UserStoreGlobal.get_dexterity();

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

	UserStoreGlobal.update_lvl(prevLvl);
	UserStoreGlobal.update_intellect(intellect);
	UserStoreGlobal.update_will(will);
	UserStoreGlobal.update_power(power);
	UserStoreGlobal.update_dexterity(dexterity);
	UserStoreGlobal.update_hp(100);
	updateCSC();
	UserStoreGlobal.signals.update_lvl.emit();
	update_available_control_count(avlCount);


func updateCSC():
	var intellectPercentP = UserStoreGlobal.get_intellect() / 100.0;
	var powerPercent = UserStoreGlobal.get_power() / 100.0;
	var dexPercent = UserStoreGlobal.get_dexterity() / 10.0;
	var pcsc = intellectPercentP + powerPercent + dexPercent;

	var intellectPercentM = UserStoreGlobal.get_intellect() / 100.0;
	var willPercent = UserStoreGlobal.get_will() / 10.0;
	var mcsc = intellectPercentM + willPercent;
	print( willPercent )
	print( pcsc, mcsc )
	UserStoreGlobal.update_pCSC(snappedf(pcsc, 0.1));
	UserStoreGlobal.update_mCSC(snappedf(mcsc, 0.1));
