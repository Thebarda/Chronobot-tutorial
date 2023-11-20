extends NodeState

@export var character: CharacterBody2D
@export var animatedSprite: AnimatedSprite2D

func on_process(delta):
	pass

func on_physics_process(delta):
	character.enemy_walk(delta)
	animatedSprite.play("walk")

func enter():
	pass

func exit():
	pass
