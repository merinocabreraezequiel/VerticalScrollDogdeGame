extends CharacterBody2D

var move_speed = 400.0

func _physics_process(delta):
	var direction = 0.0
	if Input.is_action_pressed("ui_left"):
		direction -= 1.0
	if Input.is_action_pressed("ui_right"):
		direction += 1.0
	
	velocity.x = direction * move_speed
	move_and_slide()
	
	# Mantener dentro de la pantalla
	var screen_size = get_viewport_rect().size
	position.x = clamp(position.x, 32, screen_size.x - 32)
