extends NodeState

@export var player: CharacterBody2D
@export var animatedSprite: AnimatedSprite2D
@export var stateMachine: NodeFiniteStateMachine

var slow_down_speed: int = 3000
const JUMP = -480

func on_process(delta):
	pass

func on_physics_process(delta):
	animatedSprite.play("jump")
	
	if Input.is_action_pressed("action_shoot"):
		stateMachine.transition_to("shoot")
	
	var direction = player.input_mouvement()
	if !player.is_on_floor():
		player.move_horizontal(direction, delta)
		animatedSprite.flip_h = false if direction > 0 else true
		return
		
	if direction:
		stateMachine.transition_to("run")
	else:
		stateMachine.transition_to("idle")
	

func enter():
	if player.is_on_floor():
		player.velocity.y = JUMP

func exit():
	pass
