extends Node

@export var mob_scene: PackedScene
@export var result_menu_scene: PackedScene
var battleController:= preload("res://controller/battle_controller.gd");
var controller;

func _init():
	controller = battleController.new();

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_mob_timer_timeout():
	# Create a new instance of the Mob scene.
	var mob = mob_scene.instantiate()
	mob.squashed.connect($UI._on_mob_squashed.bind())
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
		
		
func _on_player_hit():
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
	#get_tree().change_scene_to_file('res://main.tscn')

func create_blackout_rect() -> void:
	var rect = ColorRect.new();
	rect.set_color(Color('1e113cd1'));
	rect.set_anchors_preset(15);
	add_child(rect);
	
func show_result():
	var menu = result_menu_scene.instantiate();
	add_child(menu);
	print('result')
