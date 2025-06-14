extends Node

var _items: Array[ItemDefaultStateResource] = []

func _ready():
	_load_items()

func _load_items():
	var database: ItemDatabase = load("res://data/items.tres")

	_items.clear()
	for item_data in database.items:
		_items.append(ItemDefaultStateResource.new(item_data))

	print("ItemStore::load items: ", _items.size())

func get_all_items() -> Array[ItemDefaultStateResource]:
	return _items.duplicate()

func get_item_by_id(id: int) -> ItemDefaultStateResource:
	for item in _items:
		if item.id == id:
			return item
	return null
