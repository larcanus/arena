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
	setControlTable(controlElem);
	setAvailableCount();
	subscribeSignals();
	setArrow();

func _process(delta):
	pass

func setControlTable(control: Dictionary) -> void:
	$ElementsTable/Table/row1/CountAir.set_text(String.num(control.air));
	$ElementsTable/Table/row2/CountWater.set_text(String.num(control.water));
	$ElementsTable/Table/row3/CountEarth.set_text(String.num(control.earth));
	$ElementsTable/Table/row4/CountFire.set_text(String.num(control.fire));


func isUseState() -> bool:
	return !UserStoreGlobal.state.isNewUser;


func setArrow() -> void:
	var count = countAvailable;
	var countLowerValue = 0;
	var control = controlElem;
	var controlLowerValue = { 'air' : 0, 'water' : 0, 'earth' : 0, 'fire' : 0 };
	if isUseState():
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



func setAvailableCount() -> void:
	if isUseState():
		$ElementsTable/BorderTableFooterText/ControlAvailableCountRow/ControlAvailableCount.text = String.num(countAvailableCurState);
		handlerButtonOk();
		handlerButtonRestart();
	else:
		$ElementsTable/BorderTableFooterText/ControlAvailableCountRow/ControlAvailableCount.text = String.num(countAvailable);
		UserStoreGlobal.state_controller.update_available_control_count(countAvailable);

	setArrow();


func handlerButtonOk():
	if countAvailableCurState != countAvailable:
		$ElementsTable/MarginContainerOk.visible = true;
	else:
		$ElementsTable/MarginContainerOk.visible = false;

func handlerButtonRestart():
	if countAvailableCurState != countAvailable:
		$ElementsTable/MarginContainerRestart.visible = true;
	else:
		$ElementsTable/MarginContainerRestart.visible = false;


func subscribeSignals() -> void:
	UserStoreGlobal.signals.update_available_control_count.connect(_on_update_available_control_count)


func _on_update_available_control_count(value):
	$ElementsTable/BorderTableFooterText/ControlAvailableCountRow/ControlAvailableCount.text = String.num(value);
	countAvailable = value;
	countAvailableCurState = value;
	setArrow();

func _on_arrow_left_air_pressed():
	if isUseState():
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

	setAvailableCount()


func _on_arrow_right_air_pressed():
	if isUseState():
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

	setAvailableCount()


func _on_arrow_left_water_pressed():
	if isUseState():
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

	setAvailableCount()


func _on_arrow_right_water_pressed():
	if isUseState():
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

	setAvailableCount()


func _on_arrow_left_earth_pressed():
	if isUseState():
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

	setAvailableCount()


func _on_arrow_right_earth_pressed():
	if isUseState():
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

	setAvailableCount()


func _on_arrow_left_fire_pressed():
	if isUseState():
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

	setAvailableCount()


func _on_arrow_right_fire_pressed():
	if isUseState():
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

	setAvailableCount()


func _on_texture_button_ok_pressed():
	UserStoreGlobal.state_controller.update_available_control_count(countAvailableCurState);
	UserStoreGlobal.state_controller.update_elem_control(controlElemCurState);
	controlElemStartState = controlElemCurState.duplicate();
	countAvailableCurState = countAvailable;
	handlerButtonOk();
	handlerButtonRestart();
	setArrow();


func _on_texture_button_restart_pressed():
	controlElemCurState = controlElemStartState.duplicate();
	countAvailableCurState = countAvailable;
	setControlTable(controlElemCurState);
	setAvailableCount();
