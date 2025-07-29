extends RigidBody2D

var move_patterns = Array[Node2D]
@export var enemy_speed: float
@export var enemy_health: int
@export var current_waypoint: int
@export var point_value: int
@export var patrol: bool = true
@export var particle_size: float = 0.1
@export var particles_per_row: int = 5
@export var explosion_radius: float
@export var explosion_force: float
@export var explosion_upward: float
@export var enemy_texture: Texture
@export var target: Vector2
@export var enemy_move_direction: Vector2
@export var enemy_velocity: Vector2
var player: Node2D

func _ready():
	move_patterns.append(get_tree().get_root().find_node("Waypoint 1").transform())
	move_patterns.append(get_tree().get_root().find_node("Waypoint 2").transform())
	move_patterns.append(get_tree().get_root().find_node("Waypoint 3").transform())
	move_patterns.append(get_tree().get_root().find_node("Waypoint 4").transform())
	move_patterns.append(get_tree().get_root().find_node("Waypoint 5").transform())
	
	current_waypoint = randi_range(0, len(move_patterns)-1)
	
	player = get_tree().get_root().get_node("Main/Player")

func _process(delta):
	if player.game_over:
		return
	else:
		if current_waypoint < len(move_patterns)-1:
			target = move_patterns[current_waypoint].position
			enemy_move_direction = target - position
			enemy_velocity = linear_velocity
			if enemy_move_direction.length() < 1:
				current_waypoint = randi_range(0, len(move_patterns)-1)
			else:
				enemy_velocity = enemy_move_direction.normalized() * enemy_speed
		else:
			if patrol:
				current_waypoint = 0
			else:
				enemy_velocity = Vector2.ZERO
		
		linear_velocity = enemy_velocity
		rotate(75 * delta)
		
		if enemy_health <= 0:
			queue_free()
			point_value = 500 * player.current_level
			player.score += point_value
			
			for x in range(0,particles_per_row):
				for y in range(0, particles_per_row):
					CreatePiece(x, y)
			
			var explosion_pos: Vector2 = position
			# Collider[] colliders = Physics.OverlapSphere(explosionPos, explosionRadius);
			#    foreach (Collider hit in colliders)
			#    {
			#        Rigidbody rb = hit.GetComponent<Rigidbody>();
			#        if (rb != null)
			#        {
			#            rb.AddExplosionForce(explosionForce, transform.position, explosionRadius, explosionUpward);
			#        }
			#    }

func _physics_process(delta):
	if len(get_colliding_bodies()) > 0:
		var body = get_colliding_bodies()[0]
		if body.is_in_group("Projectile"):
			print("Enemy Hit!")
			body.queue_free()
			enemy_health -= 1

func CreatePiece(x, y):
	var piece: RigidBody2D = RigidBody2D.new()
	piece.mass = particle_size
	piece.position = position + Vector2(particle_size * x, particle_size * y)
	var piece_mesh = MeshInstance2D.new()
	piece_mesh.mesh = BoxMesh.new()
	piece_mesh.mesh.size = Vector3(particle_size, particle_size, particle_size)
	piece_mesh.texture = enemy_texture
	var piece_collider = CollisionShape2D.new()
	piece_collider.shape = RectangleShape2D.new()
	piece_collider.shape.size = Vector2(particle_size, particle_size)
	piece.add_child(piece_mesh)
	piece.add_child(piece_collider)
	get_tree().get_root().add_child(piece)
