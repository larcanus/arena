class_name ItemDefaultStateResource extends RefCounted

var id: int
var path: String
var name: String
var type: String
var icon: Texture2D

func _init(data: Dictionary):
	id = data.get("id", 0)
	path = data.get("path", "")
	name = data.get("name", "Unnamed")
	type = data.get("type", "empty")


func get_icon() -> Texture2D:
	if !icon and !path.is_empty():
		icon = load(path)
	return icon

static func new_empty() -> ItemDefaultStateResource:
	var item := ItemDefaultStateResource.new({
		"id": 0,
		"path": "",
		"name": "unnamed",
		"type": "empty"
	})
	return item
