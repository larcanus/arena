class_name UserDefaultStateResource extends Resource

@export var name: String
@export var avatarPath: String = 'res://assets/graphics/images/avawom1.png';
@export var controlOfElements: Dictionary = { 'air' : 5, 'water' : 5, 'earth' : 5, 'fire' : 5,  }
@export 	var controlOfElementsAvailable = 5;
@export 	var hp = 100;
@export 	var mana = 100;
@export 	var isNewUser = true;
@export 	var isBattle = false;
@export 	var lvl = { 'stage' : 1, 'step': 1 };
@export 	var exp: int = 10;
@export 	var intellect = 15;
@export 	var will = 10;
@export 	var power = 15;
@export 	var dexterity = 10;
@export 	var physArmor = 0;
@export 	var pCSC = 0.0;
@export 	var mCSC = 0.0;
