extends Node2D

@export var white_glow: Texture
@export var star_size: float
@export var star_rate: float
var next_star: float
@export var star_speed: float

func _process(delta):
	if Time.get_ticks_msec() / 1000 > next_star:
		star_size = randf_range(1, 5)
		next_star = (Time.get_ticks_msec() / 1000) + star_rate
		var star: RigidBody2D = RigidBody2D.new()
		star.position = Vector2(randf_range(0, get_viewport_rect().size.x), 0)
		star.mass = star_size
		star.gravity_scale = 0
		var star_mesh = MeshInstance2D.new()
		star_mesh.mesh = BoxMesh.new()
		star_mesh.mesh.size = Vector3(star_size, star_size, star_size)
		star_mesh.texture = white_glow
		var star_collider = CollisionShape2D.new()
		star_collider.shape = RectangleShape2D.new()
		star_collider.shape.size = Vector2(star_size, star_size)
		star.add_child(star_mesh)
		star.add_child(star_collider)
		add_child(star)
		star.linear_velocity = Vector2(0, star_size * star_speed)
