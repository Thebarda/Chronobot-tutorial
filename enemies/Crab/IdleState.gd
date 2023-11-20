extends NodeState

@export var character: CharacterBody2D
@export var animatedSprite: AnimatedSprite2D
@export var timerWalk: Timer

var slow_down_speed = 3000

func on_process(delta):
	pass

func on_physics_process(delta):
	character.velocity.x = move_toward(character.velocity.x, 0, slow_down_speed * delta)
	animatedSprite.play("idle")
	character.move_and_slide()

func enter():
	timerWalk.start()

func exit():
	pass
