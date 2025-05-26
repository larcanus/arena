extends Control

var user_state_avatar_path = load(UserStoreGlobal.get_avatar_path())

# Called when the node enters the scene tree for the first time.
func _ready():
	self.texture = user_state_avatar_path
	print('avatar control:: _ready texture')



func _init():
	self.texture = user_state_avatar_path
	print('avatar control:: _init texture')
