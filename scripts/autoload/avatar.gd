extends Control

var userStateAvatarPath = load(User.get_avatar_path())

# Called when the node enters the scene tree for the first time.
func _ready():
	self.texture = userStateAvatarPath
	print('_ready texture')



func _init():
	self.texture = userStateAvatarPath
	print('_init texture')
