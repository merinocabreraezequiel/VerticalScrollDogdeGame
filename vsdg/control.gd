extends Control

@onready var botones = [
	$VBoxContainer/Boton00,
	$VBoxContainer/Boton01,
	$VBoxContainer/Boton02,
	$VBoxContainer/Boton03
]

func _ready():
	for i in range(botones.size()):
		if botones[i]:
			botones[i].pressed.connect(_on_boton_presionado.bind(i))
		else:
			push_warning("Botón %d no encontrado" % i)
	for i in range(botones.size()):
		if botones[i]:
			botones[i].connect("gui_input", Callable(self, "_on_boton_input").bind(i))
		else:
			push_warning("Botón %d no encontrado" % i)

func _input(event):
	if event is InputEventKey and event.pressed:
		match event.keycode:
			KEY_1:
				seleccionar(0)
			KEY_2:
				seleccionar(1)
			KEY_3:
				seleccionar(2)
			KEY_4:
				seleccionar(3)

func _on_boton_presionado(indice):
	seleccionar(indice)

func _on_boton_input(event: InputEvent, index: int) -> void:
	if event is InputEventScreenTouch and event.pressed:
		seleccionar(index)

func seleccionar(valor):
	Globalvars.playerSelect = valor
	print("Seleccionado:", valor)
	get_tree().change_scene_to_file("res://game.tscn")
