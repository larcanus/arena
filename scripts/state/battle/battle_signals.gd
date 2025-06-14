class_name BattleStoreSignal extends Resource

signal battle_start();
signal battle_ended();
signal battle_select_skill();
signal battle_press_move();


func _ready():
	print('BattleSignals._ready')

func _init() -> void:
	print('BattleSignals._init')
