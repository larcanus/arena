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
	var senseOfElements: Dictionary

	func _init(data):
		print('UserStore.State._init ', data)
		self.name = data.get('name', '')
		self.avatarPath = data.get('avatarPath', 'res://images/avawom1.png')
		self.senseOfElements = data.get('senseOfElements', {})
