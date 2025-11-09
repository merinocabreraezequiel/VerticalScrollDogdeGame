extends Node

var gameover = false
var bgspeed = 200
var percentage_multiple_respawn = 5
var playerSelect = 0
var playerMultiplier = 1.0
var gametime = '00:00:00'

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if playerSelect > 1:
		playerMultiplier = Globalvars.playerSelect/1.5 
	pass # Replace with function body.

func toggle_gameover():
	gameover = not gameover

func set_bgspeed(_new_bgspeed):
	bgspeed = _new_bgspeed

func update_precentage_multiple_respawn(_percentage_multiple_respawn):
	percentage_multiple_respawn += _percentage_multiple_respawn

func get_probavility(_percentage:float):
	return randf() * 100 < _percentage

func update_player_select(_playerselect):
	playerSelect = _playerselect
	if playerSelect > 1:
		playerMultiplier = playerSelect/1.5 

func reinit():
	gameover = false
	bgspeed = 200
	percentage_multiple_respawn = 5
	playerMultiplier = 1.0
	if playerSelect > 1:
		playerMultiplier = Globalvars.playerSelect/1.5 
	gametime = '00:00:00'
