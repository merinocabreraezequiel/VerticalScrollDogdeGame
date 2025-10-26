extends Area2D

var speed_base = 200.0
var speed = speed_base

func _process(delta):
	position.y += speed * delta
	if position.y > get_viewport_rect().size.y + 50:
		queue_free()

func _on_body_entered(body):
	print(body.name)
	if body.name == "coche":
		get_tree().root.get_node("game").game_over()

func encrease_speed(new_speed):
	speed = speed * new_speed
