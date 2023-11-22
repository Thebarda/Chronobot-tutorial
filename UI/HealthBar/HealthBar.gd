extends Node2D

@export var full_heart: Texture2D
@export var empty_heart: Texture2D

@onready var heart1 = $Heart
@onready var heart2 = $Heart2
@onready var heart3 = $Heart3

func _ready() -> void:
	HealthManager.on_health_changed.connect(on_player_health_changed)

func on_player_health_changed(player_current_health: int):
	if player_current_health == 1:
		heart1.texture = full_heart
	elif player_current_health < 1:
		heart1.texture = empty_heart
		
	if player_current_health == 2:
		heart2.texture = full_heart
	elif player_current_health < 2:
		heart2.texture = empty_heart
		
	if player_current_health == 3:
		heart3.texture = full_heart
	elif player_current_health < 3:
		heart3.texture = empty_heart
