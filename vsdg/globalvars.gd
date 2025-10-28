extends Node

var gameover = false
var bgspeed = 200
var percentage_multiple_respawn = 5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func toggle_gameover():
	gameover = not gameover

func set_bgspeed(_new_bgspeed):
	bgspeed = _new_bgspeed

func update_precentage_multiple_respawn(_percentage_multiple_respawn):
	percentage_multiple_respawn += _percentage_multiple_respawn

func get_probavility(_percentage:float):
	return randf() * 100 < _percentage
