extends NodeState

var bullet = preload("res://player/bullet.tscn")

@export var player: CharacterBody2D
@export var animatedSprite: AnimatedSprite2D
@export var stateMachine: NodeFiniteStateMachine
@export var shootTimer: Timer
@export var muzzle: Marker2D

var slow_down_speed: int = 3000
const JUMP = -480

func on_process(delta):
	pass

func on_physics_process(delta):
	var direction = player.input_mouvement()
	
	if direction:
		player.move_horizontal(direction, delta)
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, slow_down_speed * delta)
		
	if direction != 0:
		animatedSprite.flip_h = false if direction > 0 else true
		
	if Input.is_action_just_pressed("jump") and player.is_on_floor():
		player.velocity.y = JUMP
	
	if Input.is_action_just_released("action_shoot"):
		if Input.is_action_just_pressed("jump") and player.is_on_floor():
			stateMachine.transition_to("jump")
		elif direction:
			stateMachine.transition_to("run")
		else:
			stateMachine.transition_to("idle")
	
	var shooting_direction = 1 if animatedSprite.flip_h == false else -1
	
	if shooting_direction > 0:
		muzzle.position.x = abs(muzzle.position.x)
	elif shooting_direction < 0:
		muzzle.position.x = -abs(muzzle.position.x)
		
	if shooting_direction != 0:
		if shootTimer.time_left > 0:
			return
		animatedSprite.flip_h = false if shooting_direction > 0 else true
		var bullet_instance = bullet.instantiate() as Node2D
		bullet_instance.direction = shooting_direction
		bullet_instance.global_position = muzzle.global_position
		get_parent().add_child(bullet_instance)
		shootTimer.start(0.25)
		animatedSprite.play("run-shoot")

func enter():
	pass

func exit():
	pass
