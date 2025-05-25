extends Control
var secTimer: Timer;

# Called when the node enters the scene tree for the first time.
func _ready():
	create_timers();

func create_timers():
	create_sec_timer();

func create_sec_timer() -> void:
	secTimer = Timer.new();
	add_child(secTimer);
	secTimer.timeout.connect(_timeout_sec_timer)
	secTimer.start(1)
	print('created sec timer')

func _timeout_sec_timer() -> void:
	print('sec timer callback') # TODO remove in prode
	regenerationHP();

func regenerationHP() -> void:
	if UserStoreGlobal.get_hp() < 100 and UserStoreGlobal.isBattle() == false:
		UserStoreGlobal.state_controller.change_hp(UserStoreGlobal.get_hp() + 1);
