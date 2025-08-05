extends Node2D

var next_drop: float = 15.0
@export var drop_rate: float
@export var powerup: PackedScene
var player: Node2D

func _ready():
	player = get_tree().get_root().get_node("Main/Player")
	
func _process(delta):
	if player.game_over:
		return
	
	if Time.get_ticks_msec() / 1000 > next_drop:
		var randomX: float = randf_range(0, get_viewport_rect().size.x)
		var powerup_position: Vector2 = Vector2(randomX, 0)
		next_drop = (Time.get_ticks_msec() / 1000) + drop_rate
		
		#/*****************************\
		#|**** Add your code below ****|
		#\*****************************/
			

		#/*****************************\
		#|**** Add your code above ****|
		#\*****************************/
