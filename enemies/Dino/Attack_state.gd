extends NodeState

@export var character: CharacterBody2D
@export var animatedSprite: AnimatedSprite2D

var speed: int = 300
var max_speed: int = 80

var player: CharacterBody2D

func on_process(delta):
	pass

func on_physics_process(delta):
	var direction
	
	if character.global_position.x > player.global_position.x:
		direction = -1
		animatedSprite.flip_h = false
	elif character.global_position.x < player.global_position.x:
		direction = 1
		animatedSprite.flip_h = true
		
	animatedSprite.play("attack")
	character.velocity.x += direction * speed * delta
	character.velocity.x = clamp(character.velocity.x, -max_speed, max_speed)

func enter():
	player = get_tree().get_nodes_in_group("Player")[0]

func exit():
	player = null
