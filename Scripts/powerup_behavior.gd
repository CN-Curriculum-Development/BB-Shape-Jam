extends RigidBody2D

@export var enemies: Array[PackedScene]
var player: Node2D

func _ready():
	player = get_tree().get_root().get_node("Main/Player")

func _process(delta):
	if player.game_over:
		return
	else:
		position = position - Vector2(0, 0.03)

func _physics_process(delta):
	if len(get_colliding_bodies()) > 0:
		var body = get_colliding_bodies()[0]
		if body.is_in_group("Player"):
			print("Level Up!")
			queue_free()
			body.current_level += 1
			
			for enemy in get_tree().get_nodes_in_group("Enemy"):
				enemy.enemy_health += 5
				
