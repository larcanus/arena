@tool
class_name UserStore
extends Node

var state;

func _init() -> void:
	print('UserStore._init')
	state = State.new({})


func _ready():
	print('UserStore._ready')


class State:
	var name: String
	var avatarPath: String
	var controlOfElements = { 'air' : 5, 'water' : 5, 'earth' : 5, 'fire' : 5,  }

	func _init(data):
		print('UserStore.State._init ', data)
		self.name = data.get('name', '')
		self.avatarPath = data.get('avatarPath', 'res://images/avawom1.png')
		self.controlOfElements = data.get('controlOfElements', controlOfElements)
