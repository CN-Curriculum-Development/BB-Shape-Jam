extends Node2D

@export var hazard: PackedScene
@export var player: Node2D
@export var target: Vector2
@export var hazard_move_direction: Vector2
@export var hazard_spawn: Node2D
@export var fire_rate: float
var next_fire: float
@export var speed: float

func _ready():
	player = get_tree().get_root().get_node("Main/Player")

func _process(delta):
	if player.game_over:
		return
	
	target = player.position
	
	hazard_move_direction = target - position
	
	if Time.get_ticks_msec() / 1000 > next_fire:
		next_fire = (Time.get_ticks_msec() / 1000) + fire_rate
