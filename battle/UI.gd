extends Control

var score = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	UserStateSignals.change_hp.connect(_change_hp);
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _change_hp(e) -> void:
	if e == 50:
		$HPLabel.text = "Жизни: 1"
		
	if e == 100:
		$HPLabel.text = "Жизни: 2"
		
	if e == 0:
		$HPLabel.text = "Жизни: 0"

func _on_mob_squashed():
	score += 1
	$ScoreLabel.text = "Очки: %s" % score
