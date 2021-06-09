extends CanvasLayer

var is_paused = false

func _ready():
	pass

func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
		#var bounds = Rect2($MarginContainer/HBoxContainer/VBoxContainer/Buttons/Start.get_global_transform(), $MarginContainer/HBoxContainer/VBoxContainer/Buttons/Start.rect_size)
		var start = $MainMenu/HBoxContainer/VBoxContainer/Buttons/Start.get_global_rect()
		var options = $MainMenu/HBoxContainer/VBoxContainer/Buttons/Options.get_global_rect()
		var exit = $MainMenu/HBoxContainer/VBoxContainer/Buttons/Exit.get_global_rect()
		var credits = $MainMenu/HBoxContainer/VBoxContainer/Buttons/Credits.get_global_rect()
		var paused_continue = $PauseMenu/MarginContainer/HBoxContainer/Continue.get_global_rect()
		var paused_options = $PauseMenu/MarginContainer/HBoxContainer/Options.get_global_rect()
		var main_menu = $"PauseMenu/MarginContainer/HBoxContainer/Main Menu".get_global_rect()
		if start.has_point(event.position):
			pass
		elif options.has_point(event.position):
			pass
		elif exit.has_point(event.position):
			pass
		elif credits.has_point(event.position):
			pass
		elif is_paused:
			if paused_continue.has_point(event.position):
				pass
			elif paused_options.has_point(event.position):
				pass
			elif main_menu.has_point(event.position):
				pass

func _on_VolumeSlider_value_changed(value):
	pass # Replace with function body.
