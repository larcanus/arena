extends Node
class_name GlobalTimer

var _timer: Timer
signal timeout

func _ready() -> void:
	print('GlobalTimer._ready')
	_timer = Timer.new()
	add_child(_timer)
	_timer.timeout.connect(_on_timeout)
	_timer.start(1.0)

func _on_timeout() -> void:
	timeout.emit()

func add_callback(callback: Callable) -> void:
	print('GlobalTimer.add_callback:', callback)
	timeout.connect(callback)
