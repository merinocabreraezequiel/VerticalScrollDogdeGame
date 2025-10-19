extends Area2D

var speed = 200.0

func _process(delta):
	position.y += speed * delta
	if position.y > get_viewport_rect().size.y + 50:
		queue_free()

func _on_body_entered(body):
	print(body.name)
	if body.name == "coche":
		print("💥 Colisión detectada con el coche")
		get_tree().call_group("game", "game_over")
