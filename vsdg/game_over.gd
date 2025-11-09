extends Control

@onready var botones = [
	$VBoxContainer/HBoxContainer2/btn_volverjugar,
	$VBoxContainer/HBoxContainer2/btn_volverinicio,
	$VBoxContainer/HBoxContainer2/btn_cerrar
]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in range(botones.size()):
		if botones[i]:
			if OS.has_feature("android"):
				botones[i].connect("gui_input", Callable(self, "_on_boton_input").bind(i))
			else:
				botones[i].pressed.connect(_on_boton_presionado.bind(i))
			
		else:
			push_warning("Botón %d no encontrado" % i)
	if OS.has_feature("web"):
		get_node("VBoxContainer/HBoxContainer2/btn_cerrar").visible = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_boton_presionado(indice):
	Globalvars.reinit()
	if indice == 0:
		get_tree().change_scene_to_file("res://game.tscn")
	elif indice == 1:
		get_tree().change_scene_to_file("res://inicio.tscn")
	elif indice == 2:
		get_tree().quit()
	else:
		get_tree().change_scene_to_file("res://inicio.tscn")

func _on_boton_input(event: InputEvent, index: int) -> void:
	if event is InputEventScreenTouch and event.pressed:
		Globalvars.reinit()
		if index == 0:
			get_tree().change_scene_to_file("res://game.tscn")
		elif index == 1:
			get_tree().change_scene_to_file("res://inicio.tscn")
		elif index == 2:
			get_tree().quit()
	else:
		get_tree().change_scene_to_file("res://inicio.tscn")

func udpateTime(_endgametime):
	var lbl_tpn = $VBoxContainer/HBoxContainer/lbl_tiemponumero
	lbl_tpn.text = str(_endgametime)
