extends Area2D

var speed = 200.0
var speed_multiplier = 1.0

func _ready():
	add_to_group("obstaculos")  # 🔹 Así el Main puede encontrarlos fácilmente

func _process(delta):
	position.y += speed * speed_multiplier * delta
	if position.y > get_viewport_rect().size.y + 50:
		queue_free()

func _on_body_entered(body):
	print(body.name)
	if body.name == "coche":
		get_tree().root.get_node("game").game_over()

func setSpeed(_speed):
	speed = _speed

func new_speed_multiplier(_new_speed_multiplier):
	speed_multiplier = _new_speed_multiplier
