extends RigidBody2D

var player: Node2D

func _ready():
	player = get_tree().get_root().get_node("Main/Player")

func _process(delta):
	position = position + Vector2(0, player.projectile_force)
