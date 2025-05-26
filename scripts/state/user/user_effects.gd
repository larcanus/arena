class_name UserEffects extends Node

func _ready() -> void:
	print('user effect:: _ready')
	TimerGlobal.add_callback(_timeout_sec_timer);

func _timeout_sec_timer() -> void:
	print('user effect:: _timeout_sec_timer')
	regenerationHP();

func regenerationHP() -> void:
	if UserStoreGlobal.get_hp() < 100 and UserStoreGlobal.isBattle() == false:
		UserStoreGlobal.state_controller.change_hp(UserStoreGlobal.get_hp() + 1);
