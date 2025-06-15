class_name BattleStore extends Node

var state: BattleDefaultState;
var state_controller: BattleController;

var battle_default_state: BattleDefaultState = BattleDefaultState.new();
var battle_state_controller := preload("res://scripts/state/battle/battle_controller.gd");
var signals = BattleStoreSignal.new();

func _init() -> void:
	print('BattleStore._init')
	state = battle_default_state;
	state_controller = battle_state_controller.new();

func update_selected_skill(skill_id: int) -> void:
	print('BattleStore.update_selected_skill %s'  % skill_id)
	state.select_skill = skill_id;

func start_move() -> void:
	print('BattleStore.start_move')
	state.is_move = true;

func is_move() -> bool:
	return state.is_move;

func add_log(log_data: LogState) -> void:
	state.log_list.append(log_data)
