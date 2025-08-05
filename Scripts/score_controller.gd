extends Label

var player: Node2D

func _ready():
	player = get_tree().get_root().get_node("Main/Player")

func _process(delta):
	text = "Score: " + str(player.score)
