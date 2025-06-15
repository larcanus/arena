class_name BattleController
extends Node

func _init():
	print('BattleController._init')


func _battle_ended() -> void:
	print('ended')

func start_move() -> void:
	print('BattleController.start_move')
	BattleStoreGlobal.start_move()
	BattleStoreGlobal.signals.is_move.emit()


func update_selected_skill(skill_id: int) -> void:
	print('BattleController.update_selected_skill %s ' % skill_id);
	BattleStoreGlobal.update_selected_skill(skill_id)
	BattleStoreGlobal.signals.select_skill.emit(skill_id)


func add_log(type: String, text: String) -> void:
	var log_data = LogState.new(type, text)
	BattleStoreGlobal.add_log(log_data);
	BattleStoreGlobal.signals.add_log.emit(log_data);
