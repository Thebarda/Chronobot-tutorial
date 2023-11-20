extends Node

@export var dino: CharacterBody2D
@export var animated_sprint: AnimatedSprite2D

const GRAVITY = 1000

func _physics_process(delta):
	if !dino.is_on_floor():
		dino.velocity.y += GRAVITY + delta
		
	dino.move_and_slide()

