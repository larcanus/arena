class_name BattleController
extends Node

func _init():
	bindSignals();
	print('BattleController._init')

func bindSignals() -> void :
	BattleSignals.battle_ended.connect(_battle_ended);

func _battle_ended() -> void:
	print('ended')
