extends CharacterBody2D

var enemy_death = preload("res://enemies/enemy_death.tscn")

@export var damage_amount = 1

var health = 5

func _on_hurtbox_area_entered(area):
	if !area.is_in_group("Bullet"):
		return
	
	var new_health_amount = health - area.get_parent().damage_amount
	if new_health_amount == 0:
		var enemy_death_instance = enemy_death.instantiate()
		enemy_death_instance.global_position = global_position
		get_parent().add_child(enemy_death_instance)
		queue_free()
	health = new_health_amount
