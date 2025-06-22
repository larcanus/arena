class_name UserStateController

var parent_store;

func _init(store):
	print(store)
	parent_store = store;
	print('UserStateController._init')

func change_hp(value) -> void:
		if value < 0:
			return;

		var prevState = parent_store.get_hp();
		parent_store.update_hp(value);
		var format_string = "HP %s ---> %s"
		var actual_string = format_string % [String.num(prevState), String.num(parent_store.get_hp())]
		print(actual_string);

		parent_store.signals.change_hp.emit(value);

func change_mp(value) -> void:
		if value < 0:
			return;

		var prevState = parent_store.get_mp();
		parent_store.update_mp(value);
		var format_string = "MANA %s ---> %s"
		var actual_string = format_string % [String.num(prevState), String.num(parent_store.get_mp())]
		print(actual_string);

		parent_store.signals.change_mp.emit(value);

func update_available_control_count(value) -> void:
		var prevState = parent_store.get_controlOfElementsAvailable();
		parent_store.update_controlOfElementsAvailable(value);
		var format_string = "Available count %s ---> %s"
		var actual_string = format_string % [String.num(prevState), String.num(parent_store.get_controlOfElementsAvailable())]
		print(actual_string);

		parent_store.signals.update_available_control_count.emit(value);

func update_elem_control(value) -> void:
	var prevState = parent_store.get_controlOfElements();
	parent_store.update_controlOfElements(value);
	var format_string = "control elements %s ---> %s"
	var actual_string = format_string % [prevState, parent_store.get_controlOfElements()]
	print(actual_string);
	parent_store.signals.update_elem_control.emit(value);


func up_exp(value) -> void:
	var prevState = parent_store.get_exp();
	var newState = prevState + value;
	if newState >= 100 && parent_store.get_lvl().stage == 5:
		return;

	if newState >= 100:
		newState = 0;
		new_lvl()

	parent_store.update_exp(newState);
	var format_string = "exp %s ---> %s"
	var actual_string = format_string % [String.num(prevState), String.num(newState)]
	print(actual_string);
	parent_store.signals.update_exp.emit(value);


func new_lvl() -> void:
	var prevLvl = parent_store.get_lvl();
	var avlCount = parent_store.get_controlOfElementsAvailable();
	var intellect = parent_store.get_intellect();
	var will = parent_store.get_will();
	var power = parent_store.get_power();
	var dexterity = parent_store.get_dexterity();

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

	parent_store.update_lvl(prevLvl);
	parent_store.update_intellect(intellect);
	parent_store.update_will(will);
	parent_store.update_power(power);
	parent_store.update_dexterity(dexterity);
	parent_store.update_hp(100);
	updateCSC();
	parent_store.signals.update_lvl.emit();
	update_available_control_count(avlCount);


func updateCSC():
	var intellectPercentP = parent_store.get_intellect() / 100.0;
	var powerPercent = parent_store.get_power() / 100.0;
	var dexPercent = parent_store.get_dexterity() / 10.0;
	var pcsc = intellectPercentP + powerPercent + dexPercent;

	var intellectPercentM = parent_store.get_intellect() / 100.0;
	var willPercent = parent_store.get_will() / 10.0;
	var mcsc = intellectPercentM + willPercent;
	print( willPercent )
	print( pcsc, mcsc )
	parent_store.update_pCSC(snappedf(pcsc, 0.1));
	parent_store.update_mCSC(snappedf(mcsc, 0.1));
