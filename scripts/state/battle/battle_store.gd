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

func clear_state():
	state =  BattleDefaultState.new();

func update_selected_skill(skill_id: int) -> void:
	print('BattleStore.update_selected_skill %s'  % skill_id)
	state.select_skill = skill_id;

func start_user_move() -> void:
	print('BattleStore.start_user_move')
	state.is_user_move = true;

func end_user_move() -> void:
	print('BattleStore.end_user_move')
	state.is_user_move = false;

func start_enemy_move() -> void:
	print('BattleStore.start_enemy_move')
	state.is_enemy_move = true;

func end_enemy_move() -> void:
	print('BattleStore.end_enemy_move')
	state.is_enemy_move = false;

func is_move() -> bool:
	return state.is_user_move or state.is_enemy_move;

func update_round(value: int) -> void:
	print('BattleStore.update_round')
	state.round_count = value;

func current_round() -> int:
	return state.round_count;

func add_log(log_data: LogState) -> void:
	state.log_list.append(log_data)
