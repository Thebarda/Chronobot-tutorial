extends NodeState

@export var player: CharacterBody2D
@export var animatedSprite: AnimatedSprite2D
@export var stateMachine: NodeFiniteStateMachine

const SPEED = 5000

var speed: int = SPEED
var max_horizontal_speed = 200
var slow_down_speed: int = 3000

func on_process(delta):
	pass

func on_physics_process(delta):
	var direction = player.input_mouvement()
	
	if Input.is_action_pressed("action_shoot"):
		stateMachine.transition_to("shoot")
	elif Input.is_action_just_pressed("jump") and player.is_on_floor():
		stateMachine.transition_to("jump")
	elif direction:
		player.move_horizontal(direction, delta)
	else:
		stateMachine.transition_to("idle")
		
	if direction != 0:
		animatedSprite.flip_h = false if direction > 0 else true
	
	animatedSprite.play("run")
	

func enter():
	pass

func exit():
	pass

