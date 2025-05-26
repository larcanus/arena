extends Control

var controlElem = { 'air' : 0, 'water' : 0, 'earth' : 0, 'fire' : 0,  }
var countAvailable = 0;
var controlElemCurState = { 'air' : 0, 'water' : 0, 'earth' : 0, 'fire' : 0,  }
var countAvailableCurState = 0;
var controlElemStartState = { 'air' : 0, 'water' : 0, 'earth' : 0, 'fire' : 0,  }
#var countAvailableStartState = 0;
var row1 = "ElementsTable/Table/row1/";
var row2 = "ElementsTable/Table/row2/";
var row3 = "ElementsTable/Table/row3/";
var row4 = "ElementsTable/Table/row4/";

func _ready():
	controlElem = UserStoreGlobal.state.controlOfElements if UserStoreGlobal.state.controlOfElements else controlElem;
	countAvailable = UserStoreGlobal.get_controlOfElementsAvailable();

	controlElemStartState = UserStoreGlobal.get_controlOfElements();
	#countAvailableStartState = UserStoreGlobal.get_countAvailable();

	controlElemCurState = UserStoreGlobal.get_controlOfElements();
	countAvailableCurState = UserStoreGlobal.get_controlOfElementsAvailable();
	set_control_table(controlElem);
	set_available_count();
	subscribe_signals();
	set_arrow();

func _process(delta):
	pass

func set_control_table(control: Dictionary) -> void:
	$ElementsTable/Table/row1/CountAir.set_text(String.num(control.air));
	$ElementsTable/Table/row2/CountWater.set_text(String.num(control.water));
	$ElementsTable/Table/row3/CountEarth.set_text(String.num(control.earth));
	$ElementsTable/Table/row4/CountFire.set_text(String.num(control.fire));


func is_use_state() -> bool:
	return !UserStoreGlobal.state.isNewUser;


func set_arrow() -> void:
	var count = countAvailable;
	var countLowerValue = 0;
	var control = controlElem;
	var controlLowerValue = { 'air' : 0, 'water' : 0, 'earth' : 0, 'fire' : 0 };
	if is_use_state():
		count = countAvailableCurState;
		#controlAvailableLowerValue = controlElemAvailableStartState;
		control = controlElemCurState;
		controlLowerValue = controlElemStartState;


	if count == countLowerValue:
		get_node(row1 + 'ArrowRightAir').set_disabled(true)
		get_node(row2 + 'ArrowRightWater').set_disabled(true)
		get_node(row3 + 'ArrowRightEarth').set_disabled(true)
		get_node(row4 + 'ArrowRightFire').set_disabled(true)
	else:
		get_node(row1 + 'ArrowRightAir').set_disabled(false)
		get_node(row2 + 'ArrowRightWater').set_disabled(false)
		get_node(row3 + 'ArrowRightEarth').set_disabled(false)
		get_node(row4 + 'ArrowRightFire').set_disabled(false)


	if control.air == controlLowerValue.air:
		get_node(row1 + 'ArrowLeftAir').set_disabled(true)
	else:
		get_node(row1 + 'ArrowLeftAir').set_disabled(false)

	if control.water == controlLowerValue.water:
		get_node(row2 + 'ArrowLeftWater').set_disabled(true)
	else:
		get_node(row2 + 'ArrowLeftWater').set_disabled(false)

	if control.earth == controlLowerValue.earth:
		get_node(row3 + 'ArrowLeftEarth').set_disabled(true)
	else:
		get_node(row3 + 'ArrowLeftEarth').set_disabled(false)

	if control.fire == controlLowerValue.fire:
		get_node(row4 + 'ArrowLeftFire').set_disabled(true)
	else:
		get_node(row4 + 'ArrowLeftFire').set_disabled(false)



func set_available_count() -> void:
	if is_use_state():
		$ElementsTable/BorderTableFooterText/ControlAvailableCountRow/ControlAvailableCount.text = String.num(countAvailableCurState);
		handler_button_ok();
		handler_button_restart();
	else:
		$ElementsTable/BorderTableFooterText/ControlAvailableCountRow/ControlAvailableCount.text = String.num(countAvailable);
		UserStoreGlobal.state_controller.update_available_control_count(countAvailable);

	set_arrow();


func handler_button_ok():
	if countAvailableCurState != countAvailable:
		$ElementsTable/MarginContainerOk.visible = true;
	else:
		$ElementsTable/MarginContainerOk.visible = false;

func handler_button_restart():
	if countAvailableCurState != countAvailable:
		$ElementsTable/MarginContainerRestart.visible = true;
	else:
		$ElementsTable/MarginContainerRestart.visible = false;


func subscribe_signals() -> void:
	UserStoreGlobal.signals.update_available_control_count.connect(_on_update_available_control_count)


