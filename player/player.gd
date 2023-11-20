extends CharacterBody2D

var bullet = preload("res://player/bullet.tscn")

const GRAVITY = 1300
const SPEED = 5000
const JUMP = -480

@export var speed: int = SPEED
@export var max_horizontal_speed = 200
@export var slow_down_speed: int = 3000
@export var jump: int = JUMP

enum State { Idle, Run, Jump, Shoot }

var current_state: State
var muzzle_position
var shooting_direction: float = 0

func _ready():
	current_state = State.Idle
	muzzle_position = $muzzle.position
	
func _physics_process(delta):
	player_failing(delta)
	player_idle(delta)
	player_run(delta)
	player_jump(delta)
	player_muzzle_position()
	player_shooting(delta)
	
	move_and_slide()
	
	player_animations()
	# print(State.keys()[current_state])
	
func player_failing(delta):
	if !is_on_floor():
		velocity.y += GRAVITY * delta

func player_idle(delta):
	if is_on_floor():
		current_state = State.Idle
		
func player_run(delta):
	if !is_on_floor() and current_state == State.Jump:
		return
		
	var direction = input_mouvement()
	
	if direction:
		move_horizontal(direction, delta)
	else:
		velocity.x = move_toward(velocity.x, 0, slow_down_speed * delta)
		
	if direction != 0:
		current_state = State.Run
		$AnimatedSprite2D.flip_h = false if direction > 0 else true

func player_jump(delta):
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump
		current_state = State.Jump
	if !is_on_floor() and current_state == State.Jump:
		var direction = input_mouvement()
		move_horizontal(direction, delta)
		if direction != 0:
			$AnimatedSprite2D.flip_h = false if direction > 0 else true

func player_shooting(delta):
	var direction = input_mouvement()
	
	if direction != 0:
		shooting_direction = direction
		
	if shooting_direction != 0 and Input.is_action_pressed("action_shoot"):
		current_state = State.Shoot
		if $ShootTimer.time_left > 0:
			return
		var bullet_instance = bullet.instantiate() as Node2D
		bullet_instance.direction = shooting_direction
		bullet_instance.global_position = $muzzle.global_position
		get_parent().add_child(bullet_instance)
		$ShootTimer.start(0.25)

func player_muzzle_position():
	if shooting_direction > 0:
		$muzzle.position.x = muzzle_position.x
	elif shooting_direction < 0:
		$muzzle.position.x = -muzzle_position.x
	
func player_animations():
	if current_state == State.Run and ($AnimatedSprite2D.animation != "run-shoot"  or $ShootTimer.time_left == 0):
		$AnimatedSprite2D.play("run")
	elif current_state == State.Jump:
		$AnimatedSprite2D.play("jump")
	elif current_state == State.Shoot:
		$AnimatedSprite2D.play("run-shoot")
	elif current_state == State.Idle and ($AnimatedSprite2D.animation != "run-shoot"  or $ShootTimer.time_left == 0):
		$AnimatedSprite2D.play("idle")
		
func input_mouvement():
	var direction: float = Input.get_axis("move_left", "move_right")
	return direction

func move_horizontal(direction: float, delta: float):
	velocity.x += direction * speed * delta
	velocity.x = clamp(velocity.x, -max_horizontal_speed, max_horizontal_speed)
