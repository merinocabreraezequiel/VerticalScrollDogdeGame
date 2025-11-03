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
		get_tree().reload_current_scene()
	elif indice == 1:
		get_tree().change_scene_to_file("res://inicio.tscn")
	elif indice == 2:
		get_tree().quit()
	else:
		get_tree().change_scene_to_file("res://inicio.tscn")

func udpateTime(_endgametime):
	var lbl_tpn = $VBoxContainer/HBoxContainer/lbl_tiemponumero
	lbl_tpn.text = str(_endgametime)
