extends Node

@export var mob_scene: PackedScene
@export var result_menu_scene: PackedScene
var battleController:= preload("res://controller/battle_controller.gd");
var controller;
var need_score = 5;

func _init():
	controller = battleController.new();
	setUserStateBattle(true);

# Called when the node enters the scene tree for the first time.
func _ready():
	UserStateSignals.change_hp.emit(100) # TODO remove


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func setUserStateBattle(value) -> void:
	User.setBattle(value);

func _on_mob_timer_timeout():
	# Create a new instance of the Mob scene.
	var mob = mob_scene.instantiate()
	mob.squashed.connect($UI._on_mob_squashed.bind())
	mob.squashed.connect(_on_mob_squashed)
	# Choose a random location on the SpawnPath.
	# We store the reference to the SpawnLocation node.
	var mob_spawn_location = get_node("SpawnPath/SpawnLocation")
	# And give it a random offset.
	mob_spawn_location.progress_ratio = randf()
	
	if $Player :
		var player_position = $Player.position
		mob.initialize(mob_spawn_location.position, player_position)
	# Spawn the mob by adding it to the Main scene.
		add_child(mob)
		
		
func _on_mob_squashed() -> void:
		var score = $UI.score;
		if score >= need_score:
			battle_ended();


func _on_player_hit():
	var hp = User.get_hp();
	if hp > 0 and hp == 100:
		UserStateSignals.change_hp.emit(50)
		return;
		
	if hp == 0:
		return;
	
	if hp == 50:
		UserStateSignals.change_hp.emit(0)
		battle_ended();
	
	
#func _unhandled_input(event):
	#print(event)
	#if event.is_action_pressed("ui_accept") and $UserInterface/Retry.visible:
		## This restarts the current scene.
		#get_tree().reload_current_scene()

func battle_ended() -> void:
	print('battle ended handlers')
	$MobTimer.stop()
	create_blackout_rect();
	BattleSignals.battle_ended.emit();
	show_result();
	$Player.queue_free();
	UserStateSignals.up_exp.emit(get_exp());
	setUserStateBattle(false);

func create_blackout_rect() -> void:
	var rect = ColorRect.new();
	rect.set_color(Color('1e113cd1'));
	rect.set_anchors_preset(15);
	add_child(rect);
	
func show_result():
	var menu = result_menu_scene.instantiate();
	add_child(menu);
	$MenuResult/LabelResult.set_text(get_label_result());
	$MenuResult/LabelEXP.set_text(get_label_exp());
	
func get_label_result() -> String:
	var hp = User.get_hp();
	if hp == 0:
		return 'Поражение'

	return 'Победа!';
	
func get_label_exp() -> String:
	return "опыт: %s" % get_exp();
	
func get_exp() -> int:
	var score = $UI.score;
	var exp = score * 10;
	return exp;
