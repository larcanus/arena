class_name BattleController
extends Node

func _init():
	print('BattleController._init')


func _battle_ended() -> void:
	print('ended')


func update_selected_skill(skill_id: int) -> void:
	print('BattleController.update_selected_skill %s ' % skill_id);
	BattleStoreGlobal.update_selected_skill(skill_id)
	BattleStoreGlobal.signals.battle_select_skill.emit(skill_id)
