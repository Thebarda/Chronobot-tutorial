extends NodeState

@export var player: CharacterBody2D
@export var animatedSprite: AnimatedSprite2D
@export var stateMachine: NodeFiniteStateMachine

var slow_down_speed: int = 3000

func on_process(delta):
	pass

func on_physics_process(delta):
	player.velocity.x = move_toward(player.velocity.x, 0, slow_down_speed * delta)
	animatedSprite.play("idle")
	
	var direction = player.input_mouvement()
	if Input.is_action_pressed("action_shoot"):
		stateMachine.transition_to("shoot")
	elif Input.is_action_just_pressed("jump") and player.is_on_floor():
		stateMachine.transition_to("jump")
	elif direction && player.is_on_floor():
		stateMachine.transition_to("run")

func enter():
	pass

func exit():
	pass
