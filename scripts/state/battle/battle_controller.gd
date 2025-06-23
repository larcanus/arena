class_name BattleController
extends Node

func _init():
	print('BattleController._init')


func _battle_ended() -> void:
	print('ended')

func start_user_move() -> void:
	print('BattleController.start_user_move')
	BattleStoreGlobal.start_user_move()
	BattleStoreGlobal.signals.is_user_move.emit()

func end_user_move() -> void:
	print('BattleController.end_user_move')
	BattleStoreGlobal.end_user_move()
	BattleStoreGlobal.signals.is_user_move.emit()
	BattleStoreGlobal.start_enemy_move()
	BattleStoreGlobal.signals.is_enemy_move.emit()

func end_enemy_move() -> void:
	print('BattleController.end_enemy_move')
	BattleStoreGlobal.end_enemy_move()
	BattleStoreGlobal.signals.is_enemy_move.emit()
	var current_round = BattleStoreGlobal.current_round() + 1;
	BattleStoreGlobal.update_round(current_round);
	BattleStoreGlobal.signals.new_round.emit(current_round);
	add_log('system', 'new round ' + str(current_round))

func update_selected_skill(skill_id: int) -> void:
	print('BattleController.update_selected_skill %s ' % skill_id);
	BattleStoreGlobal.update_selected_skill(skill_id)
	BattleStoreGlobal.signals.select_skill.emit(skill_id)


func add_log(type: String, text: String) -> void:
	var log_data = LogState.new(type, text)
	BattleStoreGlobal.add_log(log_data);
	BattleStoreGlobal.signals.add_log.emit(log_data);
