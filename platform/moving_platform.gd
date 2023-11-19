extends CharacterBody2D

@export var points: Node

var speed: int = 5000
var max_horizontal_speed: int = 70

var patrol_points: Array[Vector2]
var number_patrol_points: int = 0
var current_patrol_point: int
var current_patrol_point_position: Vector2
var direction: Vector2 = Vector2.LEFT

func _ready():
	if points != null:
		number_patrol_points = points.get_children().size()
		for point in points.get_children():
			patrol_points.append(point.global_position)
		current_patrol_point_position = patrol_points[current_patrol_point]
		get_direction()
	else:
		print('No patrol points')
		
func _physics_process(delta):
	move_platform(delta)
	
	move_and_slide()
	
func move_platform(delta: float):
	if abs(position.x - current_patrol_point_position.x) > 0.5:
		velocity.x += direction.x * speed * delta
		velocity.x = clamp(velocity.x, -max_horizontal_speed, max_horizontal_speed)
	else:
		current_patrol_point += 1
		current_patrol_point_position = patrol_points[current_patrol_point % 2]
		get_direction()
		
func get_direction():
	if current_patrol_point_position.x > position.x:
		direction = Vector2.RIGHT
	else:
		direction = Vector2.LEFT
