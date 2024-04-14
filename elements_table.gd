extends Control

var controlOfElements = { 'air' : 0, 'water' : 0, 'earth' : 0, 'fire' : 0,  }
var controlOfElementsAvailable = 0;
# Called when the node enters the scene tree for the first time.
func _ready():
	controlOfElements = User.state.controlOfElements if User.state.controlOfElements else controlOfElements;
	controlOfElementsAvailable = User.get_controlOfElementsAvailable();
	setControlTable();
	setAvailableCount();


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func setControlTable() -> void:
	$ElementsTable/Table/row1/CountAir.set_text(String.num(controlOfElements.air));
	$ElementsTable/Table/row2/CountWater.set_text(String.num(controlOfElements.water));
	$ElementsTable/Table/row3/CountEarth.set_text(String.num(controlOfElements.earth));
	$ElementsTable/Table/row4/CountFire.set_text(String.num(controlOfElements.fire));

func setAvailableCount() -> void:
	$ElementsTable/BorderTableFooterText/ControlAvailableCountRow/ControlAvailableCount.text = String.num(controlOfElementsAvailable);
	UserStateSignals.update_available_control_count.emit(controlOfElementsAvailable);

func _on_arrow_left_air_pressed():
	if controlOfElements.air == 0:
		return;
	
	controlOfElements.air -= 1
	controlOfElementsAvailable += 1;
	$ElementsTable/Table/row1/CountAir.set_text(String.num(controlOfElements.air));
	setAvailableCount()


func _on_arrow_right_air_pressed():
	if controlOfElementsAvailable == 0:
		return;
	
	controlOfElements.air += 1
	controlOfElementsAvailable -= 1;
	$ElementsTable/Table/row1/CountAir.set_text(String.num(controlOfElements.air));
	setAvailableCount()


func _on_arrow_left_water_pressed():
	if controlOfElements.water == 0:
		return;
	
	controlOfElements.water -= 1
	controlOfElementsAvailable += 1;
	$ElementsTable/Table/row2/CountWater.set_text(String.num(controlOfElements.water));
	setAvailableCount()


func _on_arrow_right_water_pressed():
	if controlOfElementsAvailable == 0:
		return;
	
	controlOfElements.water += 1
	controlOfElementsAvailable -= 1;
	$ElementsTable/Table/row2/CountWater.set_text(String.num(controlOfElements.water));
	setAvailableCount()


func _on_arrow_left_earth_pressed():
	if controlOfElements.earth == 0:
		return;
	
	controlOfElements.earth -= 1
	controlOfElementsAvailable += 1;
	$ElementsTable/Table/row3/CountEarth.set_text(String.num(controlOfElements.earth));
	setAvailableCount()


func _on_arrow_right_earth_pressed():
	if controlOfElementsAvailable == 0:
		return;
	
	controlOfElements.earth += 1
	controlOfElementsAvailable -= 1;
	$ElementsTable/Table/row3/CountEarth.set_text(String.num(controlOfElements.earth));
	setAvailableCount()


func _on_arrow_left_fire_pressed():
	if controlOfElements.fire == 0:
		return;
	
	controlOfElements.fire -= 1
	controlOfElementsAvailable += 1;
	$ElementsTable/Table/row4/CountFire.set_text(String.num(controlOfElements.fire));
	setAvailableCount()


func _on_arrow_right_fire_pressed():
	if controlOfElementsAvailable == 0:
		return;
	
	controlOfElements.fire += 1
	controlOfElementsAvailable -= 1;
	$ElementsTable/Table/row4/CountFire.set_text(String.num(controlOfElements.fire));
	setAvailableCount()
