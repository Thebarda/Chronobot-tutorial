extends CharacterBody2D

var health = 5

func _on_hurtbox_area_entered(area):
	print(area)
	if !area.is_in_group("Bullet"):
		return
	
	var new_health_amount = health - area.get_parent().damage_amount
	if new_health_amount == 0:
		queue_free()
	health = new_health_amount
