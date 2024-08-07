extends Control
var secTimer: Timer;

# Called when the node enters the scene tree for the first time.
func _ready():
	create_timers();

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func create_timers():
	create_sec_timer();

func create_sec_timer() -> void:
	print('create_sec_timer')
	secTimer = Timer.new();
	add_child(secTimer);
	secTimer.timeout.connect(_timeout_sec_timer)
	secTimer.start(1)
	
func _timeout_sec_timer() -> void:
	print('sec timer callback') # TODO remove in prode
	regenerationHP();
	
func regenerationHP() -> void:
	if User.state.get_hp() < 100 and User.state.isBattle == false:
		UserStateSignals.change_hp.emit(User.state.get_hp() + 1)