func _on_update_available_control_count(value):
	$ElementsTable/BorderTableFooterText/ControlAvailableCountRow/ControlAvailableCount.text = String.num(value);
	countAvailable = value;
	countAvailableCurState = value;
	set_arrow();

func _on_arrow_left_air_pressed():
	if is_use_state():
		if controlElemCurState.air == controlElemStartState.air:
			return;

		controlElemCurState.air -= 1
		countAvailableCurState += 1;
		$ElementsTable/Table/row1/CountAir.set_text(String.num(controlElemCurState.air));
	else:
		if controlElem.air == 0:
			return;

		controlElem.air -= 1
		countAvailable += 1;
		$ElementsTable/Table/row1/CountAir.set_text(String.num(controlElem.air));

	set_available_count()


func _on_arrow_right_air_pressed():
	if is_use_state():
		if countAvailableCurState == 0:
			return;

		controlElemCurState.air += 1
		countAvailableCurState -= 1;
		$ElementsTable/Table/row1/CountAir.set_text(String.num(controlElemCurState.air));
	else:
		if countAvailable == 0:
			return;

		controlElem.air += 1
		countAvailable -= 1;
		$ElementsTable/Table/row1/CountAir.set_text(String.num(controlElem.air));

	set_available_count()


func _on_arrow_left_water_pressed():
	if is_use_state():
		if controlElemCurState.water == controlElemStartState.water:
			return;

		controlElemCurState.water -= 1
		countAvailableCurState += 1;
		$ElementsTable/Table/row2/CountWater.set_text(String.num(controlElemCurState.water));
	else:
		if controlElem.water == 0:
			return;

		controlElem.water -= 1
		countAvailable += 1;
		$ElementsTable/Table/row2/CountWater.set_text(String.num(controlElem.water));

	set_available_count()


func _on_arrow_right_water_pressed():
	if is_use_state():
		if countAvailableCurState == 0:
			return;

		controlElemCurState.water += 1
		countAvailableCurState -= 1;
		$ElementsTable/Table/row2/CountWater.set_text(String.num(controlElemCurState.water));
	else:
		if countAvailable == 0:
			return;

		controlElem.water += 1
		countAvailable -= 1;
		$ElementsTable/Table/row2/CountWater.set_text(String.num(controlElem.water));

	set_available_count()


func _on_arrow_left_earth_pressed():
	if is_use_state():
		if controlElemCurState.earth == controlElemStartState.earth:
			return;

		controlElemCurState.earth -= 1
		countAvailableCurState += 1;
		$ElementsTable/Table/row3/CountEarth.set_text(String.num(controlElemCurState.earth));
	else:
		if controlElem.earth == 0:
			return;

		controlElem.earth -= 1
		countAvailable += 1;
		$ElementsTable/Table/row3/CountEarth.set_text(String.num(controlElem.earth));

	set_available_count()


func _on_arrow_right_earth_pressed():
	if is_use_state():
		if countAvailableCurState == 0:
			return;

		controlElemCurState.earth += 1
		countAvailableCurState -= 1;
		$ElementsTable/Table/row3/CountEarth.set_text(String.num(controlElemCurState.earth));
	else:
		if countAvailable == 0:
			return;

		controlElem.earth += 1
		countAvailable -= 1;
		$ElementsTable/Table/row3/CountEarth.set_text(String.num(controlElem.earth));

	set_available_count()


func _on_arrow_left_fire_pressed():
	if is_use_state():
		if controlElemCurState.fire == controlElemStartState.fire:
			return;

		controlElemCurState.fire -= 1
		countAvailableCurState += 1;
		$ElementsTable/Table/row4/CountFire.set_text(String.num(controlElemCurState.fire));
	else:
		if controlElem.fire == 0:
			return;

		controlElem.fire -= 1
		countAvailable += 1;
		$ElementsTable/Table/row4/CountFire.set_text(String.num(controlElem.fire));

	set_available_count()


func _on_arrow_right_fire_pressed():
	if is_use_state():
		if countAvailableCurState == 0:
			return;

		controlElemCurState.fire += 1
		countAvailableCurState -= 1;
		$ElementsTable/Table/row4/CountFire.set_text(String.num(controlElemCurState.fire));
	else:
		if countAvailable == 0:
			return;

		controlElem.fire += 1
		countAvailable -= 1;
		$ElementsTable/Table/row4/CountFire.set_text(String.num(controlElem.fire));

	set_available_count()


func _on_texture_button_ok_pressed():
	UserStoreGlobal.state_controller.update_available_control_count(countAvailableCurState);
	UserStoreGlobal.state_controller.update_elem_control(controlElemCurState);
	controlElemStartState = controlElemCurState.duplicate();
	countAvailableCurState = countAvailable;
	handler_button_ok();
	handler_button_restart();
	set_arrow();


func _on_texture_button_restart_pressed():
	controlElemCurState = controlElemStartState.duplicate();
	countAvailableCurState = countAvailable;
	set_control_table(controlElemCurState);
	set_available_count();
