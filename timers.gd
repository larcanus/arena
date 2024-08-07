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
	if User.get_hp() < 100 and User.isBattle() == false:
		UserStateSignals.change_hp.emit(User.get_hp() + 1)
