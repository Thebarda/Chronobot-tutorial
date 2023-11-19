extends AnimatedSprite2D

func _physics_process(delta):
	if frame_progress == 1.0:
		queue_free()
