extends RigidBody2D

@export var speed: float
@export var projectile_force: float
@export var fire_rate: float
@export var current_level: int = 1
var next_fire: float

@export var player_health = 100
@export var score: int = 0
@export var game_over: bool = false

var move_direction: Vector2 = Vector2.ZERO
@export var projectile: PackedScene

func _ready():
	current_level = 1
	score = 0

func _physics_process(delta):
	move_direction = Vector2(Input.get_axis("ui_left", "ui_right"), Input.get_axis("ui_up", "ui_down"))
	if not game_over:
		position += move_direction * speed
	position = Vector2(
		clampf(position.x,
		0,
		get_viewport_rect().size.x),
		clampf(position.y,
		0,
		get_viewport_rect().size.y),
	)
	
	if len(get_colliding_bodies()) > 0:
		var body = get_colliding_bodies()[0]
		if body.is_in_group("Hazard"):
			print("Player Hit!")
			body.queue_free()
			player_health -= 1

func _process(delta):
	if game_over:
		return
	
	if Input.is_action_pressed("ui_accept") and (Time.get_ticks_msec() / 1000) > next_fire:
		next_fire = Time.get_ticks_msec() / 1000
	
	
	
	if player_health <= 0:
		game_over = true
