class_name BattleStoreSignal extends Resource

signal start();
signal end();
signal select_skill();
signal is_move();
signal add_log();


func _ready():
	print('BattleSignals._ready')

func _init() -> void:
	print('BattleSignals._init')
