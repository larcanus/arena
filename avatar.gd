extends Control

var userStateAvatarPath = load(User.state.avatarPath)

# Called when the node enters the scene tree for the first time.
func _ready():
	self.texture = userStateAvatarPath
	print('_ready texture')
	


func _init():
	self.texture = userStateAvatarPath
	print('_init texture')
