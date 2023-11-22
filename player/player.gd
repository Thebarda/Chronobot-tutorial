extends CharacterBody2D

var bullet = preload("res://player/bullet.tscn")
var death_effect = preload("res://player/player_death/player_death_effect.tscn");

@onready var hit_animation = $HitAnimationPlayer

const GRAVITY = 1300
const SPEED = 5000

@export var speed: int = SPEED
@export var max_horizontal_speed = 200

func _physics_process(delta):
	player_failing(delta)
	
	move_and_slide()
	
func player_failing(delta):
	if !is_on_floor():
		velocity.y += GRAVITY * delta

func input_mouvement():
	var direction: float = Input.get_axis("move_left", "move_right")
	return direction

func move_horizontal(direction: float, delta: float):
	velocity.x += direction * speed * delta
	velocity.x = clamp(velocity.x, -max_horizontal_speed, max_horizontal_speed)

func _on_hurtbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("Enemy"):
		play_hit_animation()
		HealthManager.decrease_health(body.damage_amount)
	if HealthManager.current_health == 0:
		player_death()

func play_hit_animation():
	hit_animation.play("Hit")
	$HitTimer.start()
	
func player_death():
	var death_effect_instance = death_effect.instantiate()
	death_effect_instance.global_position = global_position
	get_parent().add_child(death_effect_instance)
	queue_free()

func _on_hit_timer_timeout() -> void:
	hit_animation.pause()
