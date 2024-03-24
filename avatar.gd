extends Sprite2D

var userStateAvatarPath = load(User.state.avatarPath)

# Called when the node enters the scene tree for the first time.
func _ready():
	texture = userStateAvatarPath
	print('_ready texture')
	


func _init():
	texture = userStateAvatarPath
	print('_init texture')
