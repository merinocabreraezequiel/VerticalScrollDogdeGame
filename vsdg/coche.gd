extends CharacterBody2D

var move_speed = 400.0
var acceleration = 10.0  # controla qué tan rápido acelera o desacelera

func _physics_process(delta):
	if not get_tree().root.get_node("game").is_game_over:
		var target_velocity_x = 0.0
		if Input.is_action_pressed("ui_left"):
			target_velocity_x = -move_speed
		elif Input.is_action_pressed("ui_right"):
			target_velocity_x = move_speed

		velocity.x = lerp(velocity.x, target_velocity_x, delta * acceleration)
		move_and_slide()

		# Mantener dentro de la pantalla
		var screen_size = get_viewport_rect().size
		position.x = clamp(position.x, 32, screen_size.x - 32)
