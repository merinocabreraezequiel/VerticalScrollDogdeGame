extends Node2D

@onready var contador_label = $contadorLabel
@onready var fondo_oscuro = $fondoOscuro

var contador := 3
var tween: Tween

func _ready():
	fondo_oscuro.modulate.a = 0.0
	contador_label.scale = Vector2.ZERO
	contador_label.modulate.a = 0.0
	contador_label.visible = true
	
	iniciar_cuenta_atras()


func iniciar_cuenta_atras():
	# Aparece el fondo oscuro al empezar
	var t = create_tween()
	t.tween_property(fondo_oscuro, "modulate:a", 0.5, 0.5)
	t.finished.connect(mostrar_numero)


func mostrar_numero():
	if contador < 0:
		finalizar_cuenta_atras()
		return
	
	contador_label.text = str(contador)
	contador_label.scale = Vector2.ZERO
	contador_label.modulate.a = 0.0

	tween = create_tween()
	tween.set_trans(Tween.TRANS_SINE)
	tween.set_ease(Tween.EASE_OUT)
	
	# Crece y aparece
	tween.tween_property(contador_label, "scale", Vector2(1, 1), 0.5)
	tween.parallel().tween_property(contador_label, "modulate:a", 1.0, 0.5)
	
	# Pausa breve, luego se desvanece
	tween.tween_interval(0.3)
	tween.tween_property(contador_label, "scale", Vector2(1.5, 1.5), 0.3)
	tween.parallel().tween_property(contador_label, "modulate:a", 0.0, 0.3)
	
	tween.finished.connect(func():
		contador -= 1
		mostrar_numero()
	)


func finalizar_cuenta_atras():
	# Desvanece el fondo y lanza la partida
	var t = create_tween()
	t.tween_property(fondo_oscuro, "modulate:a", 0.0, 0.5)
	t.finished.connect(func():
		iniciar_partida()
	)


func iniciar_partida():
	print("Game On")
	get_tree().root.get_node("game").startGame()
