extends CharacterBody2D

var bullet = preload("res://player/bullet.tscn")

const GRAVITY = 1300
const SPEED = 5000

@export var speed: int = SPEED
@export var max_horizontal_speed = 200

func _physics_process(delta):
	player_failing(delta)
	
	move_and_slide()
	
func player_failing(delta):
	if !is_on_floor():
		velocity.y += GRAVITY * delta

func input_mouvement():
	var direction: float = Input.get_axis("move_left", "move_right")
	return direction

func move_horizontal(direction: float, delta: float):
	velocity.x += direction * speed * delta
	velocity.x = clamp(velocity.x, -max_horizontal_speed, max_horizontal_speed)
