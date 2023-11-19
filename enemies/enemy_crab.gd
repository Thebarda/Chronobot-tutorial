extends CharacterBody2D

@export var patrol_points: Node
@export var speed: int = 50

var enemy_death = preload("res://enemies/enemy_death.tscn")

const GRAVITY = 1000

enum State { Idle, Walk }

var current_state: State
var direction: Vector2 = Vector2.LEFT
var number_of_points: int
var point_positions: Array[Vector2]
var current_point: Vector2
var current_point_position: int = 0
var can_walk: bool = false
var health_amount = 3

func _ready():
	if patrol_points != null:
		number_of_points = patrol_points.get_children().size()
		for point in patrol_points.get_children():
			point_positions.append(point.global_position)
		current_point = point_positions[current_point_position]
	else:
		print("No patrol points")
	current_state = State.Idle

func _physics_process(delta):
	enemy_gravity(delta)
	enemy_idle(delta)
	enemy_walk(delta)
	
	move_and_slide()
	
	enemy_animations()

func enemy_gravity(delta):
	velocity.y += GRAVITY * delta

func enemy_idle(delta):
	if !can_walk:
		velocity.x = move_toward(velocity.y, 0, speed)
		current_state = State.Idle
	
func enemy_walk(delta):
	if !can_walk:
		return

	if abs(position.x - current_point.x) > 0.5:
		velocity.x = direction.x * speed
		current_state = State.Walk
	else:
		current_point_position += 1
		
		current_point = point_positions[current_point_position % 2]
		
		if current_point.x > position.x:
			direction = Vector2.RIGHT
		else:
			direction = Vector2.LEFT
			
		can_walk = false
		$Timer.start()
	
	$AnimatedSprite2D.flip_h = direction.x > 0

func enemy_animations():
	if current_state == State.Walk:
		$AnimatedSprite2D.play("walk")
	else:
		$AnimatedSprite2D.play("idle")

func _on_timer_timeout():
	can_walk = true

func _on_hurtbox_area_entered(area: Area2D):
	if area.get_parent().has_method("get_damage_amount"):
		var bullet = area.get_parent()
		var new_health_amount = health_amount - bullet.damage_amount
		if new_health_amount == 0:
			var enemy_death_instance = enemy_death.instantiate()
			enemy_death_instance.global_position = global_position
			get_parent().add_child(enemy_death_instance)
			queue_free()
		health_amount = new_health_amount
