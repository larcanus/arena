class_name BattleDefaultState extends RefCounted

var round_count: int = 1
var is_user_move: bool = false
var is_enemy_move: bool = false
var select_skill: int = 1
var log_list: Array[LogState] = []
var user_left: Object
var user_right: Object
var timer;
