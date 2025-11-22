extends CharacterBody2D

var move_speed = 200.0
var acceleration = 60.0

var is_jumping = false
var last_press_time := 0.0
var double_tap_time := 0.5

var touch_active := false
var touch_offset := Vector2.ZERO

var target_x := 0.0

@onready var colshap = $CS_coche00
@onready var tween := get_tree().create_tween()

func _ready():
	target_x = position.x
	colshap = get_node("CS_coche0"+str(Globalvars.playerSelect))
	colshap.disabled = false
	get_node("coche0"+str(Globalvars.playerSelect)).visible = true
	move_speed *= Globalvars.playerMultiplier
	
func _input(event):
	if event is InputEventScreenTouch:
		#print("evento tactil")
		if event.pressed:
			# ¿El toque está sobre este CharacterBody2D?
			var local_pos = to_local(event.position)
			if colshap.shape is CircleShape2D:
				if local_pos.length() <= colshap.shape.radius:
					touch_active = true
					touch_offset = position - event.position
			elif colshap.shape is RectangleShape2D:
				var rect = Rect2(-colshap.shape.size / 2, colshap.shape.size)
				if rect.has_point(local_pos):
					touch_active = true
					touch_offset = position - event.position
			if touch_active:
				var now = Time.get_ticks_msec() / 1000.0    # segundos actuales
				if now - last_press_time <= double_tap_time:
			   	 	# Doble pulsación detectada
					goJump()
				last_press_time = now
		else:
			touch_active = false

	elif event is InputEventScreenDrag and touch_active:
		var drag_target = event.position + touch_offset
		target_x = drag_target.x
		#print(target_x)

func _physics_process(delta):
	if not Globalvars.gameover and Globalvars.gameon:
		var input_dir := 0.0
		
		if Input.is_action_pressed("ui_left"):
			input_dir -= 1.0
		if Input.is_action_pressed("ui_right"):
			input_dir += 1.0
		if Input.is_action_pressed("ui_select"):
			goJump()
			
		if input_dir != 0:
			target_x = position.x + input_dir * move_speed * delta

		position.x = lerp(position.x, target_x, delta * acceleration)

		var screen_size = get_viewport_rect().size
		position.x = clamp(position.x, 32, screen_size.x - 32)

func goJump():
	if is_jumping:
		return
	is_jumping = true
	colshap.disabled = true

	var original_scale = scale
	var jump_scale = scale * 1.3
	var half_time = 1.8 / 2

	tween = get_tree().create_tween()
	tween.tween_property(self, "scale", jump_scale, half_time).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "scale", original_scale, half_time).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN)
	tween.finished.connect(_on_jump_finished)

func _on_jump_finished():
	is_jumping = false
	colshap.disabled = false
