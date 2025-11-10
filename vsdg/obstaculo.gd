extends Area2D

var speed = 160.0
var speed_multiplier = 1.0

@onready var cono = $cono00
@onready var cs_cono = $CS_cono00

func _ready():
	#speed = 160.0
	#speed_multiplier = 1.0
	add_to_group("obstaculos")
	get_node("cono0"+str(Globalvars.playerSelect)).visible = true
	get_node("CS_cono0"+str(Globalvars.playerSelect)).disabled = false
	#print("process::> speed: "+ str(speed) + " - multiplier: " + str(speed_multiplier) + " - playerMultipier: " + str(Globalvars.playerMultiplier))

func _process(delta):
	if not Globalvars.gameover and Globalvars.gameon:
		#print("process::> speed: ", speed," - multiplier: ", speed_multiplier," - playerMultipier: ", Globalvars.playerMultiplier)
		position.y += speed * speed_multiplier * Globalvars.playerMultiplier * delta
		if position.y > get_viewport_rect().size.y + 50:
			queue_free()

func _on_body_entered(body):
	#print(body.name)
	if body.name == "coche":
		get_tree().root.get_node("game").game_over()

func setSpeed(_speed):
	speed = _speed

func new_speed_multiplier(_new_speed_multiplier):
	print("object increment speed: "+ str(speed_multiplier) + "-" +str(_new_speed_multiplier))
	speed_multiplier = _new_speed_multiplier
