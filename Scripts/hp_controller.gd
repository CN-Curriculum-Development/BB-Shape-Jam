extends Label

@export var player: Node2D

func _ready():
	player = get_tree().get_root().get_node("Main/Player")

func _process(delta):
	if player.game_over:
		text = "GAME OVER! RESTART THE GAME TO TRY AGAIN"
	else:
		text = "HP: " + str(player.player_health)
