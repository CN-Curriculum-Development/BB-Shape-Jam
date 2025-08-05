extends Node2D

@export var enemy: PackedScene
var player: Node2D
@export var spawn_rate: float
var next_spawn: float = 5.0

func _ready():
	player = get_tree().get_root().get_node("Main/Player")

func _process(delta):
	if player.game_over:
		return
	if Time.get_ticks_msec() / 1000 > next_spawn:
		next_spawn = (Time.get_ticks_msec() / 1000) + spawn_rate
		#/*****************************\
		#|**** Add your code below ****|
		#\*****************************/
			

		#/*****************************\
		#|**** Add your code above ****|
		#\*****************************/
