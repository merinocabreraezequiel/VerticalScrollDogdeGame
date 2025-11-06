extends Node2D

@onready var car = $Car
@onready var bg = $background
@onready var timer_speedup = $velocidad
@onready var timer_spawn = $spawnTimer
@onready var ui = $UI
@onready var game_over_slide = $GAME_OVER

var scroll_speed = 200.0
var speed_multiplier = 1.0
var obstacles = []
var start_time:=0

func _ready():
	get_node("obstaculos").position = Vector2(randf_range(50, get_viewport_rect().size.x - 50), 76)
	timer_speedup.wait_time = 30.0  # cada 30 segundos
	timer_speedup.start()
	timer_spawn.wait_time = 2.0     # generar obstáculo cada X seg
	timer_spawn.start()
	scroll_speed = Globalvars.bgspeed
	start_time = Time.get_ticks_msec()
	ui.text = "Tiempo: 0 s"
	
	
func _process(delta):
	if not Globalvars.gameover:
		ui.text = "Tiempo: %.1f s" % (get_scene_elapsed_time())
		bg.scroll_speed = -1* scroll_speed * speed_multiplier #* delta
	else:
		bg.is_scrolling = false

func _on_Timer_SpeedUp_timeout():
	speed_multiplier *= 1.5
	if timer_spawn.wait_time > 0.4:
		timer_spawn.wait_time -= 0.2
	#print(timer_spawn.wait_time)
	Globalvars.update_precentage_multiple_respawn(5)
	var lista = get_tree().get_nodes_in_group("obstaculos")
	#print(len(lista))
	for obstaculo in lista:
		if obstaculo.has_method("new_speed_multiplier"):
			obstaculo.new_speed_multiplier(speed_multiplier)
	#print("🚀 Velocidad aumentada a %.2f" % speed_multiplier)

func _on_Timer_Spawn_timeout():
	#print("Nuevo obstaculo")
	spawn_obstacle()

func get_scene_elapsed_time() -> float:
	return (Time.get_ticks_msec() - start_time) / 1000.0

func spawn_obstacle():
	var multispawn = true
	while (multispawn):
		var obstacle_scene = preload("res://obstaculo.tscn")
		var obstacle = obstacle_scene.instantiate()
		var screen_size = get_viewport_rect().size
		obstacle.position = Vector2(randf_range(50, screen_size.x - 50), -50)
		#obstacle.setSpeed(scroll_speed)
		obstacle.new_speed_multiplier(speed_multiplier)
		add_child(obstacle)
		obstacles.append(obstacle)
		multispawn = Globalvars.get_probavility(Globalvars.percentage_multiple_respawn)

func game_over():
	if Globalvars.gameover:
		return
	Globalvars.toggle_gameover()
	#print("Game Over")
	timer_spawn.stop()
	timer_speedup.stop()
	ui.text = "Game Over - Tiempo: %.1f s" % (Time.get_ticks_msec() / 1000.0)
	Globalvars.gametime = (Time.get_ticks_msec() / 1000.0)
	game_over_slide.udpateTime(Globalvars.gametime)
	#move_child(game_over_slide, 5)
	game_over_slide.visible = true
