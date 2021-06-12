extends Area2D

var dragMouse

func _ready():
	pass


func _process(delta):
	if not dragMouse:
		position = get_viewport().get_mouse_position()


func _on_Area2D_input_event(viewport, event, shape_idx):
	print("event")
	if event is InputEventMouseButton:
		if event.is_pressed:
			dragMouse = true
		else:
			dragMouse = false
