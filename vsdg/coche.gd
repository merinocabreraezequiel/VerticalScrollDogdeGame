extends CharacterBody2D

var move_speed = 400.0
var acceleration = 10.0  # controla qué tan rápido acelera o desacelera

var touch_active := false
var touch_offset := Vector2.ZERO

var target_x := 0.0

func _ready():
	target_x = position.x

func _input(event):
	if event is InputEventScreenTouch:
		print("evento tactil")
		if event.pressed:
			# ¿El toque está sobre este CharacterBody2D?
			var local_pos = to_local(event.position)
			if $CollisionShape2D.shape is CircleShape2D:
				if local_pos.length() <= $CollisionShape2D.shape.radius:
					touch_active = true
					touch_offset = position - event.position
			elif $CollisionShape2D.shape is RectangleShape2D:
				var rect = Rect2(-$CollisionShape2D.shape.size / 2, $CollisionShape2D.shape.size)
				if rect.has_point(local_pos):
					touch_active = true
					touch_offset = position - event.position
		else:
			touch_active = false

	elif event is InputEventScreenDrag and touch_active:
		var drag_target = event.position + touch_offset
		target_x = drag_target.x
		print(target_x)

func _physics_process(delta):
	if not get_tree().root.get_node("game").is_game_over:
		var input_dir := 0.0
		
		if Input.is_action_pressed("ui_left"):
			input_dir -= 1.0
		if Input.is_action_pressed("ui_right"):
			input_dir += 1.0

		if input_dir != 0:
			target_x = position.x + input_dir * move_speed * delta

		position.x = lerp(position.x, target_x, delta * acceleration)

		var screen_size = get_viewport_rect().size
		position.x = clamp(position.x, 32, screen_size.x - 32)
