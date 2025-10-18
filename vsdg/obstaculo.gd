extends Area2D

var speed = 200.0

func _process(delta):
	position.y += speed * delta
	if position.y > get_viewport_rect().size.y + 50:
		queue_free()

func _on_body_entered(body):
	if body.name == "Car":
		get_tree().call_group("main", "game_over")
