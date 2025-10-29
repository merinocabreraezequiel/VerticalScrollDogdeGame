extends Node2D

@onready var texture_rect = $carretera01

var scroll_speed = 200.0
var scroll_offset = 0.0
var is_scrolling = true

func _process(delta):
	if not is_scrolling:
		return
	
	scroll_offset += scroll_speed * delta
	texture_rect.material.set_shader_parameter("scroll_y", scroll_offset)
