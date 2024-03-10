extends Node2D

var userName: String
var controlOfElements = { 'air' : 0, 'water' : 0, 'earth' : 0, 'fire' : 0,  }
var controlOfElementsAvailable = 0;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	userName = User.state.name if User.state.name else ''
	controlOfElements = User.state.controlOfElements if User.state.controlOfElements else controlOfElements
	
	$InputName.insert_text_at_caret(userName)
	
	setControlTable()
	setAvailableCount()

func setControlTable() -> void:
	$ElementsTable/Table/row1/CountAir.set_text(String.num(controlOfElements.air));
	$ElementsTable/Table/row2/CountWater.set_text(String.num(controlOfElements.water));
	$ElementsTable/Table/row3/CountEarth.set_text(String.num(controlOfElements.earth));
	$ElementsTable/Table/row4/CountFire.set_text(String.num(controlOfElements.fire));

func setAvailableCount() -> void:
	$ElementsTable/BorderTableFooterText/ControlAvailableCountRow/ControlAvailableCount.text = String.num(controlOfElementsAvailable);

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_button_change_pressed() -> void:
	print('on change')


func _on_button_change_avatar_pressed() -> void:
	print('on change ava')
	get_tree().change_scene_to_file('res://change_avatar.tscn')


func _on_button_change_family_pressed() -> void:
	print('on change family')


func _on_button_back_pressed() -> void:
	get_tree().change_scene_to_file('res://menu.tscn')


func _on_color_rect_focus_entered() -> void:
	$ButtonOk.grab_focus()


func _on_line_edit_text_changed(new_text: String) -> void:
	print(new_text)
	User.state.name = new_text;


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
