extends Sprite2D

var userStateAvatarPath = load(User.state.avatarPath)

func _init():
	texture = userStateAvatarPath
